# Two types of datasets are proposed.
# Glasgow Data: contains average number of attendances other than
# population and intermediate zones data
# Edinburgh Data: does not contain number of attendances but can use 
# population data as a proxy

library(sf)
library(dplyr)
library(spdep)
library(spatialreg)
library(tmap)

# 1. Make geometry valid
plot_glasgow <- st_make_valid(plot_glasgow)

# 2. Separate polygons with attendance data (for fitting) vs without (for predicting)
train_data <- plot_glasgow %>%
  filter(!is.na(avg_NumberOfAttendancesAll), !is.na(TotPop2011))

predict_data <- plot_glasgow %>%
  filter(is.na(avg_NumberOfAttendancesAll) & !is.na(TotPop2011))

# 3. Build neighbours and weights for training set
nb_train <- poly2nb(train_data,  queen = TRUE)
lw_train <- nb2listw(nb_train, style = "W", zero.policy = TRUE)

# 4. Fit spatial lag model
sar_model <- lagsarlm(
  avg_NumberOfAttendancesAll ~ TotPop2011,
  data = train_data,
  listw = lw_train,
  zero.policy = TRUE
)

# 5. Predictions for training data (fitted values)
train_data$pred_attendances <- sar_model$fitted.values

# 6. Predictions for polygons without attendance data
#    → Need to build neighbours for these polygons together with training data
all_data <- bind_rows(train_data, predict_data)

nb_all <- poly2nb(all_data, queen = TRUE)
lw_all <- nb2listw(nb_all, style = "W", zero.policy = TRUE)

predict_data$pred_attendances <- as.numeric(predict(
  sar_model,
  newdata = predict_data,
  listw = lw_all,
  zero.policy = TRUE
))

train_data$pred_attendances <- as.numeric(train_data$pred_attendances)


# 7. Combine back into one dataset
plot_glasgow_pred <- bind_rows(train_data, predict_data)

# 8. Find polygon with maximum predicted attendances
max_zone <- plot_glasgow_pred %>%
  filter(pred_attendances == max(pred_attendances, na.rm = TRUE)) %>%
  select(INTERZONE, NAME, pred_attendances, geometry)

print(max_zone)

# 7. Identify max predicted zone
max_zone <- plot_glasgow_pred %>%
  filter(pred_attendances == max(pred_attendances, na.rm = TRUE))

# 8. Plot with X mark
tm_shape(plot_glasgow_pred) +
  tm_polygons("pred_attendances", palette = "Reds", title = "Predicted Attendances") +
  tm_shape(max_zone) +
  tm_symbols(shape = 4, size = 0.8, col = "black")  # shape=4 is an X



# Edinburgh


# problem with edinburgh is only 1 training data point


# 1. Separate known and unknown
known_site <- edinburgh_data %>%
  filter(!is.na(avg_NumberOfAttendancesAll)) %>%
  slice(1)  # Only 1 known

unknown_sites <- edinburgh_data %>%
  filter(is.na(avg_NumberOfAttendancesAll))

# 2. Scaling factor based on population
scaling_factor <- known_site$avg_NumberOfAttendancesAll / known_site$TotPop2011

# 3. Predict for unknowns
unknown_sites <- unknown_sites %>%
  mutate(pred_attendances = TotPop2011 * scaling_factor)

# 4. Add known site back with its actual attendance
known_site <- known_site %>%
  mutate(pred_attendances = avg_NumberOfAttendancesAll)

# 5. Combine
edinburgh_pred <- bind_rows(known_site, unknown_sites)

# 6. Identify max predicted
max_site <- edinburgh_pred %>%
  filter(pred_attendances == max(pred_attendances, na.rm = TRUE))

# 7. Plot with X
library(tmap)
tm_shape(edinburgh_pred) +
  tm_polygons("pred_attendances", palette = "Blues", title = "Predicted Attendances") +
  tm_shape(max_site) +
  tm_symbols(shape = 4, size = 0.8, col = "red")  # X marker


# Underserved zones Edinburgh


# 1. Calculate centroids of all intermediate zones (population zones)
zone_centroids <- st_centroid(edinburgh_data$geometry)

# 2. Extract hospitals: rows with non-NA HospitalCode
hospital_data <- edinburgh_data %>%
  filter(!is.na(HospitalCode))

# Calculate hospital centroids
hospital_centroids <- st_centroid(hospital_data$geometry)

# 3. Calculate distance matrix (zones x hospitals)
# This returns a matrix with distances in meters if CRS is projected
dist_matrix <- st_distance(zone_centroids, hospital_centroids)

# 4. Find minimum distance to hospital for each zone
min_distances <- apply(dist_matrix, 1, min)

# 5. Add centroid and min distance info back to data frame
edinburgh_data <- edinburgh_data %>%
  mutate(Centroid = zone_centroids,
         DistanceToNearestHospital = min_distances)

# 6. Set thresholds based on population and distance
median_pop <- median(edinburgh_data$TotPop2011, na.rm = TRUE)
threshold_pop <- 4000   # e.g., 30% above median population
threshold_dist <- 1500           

# 7. Identify underserved zones
underserved_zones <- edinburgh_data %>%
  filter(TotPop2011 > threshold_pop & DistanceToNearestHospital > threshold_dist)

# 8. Plot results
ggplot() +
  geom_sf(data = edinburgh_data, fill = "lightgray", color = "white") +
  geom_sf(data = hospital_data, color = "blue", size = 3, shape = 17) +  # existing hospitals
  geom_sf(data = underserved_zones, fill = "red", alpha = 0.6) +          # underserved zones
  geom_sf_text(data = underserved_zones, aes(label = TotPop2011), size = 3, color = "black") +
  labs(title = "Underserved Intermediate Zones in Edinburgh",
       subtitle = "Zones with high population and >1.5 km from nearest hospital",
       caption = "Blue triangles: Existing hospitals; Red zones: Potential new hospital sites") +
  theme_minimal()

library(sf)
library(dplyr)

# Separate hospital and non-hospital zones
hospital_zones <- plot_glasgow %>% filter(!is.na(HospitalName) & HospitalName != "")
non_hospital_zones <- plot_glasgow %>% filter(is.na(HospitalName) | HospitalName == "")

# Identify hospital zones with very high waiting times or episodes
high_wait_hospitals <- hospital_zones %>%
  filter(
    avg_NumberOver4HoursEpisode > quantile(avg_NumberOver4HoursEpisode, 0.8, na.rm=TRUE) |
      avg_NumberOver12HoursEpisode > quantile(avg_NumberOver12HoursEpisode, 0.8, na.rm=TRUE)
  )

# Find non-hospital zones within a certain distance (e.g. 2 km) of these high-wait hospital zones
buffer_distance <- 2000  # meters

# Create buffers around high wait hospital zones
high_wait_buffers <- st_buffer(high_wait_hospitals, dist = buffer_distance)

# Find non-hospital zones intersecting those buffers
candidate_zones <- non_hospital_zones[st_intersects(non_hospital_zones, high_wait_buffers, sparse = FALSE), ]

# Score candidates by population and proximity to multiple high-wait hospitals
# Calculate distances from candidate zones to each high wait hospital
dist_matrix <- st_distance(st_centroid(candidate_zones), st_centroid(high_wait_hospitals))

# Weight distances by hospital waiting times (e.g. avg_NumberOver12HoursEpisode)
weights <- high_wait_hospitals$avg_NumberOver12HoursEpisode
weights[is.na(weights)] <- 0

# Weighted distance sum for each candidate zone
weighted_dist_sums <- apply(dist_matrix, 1, function(dists) sum(dists * weights))

# Incorporate population to prioritize zones with more people potentially affected
pop_factor <- candidate_zones$POPULATION / max(candidate_zones$POPULATION, na.rm=TRUE)

# Final score: weighted distance sum adjusted by population (lower better)
final_scores <- weighted_dist_sums / pop_factor

# Pick the best candidate zone
best_index <- which.min(final_scores)
best_location <- candidate_zones[best_index, ]

print(best_location)

# You can plot it similarly as before to visualize

# 7. Plot results
ggplot() +
  geom_sf(data = plot_glasgow, fill = "grey80") +
  geom_sf(data = high_wait_zones, fill = "red", alpha = 0.6) +
  geom_sf(data = best_location, color = "blue", size = 4) +
  ggtitle("Best New Hospital Location Candidate in Glasgow")

# Assuming final_scores, candidate_zones already calculated

# Get indices of top 3 candidates with lowest scores
top3_indices <- order(final_scores)[1:3]
top3_locations <- candidate_zones[top3_indices, ]

print(top3_locations)

# Plotting the results with ggplot2
library(ggplot2)

ggplot() +
  geom_sf(data = plot_glasgow, fill = "grey80") +
  geom_sf(data = high_wait_hospitals, fill = "red", alpha = 0.6, size = 2) +
  geom_sf(data = top3_locations, color = "blue", size = 4) +
  ggtitle("Top 3 Candidate Locations for New Hospital in Glasgow") +
  labs(caption = "Red Zones: existing hospital with high waiting times and long episodes \n
       Blue Zones: Best new zones to ease overly crowded hospitals")
  theme_minimal()


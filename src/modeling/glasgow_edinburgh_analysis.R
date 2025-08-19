library(dplyr)

setwd("C:\\Users\\glauc\\Desktop\\PHS\\Operational_A-E\\data\\monthly_ae_activity_202505.csv")

data_activity <- read.csv("monthly_ae_activity_202505.csv")
data_activity <- data_activity[data_activity$AttendanceCategory == "All",]
data_activity$AttendanceCategory <- NULL
data_activity$PercentageOver12HoursEpisode <- NULL
data_activity$PercentageOver12HoursEpisodeQF <- NULL
data_activity$PercentageOver8HoursEpisode <- NULL
data_activity$PercentageOver8HoursEpisodeQF <- NULL
data_activity$PercentageWithin4HoursAll <- NULL
data_activity$PercentageWithin4HoursEpisode <- NULL
data_activity$PercentageWithin4HoursEpisodeQF <- NULL
data_activity$NumberOfAttendancesEpisodeQF <- NULL
data_activity$NumberOver12HoursEpisodeQF <- NULL
data_activity$NumberOver4HoursEpisodeQF <- NULL
data_activity$NumberOver8HoursEpisodeQF <- NULL


data_activity <- data_activity %>%
  group_by(TreatmentLocation, Country, HBT, DepartmentType) %>%
  summarise(across(
    where(is.numeric),
    ~ mean(.x, na.rm = TRUE),
    .names = "avg_{.col}"
  ))

data_activity$avg_Month <- NULL

data_hospital <- read.csv("hospitals.csv")
data_hospital <- data_hospital[,c(1,2,10:15),]

# Selecting only relevant hospitals for Edinburgh and Glasgow area

selected_hospitals <- c("S217H", "S314H", "S319H",
                        "S209H", "S203H", "S116H",
                        "S320H", "G405H", "G107H",
                        "G306H", "G505H", "G517H")

data_hospital <- data_hospital[data_hospital$HospitalCode %in% selected_hospitals,]


hos_act <- left_join(data_hospital, data_activity, by = c("HospitalCode" = "TreatmentLocation"))


library(sf)

zones_sf <- st_read("SG_IntermediateZone_Bdry_2011.shp")

zones_sf$HHCnt2011 <- NULL

merged_sf <- left_join(hos_act, zones_sf, by = c("IntermediateZone" = "InterZone"))



# If it's not sf, re-convert it:
merged_sf <- st_as_sf(merged_sf)

# Make sure the geometry column is correctly set
st_geometry(merged_sf) <- "geometry"


# Check the structure
str(merged_sf)
class(merged_sf)
st_geometry(merged_sf)

# Reproject to WGS84 (EPSG:4326)
merged_sf_wgs84 <- st_transform(merged_sf, crs = 4326)

# Only Glasgow

data.glasgow <- read.csv("attendances.csv")

plot_glasgow <- left_join(data.glasgow, zones_sf, by = c("INTERZONE" = "InterZone"))
plot_glasgow <- st_as_sf(plot_glasgow)
plot(st_geometry(plot_glasgow), col = "lightblue", border = "gray")

plot_glasgow <- left_join(plot_glasgow, hos_act, by = c("INTERZONE" = "IntermediateZone"))

save(plot_glasgow, file = "glasgow.RData")




library(ggplot2)


# Count hospitals per intermediate zone
hospital_counts <- plot_glasgow %>%
  st_set_geometry(NULL) %>%        # drop geometry for summary
  group_by(INTERZONE) %>%
  summarise(num_hospitals = sum(!is.na(HospitalName) & HospitalName != ""))

# Join counts back to spatial data
plot_glasgow <- plot_glasgow %>%
  left_join(hospital_counts, by = "INTERZONE") %>%
  mutate(num_hospitals = ifelse(is.na(num_hospitals), 0, num_hospitals))

# Filter zones with hospitals
zones_with_hospitals <- plot_glasgow %>% filter(num_hospitals > 0)

# Plot
ggplot() +
  geom_sf(data = plot_glasgow, aes(fill = POPULATION), color = "grey40", alpha = 0.7) +
  scale_fill_viridis_c(option = "plasma", name = "Population") +
  geom_sf(data = zones_with_hospitals, fill = NA, color = "red", size = 1) +
  geom_sf_text(data = zones_with_hospitals, aes(label = num_hospitals), 
               size = 5, color = "black", fontface = "bold") +
  theme_minimal() +
  labs(title = "Glasgow Intermediate Zones Colored by Population",
       subtitle = "Number of Hospitals per Zone (only zones with hospitals labeled)") +
  theme(legend.position = "right")



# Can I do it for edinburgh?
edi_sf <- st_read("royalties_municipal.shp")
edi_sf <- edi_sf[edi_sf$Ward == "1832", "geometry"]
edi_sf <- st_transform(edi_sf, st_crs(plot_glasgow))


# Spatial filter: keep only zones intersecting Edinburgh boundary
edinburgh_iz <- zones_sf[st_intersects(zones_sf, edi_sf, sparse = FALSE), ]

# Check the result
print(edinburgh_iz %>% select(InterZone, Name))

# Optionally, plot to verify
library(ggplot2)

ggplot() +
  geom_sf(data = edinburgh_iz, fill = "orange", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Intermediate Zones inside Edinburgh Boundary")

edinburgh_data <- right_join(hos_act, edinburgh_iz, by = c("IntermediateZone" = "InterZone"))

edinburgh_data <- st_as_sf(edinburgh_data)

# Count hospitals per intermediate zone
hospital_counts <- edinburgh_data %>%
  st_set_geometry(NULL) %>%        # drop geometry for summary
  group_by(IntermediateZone) %>%
  summarise(num_hospitals = sum(!is.na(HospitalName) & HospitalName != ""))

# Join counts back to spatial data
edinburgh_data <- edinburgh_data %>%
  left_join(hospital_counts, by = "IntermediateZone") %>%
  mutate(num_hospitals = ifelse(is.na(num_hospitals), 0, num_hospitals))

# Filter zones with hospitals
zones_with_hospitals <- edinburgh_data %>% filter(num_hospitals > 0)

# Plot
ggplot() +
  geom_sf(data = edinburgh_data, aes(fill = TotPop2011), color = "grey40", alpha = 0.7) +
  scale_fill_viridis_c(option = "plasma", name = "Population") +
  geom_sf(data = zones_with_hospitals, fill = NA, color = "red", size = 1) +
  geom_sf_text(data = zones_with_hospitals, aes(label = num_hospitals), 
               size = 5, color = "black", fontface = "bold") +
  theme_minimal() +
  labs(title = "Edinburgh Intermediate Zones Colored by Population",
       subtitle = "Number of Hospitals per Zone (only zones with hospitals labeled)") +
  theme(legend.position = "right")

save(edinburgh_data, file = "edinburgh.RData")

data_pop <- read.csv("dz2011-pop-est_21112024.csv")

data_pop <- data_pop[data_pop$Year == 2022,]
data_pop <- data_pop[data_pop$Sex == "All",]

data_hospital <- read.csv("hospitals.csv")

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
data_activity$NumberWithin4HoursEpisodeQF <- NULL

data_hospital$AddressLine1 <- NULL
data_hospital$AddressLine2 <- NULL
data_hospital$AddressLine2QF <- NULL
data_hospital$AddressLine3 <- NULL
data_hospital$AddressLine3QF <- NULL
data_hospital$AddressLine4 <- NULL
data_hospital$AddressLine4QF <- NULL

names(data_hospital)
names(data_activity)

library(dplyr)

merged_data <- left_join(data_activity, data_hospital, 
                         by = c("TreatmentLocation" = "HospitalCode"))


data_pop <- data_pop[data_pop$DataZoneQF == "",]
data_pop$DataZoneQF <- NULL
data_pop$Sex <- NULL

data_pop$SexQF <- NULL

library(tidyverse)

data_pop <- data_pop %>%
  pivot_longer(
    cols = starts_with("Age"),         # Selects Age0 to Age46
    names_to = "Age",                  # New column for age names
    values_to = "Population"           # Values go into 'Population'
  )


data_pop <- data_pop %>%
  mutate(Age = as.integer(str_remove(Age, "Age")))

data_pop$Age[is.na(data_pop$Age)] <- "90+"

final_data <- right_join(merged_data, data_pop, by = "DataZone")

year <- c("202406", "202407", "202408", "202409", "202410",
          "202411", "202412", "202501", "202502", "202503",
          "202504", "202505")

final_data <- final_data[final_data$Month %in% year,]

write.csv(final_data, "FINAL_DATA.csv")

final_data <- read.csv("FINAL_DATA.csv")

locations <- read.csv("scottish-government-urban-rural-classification-2020-data-zone-2011-lookup.csv")

library(tidyverse)
library(magrittr)
library(sf)
dz <- st_read("SG_DataZone_Bdry_2011.shp")
selected <- dz %>% filter(DataZone %in% final_data$DataZone)
final_sf <- left_join(selected, final_data, by = c("DataZone"="DataZone"))


library(ggplot2)

geom_data <- final_sf %>% group_by(DataZone, geometry) %>% summarise(pop = mean(Population))

library(rnaturalearth)
library(rnaturalearthdata)

# Get UK basemap
uk_regions <- ne_states(country = "United Kingdom", returnclass = "sf")
scotland <- uk_regions %>% filter(geonunit == "Scotland")
# Plot
ggplot() +
  geom_sf(data = scotland, fill = "gray95", color = "gray70") +
  geom_sf(data = geom_data, fill = "lightblue", color = "black", alpha = 0.7) +
  xlim(c(8,1)) +
  labs(title = "DataZones from the Dataset") +
  theme_minimal()

# Basic plot of the geometry
ggplot(data = geom_data) +
  geom_sf(fill = "lightblue", color = "black") +
  labs(title = "Map of Spatial Data Zones") +
  theme_minimal()


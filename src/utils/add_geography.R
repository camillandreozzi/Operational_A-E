# Add geographical locations to Data Zones

final_data <- read.csv("FINAL_DATA.csv")

locations <- read.csv("scottish-government-urban-rural-classification-2020-data-zone-2011-lookup.csv")

library(tidyverse)
library(magrittr)
library(sf)
dz <- st_read("SG_DataZone_Bdry_2011.shp")
selected <- dz %>% filter(DataZone %in% final_data$DataZone)
final_sf <- left_join(selected, final_data, by = c("DataZone"="DataZone"))

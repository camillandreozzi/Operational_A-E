#Grouped Data no Time

library(readxl)
library(ggplot2)
library(tidyverse)
library(gridExtra)

setwd("~/Desktop/Operational Research EDI")
data <- read_excel("OR_AE2_Project_Adjusted.xlsx")
#Remove temporal 
data.num <- data
data.num$Wait_Time <- factor(data$Wait_Time, levels = c(
  "00-29", "30-59", "60-89" , "90-119" , "120-149", "150-179", "180-209", "210-239", "240-269",
  "270-299", "300-329","360+"), ordered = T)
data.num <-  data.num %>% mutate(Mean_Wait_Time = case_match(.x = Wait_Time,"00-29" ~ 15, "30-59" ~ 45, "90-119" ~ 105,
                                                                   "120-149" ~ 135, "150-179" ~ 165,
                                                                   "180-209" ~ 195,"210-239" ~ 225,
                                                                   "240-269" ~ 255, "270-299" ~ 285,
                                                                   "300-329" ~ 315, "360+" ~ 345))
data.num <-  data.num %>% mutate(Binary_Wait_Time = case_match(.x = Wait_Time,"00-29" ~ 0, "30-59" ~ 0, "90-119" ~ 1,
                                                                     "120-149" ~ 1, "150-179" ~ 1,
                                                                     "180-209" ~ 1,"210-239" ~ 1,
                                                                     "240-269" ~ 1, "270-299" ~ 1,
                                                                     "300-329" ~ 1, "360+" ~ 1))
data.num1 <- data.num %>% group_by(Month, Year, Site_Code, Pat_X, Pat_Y,
                                        Attendance_Type, Age_Group) %>%
  summarise(Mean_Wait_Time = mean(Mean_Wait_Time, na.rm = T), .groups = "keep")

## Sites
# add sites info
sites <- data %>% group_by(Site_Code, Site_Loc_GPs, Site_Loc_GP_List, Site_Pop_20miles, Site_X, Site_Y) %>% summarise(min = min(Drive_Distance_Miles))
sites <- sites[,-7]

data.num2 <- merge(data.num1, sites, by = "Site_Code", all.x = T)


## Patients
# add patients info
patients <- data %>% group_by(Pat_X, Pat_Y, Pat_Loc_GPs, Pat_Loc_GP_List) %>% summarise(min = min(Drive_Distance_Miles))
patients <- patients[,-5]

data.summary <- merge(data.num2, patients, by = c("Pat_X"), all.x = T)

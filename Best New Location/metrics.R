## Metrics 


library(readxl)
library(tidyverse)
library(magrittr)

setwd("~/Desktop/Operational Research EDI")
data <- read_excel("OR_AE2_Project_Adjusted.xlsx")

#### Data Cleaning and Interpolation ####

data$Number_Of_Attendances <- as.numeric(data$Number_Of_Attendances)
repetitions <- data$Number_Of_Attendances

data <- data[rep(seq_len(nrow(data)), repetitions), -19]

data$Site_Code <- as.factor(data$Site_Code)
data$Site_Type <- as.factor(data$Site_Type)

n_miles <- table(data$Drive_Distance_Miles)

set.seed(1)

data$Drive_Distance_Miles[data$Drive_Distance_Miles == "00 to 05"] <- runif(n_miles[1],0,5)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "05 to 10"] <- runif(n_miles[2],5,10)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "10 to 15"] <- runif(n_miles[3],10,15)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "15 to 20"] <- runif(n_miles[4],15,20)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "20 to 25"] <- runif(n_miles[5],20,25)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "25 to 30"] <- runif(n_miles[6],25,30)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "30 to 35"] <- runif(n_miles[7],30,35)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "35 to 40"] <- runif(n_miles[8],35,40)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "40 to 45"] <- runif(n_miles[9],40,45)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "45 to 50"] <- runif(n_miles[10],45,50)
data$Drive_Distance_Miles[data$Drive_Distance_Miles == "50 to 55"] <- runif(n_miles[11],50,55)

n_mins <- table(data$Driving_Time_mins)

data$Driving_Time_mins[data$Driving_Time_mins == "00 to 05"] <- runif(n_mins[1],0,5)
data$Driving_Time_mins[data$Driving_Time_mins == "05 to 10"] <- runif(n_mins[2],5,10)
data$Driving_Time_mins[data$Driving_Time_mins == "10 to 15"] <- runif(n_mins[3],10,15)
data$Driving_Time_mins[data$Driving_Time_mins == "15 to 20"] <- runif(n_mins[4],15,20)
data$Driving_Time_mins[data$Driving_Time_mins == "20 to 25"] <- runif(n_mins[5],20,25)
data$Driving_Time_mins[data$Driving_Time_mins == "25 to 30"] <- runif(n_mins[6],25,30)
data$Driving_Time_mins[data$Driving_Time_mins == "30 to 35"] <- runif(n_mins[7],30,35)
data$Driving_Time_mins[data$Driving_Time_mins == "35 to 40"] <- runif(n_mins[8],35,40)
data$Driving_Time_mins[data$Driving_Time_mins == "40 to 45"] <- runif(n_mins[9],40,45)
data$Driving_Time_mins[data$Driving_Time_mins == "45 to 50"] <- runif(n_mins[10],45,50)
data$Driving_Time_mins[data$Driving_Time_mins == "50 to 55"] <- runif(n_mins[11],50,55)
data$Driving_Time_mins[data$Driving_Time_mins == "55 to 60"] <- runif(n_mins[12],55,60)
data$Driving_Time_mins[data$Driving_Time_mins == "60 to 65"] <- runif(n_mins[13],60,65)
data$Driving_Time_mins[data$Driving_Time_mins == "65 to 70"] <- runif(n_mins[14],65,70)
data$Driving_Time_mins[data$Driving_Time_mins == "70 to 75"] <- runif(n_mins[15],70,75)
data$Driving_Time_mins[data$Driving_Time_mins == "75 to 80"] <- runif(n_mins[16],75,80)
data$Driving_Time_mins[data$Driving_Time_mins == "80 to 85"] <- runif(n_mins[17],80,85)
data$Driving_Time_mins[data$Driving_Time_mins == "85 to 90"] <- runif(n_mins[18],85,90)

n_age <- table(data$Age_Group)

data$Age_Group[data$Age_Group == "20-39"] <- runif(n_age[1],20,39)
data$Age_Group[data$Age_Group == "40-59"] <- runif(n_age[2], 40,59)
data$Age_Group[data$Age_Group == "60-79"] <- runif(n_age[3],60,79)
data$Age_Group[data$Age_Group == "80+"] <- 80 + rchisq(n_age[4], 5)
data$Age_Group[data$Age_Group == "Missing"] <- NA

data$Year <- factor(data$Year, ordered = T)
data$Month <- factor(data$Month, ordered = T)

n_wait <- table(data$Wait_Time)

data$Wait_Time[data$Wait_Time == "00-29"] <- runif(n_wait[1],0,29)
data$Wait_Time[data$Wait_Time == "120-149"] <- runif(n_wait[2],120,149)
data$Wait_Time[data$Wait_Time == "150-179"] <- runif(n_wait[3],150,179)
data$Wait_Time[data$Wait_Time == "180-209"] <- runif(n_wait[4],180,209)
data$Wait_Time[data$Wait_Time == "210-239"] <- runif(n_wait[5],210,239)
data$Wait_Time[data$Wait_Time == "240-269"] <- runif(n_wait[6],240,269)
data$Wait_Time[data$Wait_Time == "270-299"] <- runif(n_wait[7],270,299)
data$Wait_Time[data$Wait_Time == "30-59"] <- runif(n_wait[8],30,59)
data$Wait_Time[data$Wait_Time == "300-329"] <- runif(n_wait[9],300,359)
data$Wait_Time[data$Wait_Time == "360+"] <- 360 + rchisq(n_age[4], 5)
data$Wait_Time[data$Wait_Time == "60-89"] <- runif(n_wait[11],60,89)
data$Wait_Time[data$Wait_Time == "90-119"] <- runif(n_wait[12],90,119)

data$Wait_Time <- as.numeric(data$Wait_Time)
data$Drive_Distance_Miles <- as.numeric(data$Drive_Distance_Miles)
data$Driving_Time_mins <- as.numeric(data$Driving_Time_mins)
data$Age_Group <- as.numeric(data$Age_Group)
data$Attendance_Type <- as.factor(data$Attendance_Type)

ggplot(data, aes(x = Wait_Time))+
  geom_histogram() # The un-uniform structure is due to the mistake in 
# the data collection, no data between 329 and 360

data <- data %>% mutate(Total_Time = Driving_Time_mins + Wait_Time)

# Create a regression model aiming to explain the number of attendances

data.p <- data %>% group_by(Site_Code, Month, Year,
                            Site_Type, Pat_X, Pat_Y, Site_X, Site_Y) %>%
  summarise(n = n(), .groups = "keep")

# 1. Create a new variable for distance
data.p <- data.p %>% mutate(Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2))

load("best_new_site_model.Rdata")

# Data Preparation
data.p$Month <- as.factor(data.p$Month)
data.p$Year <- as.factor(data.p$Year)
data.p$Site_Type <- as.factor(data.p$Site_Type)

# Poisson regression is used because `n` is a count variable
model.glm <- glm(n ~ Site_Type + Month + Year + Distance, 
                 data = data.p, 
                 family = poisson(link = "log"))

# Coordinates for best new site
coord.new <- c(optimal_coords[1,1], optimal_coords[1,2])

# Get unique patient locations
unique_patients <- unique(data.p[, c("Pat_X", "Pat_Y")])

# Get unique combinations of Month and Year
unique_time <- expand.grid(
  Month = unique(data.p$Month),
  Year = unique(data.p$Year)
)
# Combine patient locations with time combinations
new_site <- merge(unique_patients, unique_time)

new_site <- cbind(new_site,
                  Site_Code = "12",
                  Site_X = coord.new[1],
                  Site_Y = coord.new[2],
                  Site_Type = "ED"
)

new_site <- new_site %>% mutate(Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
                                n = 0)

new_site$n <- predict(model.glm, newdata = new_site, type = "response")

total_new_site <- round(sum(new_site$n))
total <- sum(data.p$n)
to.redistribute <- round(total - total_new_site)

set.seed(1)
totaltime.after.new.site <- c(data$Total_Time[sample.int(nrow(data), to.redistribute)], rep(0, total_new_site))
new.average.total.time <- mean(totaltime.after.new.site, na.rm =T)
new.average.total.time
# 146.277
old.average.total.time <- mean(data$Total_Time)
old.average.total.time
# 176.1258
impact <- (old.average.total.time - new.average.total.time) / old.average.total.time

(old.average.total.time - new.average.total.time)
# 29.84883
print(impact)
# 0.1694745

# VS empirical approach coordinates

coords.emp <- c(10640.01507538, 105690.53768844)

# Get unique patient locations
unique_patients <- unique(data.p[, c("Pat_X", "Pat_Y")])

# Get unique combinations of Month and Year
unique_time <- expand.grid(
  Month = unique(data.p$Month),
  Year = unique(data.p$Year)
)
# Combine patient locations with time combinations
new_site <- merge(unique_patients, unique_time)

new_site <- cbind(new_site,
                  Site_Code = "12",
                  Site_X = coords.emp[1],
                  Site_Y = coords.emp[2],
                  Site_Type = "ED"
)

new_site <- new_site %>% mutate(Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
                                n = 0)

new_site$n <- predict(model.glm, newdata = new_site, type = "response")

total_new_site <- round(sum(new_site$n))
total <- sum(data.p$n)
to.redistribute <- round(total - total_new_site)

set.seed(1)
totaltime.after.new.site <- c(data$Total_Time[sample.int(nrow(data), to.redistribute)], rep(0, total_new_site))
new.average.total.time <- mean(totaltime.after.new.site, na.rm =T)
new.average.total.time
#166.7754
old.average.total.time <- mean(data$Total_Time)
old.average.total.time
# 176.1258
impact <- (old.average.total.time - new.average.total.time) / old.average.total.time

(old.average.total.time - new.average.total.time)
# 9.350464
print(impact)
# 0.05308968



# Both
coords.emp <- c(10640.01507538, 105690.53768844)
coords.glm <- c(optimal_coords[1,1], optimal_coords[1,2])
unique_patients <- unique(data.p[, c("Pat_X", "Pat_Y")])
# Get unique combinations of Month and Year
unique_time <- expand.grid(
  Month = unique(data.p$Month),
  Year = unique(data.p$Year)
)
new_site_glm <- merge(unique_patients, unique_time)
new_site_emp <- merge(unique_patients, unique_time)

new_site_glm <- cbind(new_site_glm,
                  Site_Code = "12",
                  Site_X = coords.glm[1],
                  Site_Y = coords.glm[2],
                  Site_Type = "ED"
)

new_site_glm <- new_site_glm %>% mutate(Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
                                n = 0)

new_site_emp <- cbind(new_site_emp,
                      Site_Code = "13",
                      Site_X = coords.emp[1],
                      Site_Y = coords.emp[2],
                      Site_Type = "ED"
)
new_site_emp <- new_site_emp %>% mutate(Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
                                        n = 0)

new_sites <- rbind(new_site_emp, new_site_glm)
new_sites$n <- predict(model.glm, newdata = new_sites, type = "response")

total_new_sites <- round(sum(new_sites$n))
total <- sum(data.p$n)
to.redistribute <- round(total - total_new_sites)


set.seed(1)
totaltime.after.new.sites <- c(data$Total_Time[sample.int(nrow(data), to.redistribute)], rep(0, total_new_sites))
new.average.total.time <- mean(totaltime.after.new.sites, na.rm =T)
new.average.total.time
# 136.9371
old.average.total.time <- mean(data$Total_Time)
old.average.total.time
# 176.1258
impact <- (old.average.total.time - new.average.total.time) / old.average.total.time

(old.average.total.time - new.average.total.time)
# 39.18872
print(impact)
# 0.2225041


# Metrics Distance

# Define a function to calculate Euclidean distance
euclidean_distance <- function(point1, point2) {
  sqrt(sum((point1 - point2)^2))
}

# Example: vector of x, y coordinates
coordinates <- data %>% group_by(Pat_X, Pat_Y) %>% summarise(X = mean(Pat_X), .groups = "keep") %>%
  select(Pat_X, Pat_Y)
colnames(coordinates) <- c("x", "y")

# Define the reference point
reference_point <- c(coords.glm[1], coords.glm[2])

# Calculate distances
distances <- apply(coordinates, 1, function(coord) {
  euclidean_distance(coord, reference_point)
})

# Output average distance
average_distance <- mean(distances)

# Print results
cat("Distances:\n", distances, "\n")
cat("Average Distance:", average_distance, "\n")

# Average Distance: 16126.08 



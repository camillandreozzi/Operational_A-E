## Modellare le preferenze dei siti

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

data <- data %>% mutate(Sum_Time = Driving_Time_mins + Wait_Time)

data.p <- data %>% group_by(Site_Code, Month, Year,
                            Site_Type, Site_Loc_GPs,
                            Site_Loc_GP_List, Site_Pop_20miles) %>%
  summarise(n = n(), .groups = "keep")

#data.p <- merge(data.p, data, by = c("Site_Code", "Month", "Year"))

data.p$n <- as.numeric(data.p$n)
data.p$Site_Code <- as.factor(data.p$Site_Code)
data.p$Month <- as.factor(data.p$Month)
data.p$Year <- as.factor(data.p$Year)

# Linear Mixed model
library(lme4)
model.p <- lmer(n ~ Site_Code + (1|Month) + (1|Year), data = data.p)
summary(model.p)

# The variance for the random effect of Month is 0, meaning that there is 
#no variation in the intercept for different months in your dataset. 
#This suggests that the number of attendees does not vary by month when 
#controlling for other factors (in this case, Site_Code).

# The variance for Year is 10,074, and the standard deviation is 100.4. 
# This indicates that there is significant variation in the number of 
# attendees across different years. 
# So, Year contributes meaningfully as a random effect.
# Site_Code coefficients: The estimates for Site_Code2, Site_Code3, ..., 
# Site_Code11 represent the deviation in the number of attendees for each
# hospital relative to the reference hospital (Site_Code1):
# Site_Code2 has an estimated increase of 3058.7 attendees compared 
# to Site_Code1 (with a highly significant t-value of 15.816).
# Site_Code3 has an estimated decrease of 1866.0 attendees compared to 
# Site_Code1, with a significant negative impact on the number of attendees (t-value = -9.649).
# Site_Code11 has an estimated increase of 6493.5 attendees, making it significantly 
# higher than the reference group (Site_Code1), with a very large t-value of 33.576.
# In general, the coefficients for Site_Code show large variations 
# in the number of attendees across different hospitals. 
# Some hospitals (like Site_Code2 and Site_Code11) have much higher attendance 
# compared to others (like Site_Code3 and Site_Code9), and this is statistically 
# significant based on their t-values.

data.p <- data %>% group_by(Site_Code, Month, Year,
                            Site_Type, Pat_X, Pat_Y) %>%
  summarise(n = n(), .groups = "keep")

# 1. Predicting the Likelihood of a Patient Visiting a Site (Classification Model)
set.seed(1)
train.index <- sample.int(nrow(data), 0.7*nrow(data))
train <- data[train.index,]
test <- data[setdiff(1:nrow(data),train.index),]

library(ranger)
# model_rf <- ranger(Site_Code ~ Pat_X + Pat_Y + Site_Type + Month + Year, data = train)
# save(model_rf, file = "modelRf.Rdata")
load("modelRf.Rdata")
predictions <- predict(model_rf, data = test[,-1])

library(caret)


# Ensure predictions are factors
predict_values <- factor(predictions$predictions, levels = levels(test$Site_Code))

# Ensure actual values (test$Site_Code) are factors
actual_values <- factor(test$Site_Code)

# Now, generate the confusion matrix
conf_matrix <- confusionMatrix(predict_values, actual_values)

# Print the confusion matrix
print(conf_matrix)


# 2. Predicting the Number of Patients Visiting a Site (Regression Model)

# Create a regression model aiming to explain the number of attendances

data.p <- data %>% group_by(Site_Code, Month, Year,
                            Site_Type, Pat_X, Pat_Y, Site_X, Site_Y) %>%
  summarise(n = n(), .groups = "keep")

# 1. Create a new variable for distance
data.p <- data.p %>% mutate(Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2))

# 2. Build the model (Try 1 = RANDOM FOREST)

#
set.seed(1)
trainp.index <- sample.int(nrow(data.p), 0.6*nrow(data.p))
trainp <- data.p[trainp.index,]
testp <- data.p[setdiff(1:nrow(data.p),trainp.index),]
#

model_n <- ranger(n ~ Distance + Site_Type + Month + Year, data = trainp, importance = "impurity")
predictions <- predict(model_n, data = testp[,-9])

predict_values <- predictions$predictions
actual_values <- testp[,9]
df <- data.frame(Predictions = predictions$predictions, Actual = testp[,9])

plot(df[,1], df[,2])

# importance
# Extract the importance of variables
importance_values <- model_n$variable.importance

# Create a data frame for plotting
importance_df <- data.frame(
  Variable = names(importance_values),
  Importance = importance_values
)

# Sort the data frame by importance
importance_df <- importance_df[order(importance_df$Importance, decreasing = TRUE), ]

# Plot the feature importance
ggplot(importance_df, aes(x = reorder(Variable, Importance), y = Importance)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  labs(title = "Feature Importance", x = "Variable", y = "Importance") +
  theme_minimal()

# Now, we add the new coordinates and new Site as a new entry

# Coordinates for best new site
coord.new <- c(10640.01507538, 105690.53768844)


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


new_site$n <- predict(model_n, data = new_site)$predictions

total_new_site <- sum(new_site$n)
total <- sum(data.p$n)
to.redistribute <- total - total_new_site

# Step 3: Analyze the impact of adding the new site
data.p <- data.p %>%
  mutate(new_n = n / total * to.redistribute, #This is a proportional approach
         # so the percentage removed from each of the site is constant
         # no matter the new site location. The only thing changing
         # is the magnitude
         diff = new_n-n) 


## Compute Impact insights
impact_summary <- data.p %>%
  group_by(Site_Code) %>%
  summarise(diff = sum(diff), percentage_diff = diff/n())
impact <- sum(impact_summary$diff) / total

ggplot(impact_summary, aes(x = Site_Code, y = percentage_diff, fill = percentage_diff > 0)) +
  geom_bar(stat = "identity") +
  labs(title = "Change in Attendance After Adding New Site",
       x = "Site Code", y = "Change in Attendance")

ggplot(data_new_site, aes(x = Site_X, y = Site_Y)) +
  geom_point(aes(size = predicted_n, color = Site_Code)) +
  geom_point(data = new_site, aes(x = Site_X, y = Site_Y), color = "red", size = 4, shape = 17) +
  labs(title = "Patient Redistribution with New Site",
       x = "Longitude", y = "Latitude") +
  theme_minimal()


## MIU/OTHER assumption now

new_site_m <- merge(unique_patients, unique_time)

new_site_m <- cbind(new_site_m,
                  Site_Code = "12",
                  Site_X = coord.new[1],
                  Site_Y = coord.new[2],
                  Site_Type = "MIU/OTHER"
)


new_site_m$n <- predict(model_n, data = new_site)$predictions

total_new_site_m <- sum(new_site_m$n)
total <- sum(data.p$n)
to.redistribute_m <- total - total_new_site_m

# Step 3: Analyze the impact of adding the new site
data.p <- data.p %>%
  mutate(new_n = n / total * to.redistribute_m,
         diff = new_n-n) 


impact_summary_m <- data.p %>%
  group_by(Site_Code) %>%
  summarise(diff = sum(diff), percentage_diff = diff/n())
impact_m <- sum(impact_summary$diff) / total
# Compute Key Insights


#### New Site New Approach ####

# ED assumption

evaluate_new_site_rf <- function(new_site_coords, data = data.p, model = model_n, total_patients = total_patients){
  new_x <- new_site_coords[1]
  new_y <- new_site_coords[2]
  
  unique_patients <- unique(data[, c("Pat_X", "Pat_Y")])
  unique_time <- expand.grid(
    Month = unique(data$Month),
    Year = unique(data$Year)
  )
  new_site <- merge(unique_patients, unique_time)
  new_site <- cbind(new_site,
                    Site_Code = "12",
                    Site_X = new_x,
                    Site_Y = new_y,
                    Site_Type = "ED" 
  )
  
  new_site <- new_site %>% mutate(
    Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
    n = 0
  )
  
  new_site$n <- predict(model, data = new_site)$predictions
  
  total_new_site <- sum(new_site$n)
  total <- sum(data.p$n)
  to.redistribute <- total - total_new_site
  
  # Step 3: Analyze the impact of adding the new site
  data.p <- data.p %>%
    mutate(new_n = n / total * to.redistribute, #This is a proportional approach
           # so the percentage removed from each of the site is constant
           # no matter the new site location. The only thing changing
           # is the magnitude
           diff = new_n-n) 
  
  
  ## Compute Impact insights
  impact_summary <- data.p %>%
    group_by(Site_Code) %>%
    summarise(diff = sum(diff), percentage_diff = diff/n())
  impact <- sum(impact_summary$diff) / total

  return(impact)
}

# Define bounds for the search 
x_bounds <- c(min(data.p$Pat_X), max(data.p$Pat_X))
y_bounds <- c(min(data.p$Pat_Y), max(data.p$Pat_Y))

library(optim)

objective_function <- function(coords, data, model, total_patients) {
  impact <- evaluate_new_site_rf(
    new_site_coords = coords,
    data = data,
    model = model,
    total_patients = total_patients
  )
  # Change this for maximization/minimization
  return(abs(impact))  # Maximize absolute value
}

optimal_continuous <- optim(
  par = c(mean(x_bounds), mean(y_bounds)),  
  fn = function(coords) -objective_function(coords, data.p, model_n, total_patients),  # Negative for maximization
  method = "L-BFGS-B",
  lower = c(x_bounds[1], y_bounds[1]),
  upper = c(x_bounds[2], y_bounds[2])
)

optimal_coords_rf <- data.frame(Site_X = optimal_continuous$par[1], Site_Y = optimal_continuous$par[2])
optimal_impact_rf <- -optimal_continuous$value  

list(coords = optimal_coords_rf, impact = optimal_impact_rf)

ggplot(data.p)+
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 2)+
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha =0.6)+
  geom_point(data = optimal_coords_rf, aes(x = Site_X, y = Site_Y), col = "red", size = 3)


## Let's try with a gam ####
library(gam)
library(mgcv)

set.seed(1)
trainp.index <- sample.int(nrow(data.p), 0.6*nrow(data.p))
trainp <- data.p[trainp.index,]
testp <- data.p[setdiff(1:nrow(data.p),trainp.index),]

model_gam <- gam(n ~ s(Distance) + Site_Type + Month + Year, data = trainp, family = Gamma(link = "log"))
summary(model_gam)
predictions <- predict(model_n, data = testp[,-9])

predict_values <- predictions$predictions
actual_values <- testp[,9]
df <- data.frame(Predictions = predictions$predictions, Actual = testp[,9])

plot(df[,1], df[,2])

# Coordinates for best new site
coord.new <- c(10640.01507538, 105690.53768844)

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

new_site$n <- predict(model_gam, newdata = new_site, type = "response")

total_new_site <- sum(new_site$n)
total <- sum(data.p$n)
to.redistribute <- total - total_new_site

# Step 3: Analyze the impact of adding the new site
data.p <- data.p %>%
  mutate(new_n = n / total * to.redistribute,
         diff = new_n-n) 

# Proportionally remove patients from other sites (this could be done in other
# ways depending on distance)

# Summarize the results
# Compare original `n` with adjusted `n`
impact_summary <- data.p %>%
  group_by(Site_Code) %>%
  summarise(diff = sum(diff), percentage_diff = diff/n())
impact <- sum(impact_summary$diff) / total



evaluate_new_site_gam <- function(new_site_coords, data = data.p, total_patients = total_patients){
  new_x <- new_site_coords[1]
  new_y <- new_site_coords[2]
  
  unique_patients <- unique(data[, c("Pat_X", "Pat_Y")])
  unique_time <- expand.grid(
    Month = unique(data$Month),
    Year = unique(data$Year)
  )
  new_site <- merge(unique_patients, unique_time)
  new_site <- cbind(new_site,
                    Site_Code = "12",
                    Site_X = new_x,
                    Site_Y = new_y,
                    Site_Type = "ED" 
  )
  
  new_site <- new_site %>% mutate(
    Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
    n = 0
  )
  
  new_site$n <- predict(model_gam, newdata = new_site, type = "response")
  
  total_new_site <- sum(new_site$n)
  total <- sum(data.p$n)
  to.redistribute <- total - total_new_site
  
  # Step 3: Analyze the impact of adding the new site
  data.p <- data.p %>%
    mutate(new_n = n / total * to.redistribute, #This is a proportional approach
           # so the percentage removed from each of the site is constant
           # no matter the new site location. The only thing changing
           # is the magnitude
           diff = new_n-n) 
  
  
  ## Compute Impact insights
  impact_summary <- data.p %>%
    group_by(Site_Code) %>%
    summarise(diff = sum(diff), percentage_diff = diff/n())
  impact <- sum(impact_summary$diff) / total
  
  return(impact)
}

# Define bounds for the search 
x_bounds <- c(min(data.p$Pat_X), max(data.p$Pat_X))
y_bounds <- c(min(data.p$Pat_Y), max(data.p$Pat_Y))

library(optim)

objective_function <- function(coords, data, model, total_patients) {
  impact <- evaluate_new_site_gam(
    new_site_coords = coords,
    data = data,
    total_patients = total_patients
  )
  # Change this for maximization/minimization
  return(abs(impact))  # Maximize absolute value
}

optimal_continuous <- optim(
  par = c(mean(x_bounds), mean(y_bounds)),  
  fn = function(coords) -objective_function(coords, data.p, total_patients),  # Negative for maximization
  method = "L-BFGS-B",
  lower = c(x_bounds[1], y_bounds[1]),
  upper = c(x_bounds[2], y_bounds[2])
)

optimal_coords_gam <- data.frame(Site_X = optimal_continuous$par[1], Site_Y = optimal_continuous$par[2])
optimal_impact_gam <- -optimal_continuous$value  

list(coords = optimal_coords_gam, impact = optimal_impact_gam)

ggplot(data.p)+
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 2)+
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha =0.6)+
  geom_point(data = optimal_coords_gam, aes(x = Site_X, y = Site_Y), col = "red", size = 3)


## Poisson data ###

# Data Preparation
data.p$Month <- as.factor(data.p$Month)
data.p$Year <- as.factor(data.p$Year)
data.p$Site_Type <- as.factor(data.p$Site_Type)

# Poisson regression is used because `n` is a count variable
model.glm <- glm(n ~ Site_Type + Month + Year + Distance, 
             data = data.p, 
             family = poisson(link = "log"))

# Summarize the model
summary(model.glm)

# Step 2: 
coord.new <- c(10640.01507538, 105690.53768844)

# Calculate distances between patients and the new site
unique_patients <- unique(data.p[, c("Pat_X", "Pat_Y")])
unique_time <- expand.grid(
  Month = unique(data$Month),
  Year = unique(data$Year)
)
new_site <- merge(unique_patients, unique_time)
new_site <- cbind(new_site,
                  Site_Code = "12",
                  Site_X = coord.new[1],
                  Site_Y = coord.new[2],
                  Site_Type = "ED" 
)

new_site <- new_site %>% mutate(
  Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
  n = 0
)

# Predict `n` for the new site
new_site$n <- predict(model, newdata = new_site, type = "response")

total_new_site <- sum(new_site$n)
total <- sum(data.p$n)
to.redistribute <- total - total_new_site

# Step 3: Analyze the impact of adding the new site
data.p <- data.p %>%
  mutate(new_n = n / total * to.redistribute,
         diff = new_n-n) 

# Proportionally remove patients from other sites (this could be done in other
# ways depending on distance)

# Summarize the results
# Compare original `n` with adjusted `n`
impact_summary <- data.p %>%
  group_by(Site_Code) %>%
  summarise(diff = sum(diff), percentage_diff = diff/n())
impact <- sum(impact_summary$diff) / total

# Visualise
ggplot(impact_summary, aes(x = Site_Code, y = percentage_diff, fill = Site_Code)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Percentage Change in Patient Count After Adding New Site",
    x = "Site Code",
    y = "Percentage Change (%)",
    fill = "Site Code"
  ) 


evaluate_new_site_glm <- function(new_site_coords){
  new_x <- new_site_coords[1]
  new_y <- new_site_coords[2]
  
  unique_patients <- unique(data.p[, c("Pat_X", "Pat_Y")])
  unique_time <- expand.grid(
    Month = unique(data.p$Month),
    Year = unique(data.p$Year)
  )
  new_site <- merge(unique_patients, unique_time)
  new_site <- cbind(new_site,
                    Site_Code = "12",
                    Site_X = new_x,
                    Site_Y = new_y,
                    Site_Type = "ED" 
  )
  
  new_site <- new_site %>% mutate(
    Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
    n = 0
  )
  
  new_site$n <- predict(model.glm, newdata = new_site, type = "response")
  
  total_new_site <- sum(new_site$n)
  total <- sum(data.p$n)
  to.redistribute <- total - total_new_site
  
  # Step 3: Analyze the impact of adding the new site
  data.p <- data.p %>%
    mutate(new_n = n / total * to.redistribute,
           diff = new_n-n) 
  
  # Proportionally remove patients from other sites (this could be done in other
  # ways depending on distance)
  
  # Summarize the results
  # Compare original `n` with adjusted `n`
  impact_summary <- data.p %>%
    group_by(Site_Code) %>%
    summarise(diff = sum(diff), percentage_diff = diff/n())
  impact <- sum(impact_summary$diff) / total
  return(impact)
}

# Define bounds for the search 
x_bounds <- c(min(data.p$Pat_X), max(data.p$Pat_X))
y_bounds <- c(min(data.p$Pat_Y), max(data.p$Pat_Y))

x_vals <- seq(x_bounds[1], x_bounds[2], length.out = 20)
y_vals <- seq(y_bounds[1], y_bounds[2], length.out = 20)

grid_results <- expand.grid(Site_X = x_vals, Site_Y = y_vals) %>%
  rowwise() %>%
  mutate(impact = evaluate_new_site(new_site_coords = c(Site_X, Site_Y)))

best.site <- grid_results[which.max(abs(grid_results$impact)),1:2]

ggplot(data.p)+
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 2)+
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha =0.6)+
  geom_point(data = best.site, aes(x = Site_X, y = Site_Y), col = "red", size = 3)

# NOW MIU/OTHER assumption

evaluate_new_site <- function(new_site_coords){
  new_x <- new_site_coords[1]
  new_y <- new_site_coords[2]
  
  unique_patients <- unique(data.p[, c("Pat_X", "Pat_Y")])
  unique_time <- expand.grid(
    Month = unique(data.p$Month),
    Year = unique(data.p$Year)
  )
  new_site <- merge(unique_patients, unique_time)
  new_site <- cbind(new_site,
                    Site_Code = "12",
                    Site_X = new_x,
                    Site_Y = new_y,
                    Site_Type = "MIU/OTHER" 
  )
  
  new_site <- new_site %>% mutate(
    Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
    n = 0
  )
  
  new_site$n <- predict(model, newdata = new_site, type = "response")
  
  total_new_site <- sum(new_site$n)
  total <- sum(data.p$n)
  to.redistribute <- total - total_new_site
  
  # Step 3: Analyze the impact of adding the new site
  data.p <- data.p %>%
    mutate(new_n = n / total * to.redistribute,
           diff = new_n-n) 
  
  # Proportionally remove patients from other sites (this could be done in other
  # ways depending on distance)
  
  # Summarize the results
  # Compare original `n` with adjusted `n`
  impact_summary <- data.p %>%
    group_by(Site_Code) %>%
    summarise(diff = sum(diff), percentage_diff = diff/n())
  impact <- sum(impact_summary$diff) / total
  return(impact)
}

# Define bounds for the search 
x_bounds <- c(min(data.p$Pat_X), max(data.p$Pat_X))
y_bounds <- c(min(data.p$Pat_Y), max(data.p$Pat_Y))

objective_function <- function(coords, data, total_patients) {
  impact <- evaluate_new_site_glm(
    new_site_coords = coords
  )
  # Change this for maximization/minimization
  return(abs(impact))  # Maximize absolute value
}

optimal_continuous <- optim(
  par = c(mean(x_bounds), mean(y_bounds)),  
  fn = function(coords) -objective_function(coords),  # Negative for maximization
  method = "L-BFGS-B",
  lower = c(x_bounds[1], y_bounds[1]),
  upper = c(x_bounds[2], y_bounds[2])
)

optimal_coords_glm <- data.frame(Site_X = optimal_continuous$par[1], Site_Y = optimal_continuous$par[2])
optimal_impact_glm <- -optimal_continuous$value  

list(coords = optimal_coords_glm, impact = optimal_impact_glm)

ggplot(data.p)+
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 2)+
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha =0.6)+
  geom_point(data = optimal_coords_glm, aes(x = Site_X, y = Site_Y), col = "red", size = 3)

# Combine all optimal coordinates into a single data frame
optimal_coords <- rbind(
  data.frame(Site_X = optimal_coords_glm$Site_X, Site_Y = optimal_coords_glm$Site_Y, Model = "GLM"),
  data.frame(Site_X = optimal_coords_rf$Site_X, Site_Y = optimal_coords_rf$Site_Y, Model = "RF"),
  data.frame(Site_X = optimal_coords_gam$Site_X, Site_Y = optimal_coords_gam$Site_Y, Model = "GAM")
)

# Main plot showing all patients and sites
main_plot <- ggplot(data.p) +
  # All site locations
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 2, alpha = 0.8) +
  # All patient locations
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha = 0.6) +
  # Optimal coordinates
  geom_point(data = optimal_coords, aes(x = Site_X, y = Site_Y, col = Model), size = 3) +
  # Add labels and title
  labs(
    title = "Patient and Site Locations with Zoomed-In Optimal Coordinates",
    x = "X Coordinate",
    y = "Y Coordinate",
    color = "Model"
  ) +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

# Zoomed-in plot for optimal coordinates
zoomed_plot <- ggplot(data.p) +
  # All site locations (faint for context)
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 1, alpha = 0.4) +
  # All patient locations (faint for context)
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha = 0.2) +
  # Highlight optimal coordinates
  geom_point(data = optimal_coords, aes(x = Site_X, y = Site_Y, col = Model), size = 4) +
  # Add zoom limits
  coord_cartesian(xlim = c(32000, 34000), ylim = c(105000, 115000)) +
  labs(x = NULL, y = NULL, color = NULL) +
  theme_light() +
  theme(legend.position = "none")  # Hide legend in inset


library(patchwork)

# Add zoomed plot as an inset using patchwork
final_plot <- main_plot +
  inset_element(
    zoomed_plot,
    left = 0.6, right = 0.95, bottom = 0.1, top = 0.5,  # Position the inset
    align_to = "panel"  # Align inset to main panel
  )

# Display the plot
print(final_plot)


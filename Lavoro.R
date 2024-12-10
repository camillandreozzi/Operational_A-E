## Modelling Phase for Answers to Research Questions

library(readxl)
library(tidyverse)
library(magrittr)

setwd("~/Desktop/Operational Research EDI")
data <- read_excel("OR_AE2_Project_Adjusted.xlsx")

# Data Manipulation for Modelling

# LONGER VERSION
data$Number_Of_Attendances <- as.numeric(data$Number_Of_Attendances)
repetitions <- data$Number_Of_Attendances

data.longer <- data[rep(seq_len(nrow(data)), repetitions), -19]

cat("Original Data Frame dimensions: [", nrow(data),",", ncol(data),"]")
cat("Longer Data Frame dimensions: [", nrow(data.longer),",", ncol(data.longer),"]")

# Handle Categorical Variables

data.longer$Pat_X <- as.factor(data.longer$Pat_X)
data.longer$Site_Code <- as.factor(data.longer$Site_Code)
data.longer$Month <- as.factor(data.longer$Month)
data.longer$Year <- as.factor(data.longer$Year)
data.longer$Attendance_Type <- as.factor(data.longer$Attendance_Type)
data.longer$Age_Group <- factor(data.longer$Age_Group, ordered = T)
data.longer$Pat_Y <- as.factor(data.longer$Pat_Y)

# Wait Time
data.longer$Wait_Time <- factor(data.longer$Wait_Time, levels = c(
  "00-29", "30-59", "60-89" , "90-119" , "120-149", "150-179", "180-209", "210-239", "240-269",
  "270-299", "300-329","360+"), ordered = T)
data.longer <-  data.longer %>% mutate(Mean_Wait_Time = case_match(.x = Wait_Time,"00-29" ~ 15, "30-59" ~ 45,"60-89" ~ 75, "90-119" ~ 105,
                                                                   "120-149" ~ 135, "150-179" ~ 165,
                                                                   "180-209" ~ 195,"210-239" ~ 225,
                                                                   "240-269" ~ 255, "270-299" ~ 285,
                                                                   "300-329" ~ 315, "360+" ~ 345))
data.longer <-  data.longer %>% mutate(Binary_Wait_Time = case_match(.x = Wait_Time,"00-29" ~ 0, "30-59" ~ 0, "60-89" ~ 0,"90-119" ~ 1,
                                                                     "120-149" ~ 1, "150-179" ~ 1,
                                                                     "180-209" ~ 1,"210-239" ~ 1,
                                                                     "240-269" ~ 1, "270-299" ~ 1,
                                                                     "300-329" ~ 1, "360+" ~ 1))
data.summary <- data.longer %>% group_by(Month, Year, Site_Code, Pat_X, Pat_Y,
                                         Attendance_Type, Age_Group) %>%
  summarise(Mean_byGroup_Wait_Time = mean(Mean_Wait_Time, na.rm = T), .groups = "keep")


# Wait Time distribution

ggplot(data.longer, aes(x = Wait_Time))+
  geom_bar() + ggtitle("Distribution of Wait Time")

ggplot(data.longer, aes(x = Mean_Wait_Time))+
  geom_histogram() + ggtitle("Distribution of Mean Wait Time (numeric transf)")

ggplot(data.longer, aes(x = Binary_Wait_Time))+
  geom_bar() + ggtitle("Distribution of Binary Wait Time (> 1.5hr)") #very unbalanced

# Linear Regression

# We do not consider any coordinates

model.lm1 <- lm(Mean_Wait_Time ~ Site_Code + Site_Type +
                  Site_Loc_GPs + Site_Pop_20miles +
                  Pat_Loc_GPs + Pat_Loc_GP_List + Drive_Distance_Miles +
                  Driving_Time_mins + Attendance_Type + 
                  Age_Group + Year + Month, data =  data.longer)
summary(model.lm1)

# We want correct magnitude of coefficients to determine impact of factors
# therefore we need to scale the numeric variables 

data.longer$Drive_Distance_Miles <- case_when(data.longer$Drive_Distance_Miles == "00 to 05" ~ 2.5,
                                              data.longer$Drive_Distance_Miles == "05 to 10" ~ 7.5,
                                              data.longer$Drive_Distance_Miles == "10 to 15" ~ 12.5,
                                              data.longer$Drive_Distance_Miles == "15 to 20" ~ 17.5,
                                              data.longer$Drive_Distance_Miles == "20 to 25" ~ 22.5,
                                              data.longer$Drive_Distance_Miles == "25 to 30" ~ 27.5,
                                              data.longer$Drive_Distance_Miles == "30 to 35" ~ 32.5,
                                              data.longer$Drive_Distance_Miles == "35 to 40" ~ 37.5,
                                              data.longer$Drive_Distance_Miles == "40 to 45" ~ 42.5,
                                              data.longer$Drive_Distance_Miles == "45 to 50" ~ 47.5,
                                              data.longer$Drive_Distance_Miles == "50 to 55" ~ 52.5)

data.longer$Driving_Time_mins <- case_when(data.longer$Driving_Time_mins == "00 to 05" ~ 2.5,
                                           data.longer$Driving_Time_mins == "05 to 10" ~ 7.5,
                                           data.longer$Driving_Time_mins == "10 to 15" ~ 12.5,
                                           data.longer$Driving_Time_mins == "15 to 20" ~ 17.5,
                                           data.longer$Driving_Time_mins == "20 to 25" ~ 22.5,
                                           data.longer$Driving_Time_mins == "25 to 30" ~ 27.5,
                                           data.longer$Driving_Time_mins == "30 to 35" ~ 32.5,
                                           data.longer$Driving_Time_mins == "35 to 40" ~ 37.5,
                                           data.longer$Driving_Time_mins == "40 to 45" ~ 42.5,
                                           data.longer$Driving_Time_mins == "45 to 50" ~ 47.5,
                                           data.longer$Driving_Time_mins == "50 to 55" ~ 52.5,
                                           data.longer$Driving_Time_mins == "55 to 60" ~ 57.5,
                                           data.longer$Driving_Time_mins == "60 to 65"~ 62.5,
                                           data.longer$Driving_Time_mins =="70 to 75" ~ 77.5,
                                           data.longer$Driving_Time_mins =="65 to 70"~ 67.5,
                                           data.longer$Driving_Time_mins =="75 to 80"~ 77.5,
                                           data.longer$Driving_Time_mins =="80 to 85" ~ 82.5,
                                           data.longer$Driving_Time_mins =="85 to 90"~ 87.5)

data.longer$Age_Group <- case_when(data.longer$Age_Group == "20-39"~ 30,
                                   data.longer$Age_Group == "40-59"~ 50,   
                                   data.longer$Age_Group == "60-79" ~ 70,
                                   data.longer$Age_Group == "80+" ~ 85,
                                   data.longer$Age_Group == "Missing" ~ NA)

data_scaled <- data.longer
num_vars <- sapply(data.longer, is.numeric)
data_scaled[num_vars] <- scale(data.longer[num_vars])

model.lm2 <- lm(Mean_Wait_Time ~ Site_Code + Site_Type +
                  Site_Loc_GPs + Site_Pop_20miles +
                  Pat_Loc_GPs + Pat_Loc_GP_List + Drive_Distance_Miles +
                  Driving_Time_mins + Attendance_Type + 
                  Age_Group + Year + Month, data =  data_scaled)
summary(model.lm2)
coeff <- model.lm2$coefficients
coeff[order(abs(coeff), decreasing = T)] ## Quali sono i fattori che influenzano di più la variabile wait time?

data_scaled$Binary_Wait_Time <- data.longer$Binary_Wait_Time

model.lm3 <- glm(Binary_Wait_Time ~Site_Code + Site_Type +
                   Site_Loc_GPs + Site_Pop_20miles +
                   Pat_Loc_GPs + Pat_Loc_GP_List + Drive_Distance_Miles +
                   Driving_Time_mins + Attendance_Type + 
                   Age_Group + Year + Month, data =  data_scaled, family = "binomial")
summary(model.lm3)
coeff <- exp(model.lm3$coeff) ## Quali sono i fattori che influenzano di più la variabile wait time?

sort(coeff, decreasing = T) # Site Code 9 --> investigare


# Decision Trees
library(rpart)
library(rpart.plot)
set.seed(1)

train.index <- sample.int(nrow(data_scaled), size = nrow(data_scaled)*0.7)
test.index <- setdiff(1:nrow(data_scaled), train.index)
data.train <- data_scaled[train.index,]
data.test <- data_scaled[test.index,]

tree_class <- rpart(Binary_Wait_Time ~Site_Code + Site_Type +
                      Site_Loc_GPs + Site_Pop_20miles +
                      Pat_Loc_GPs + Pat_Loc_GP_List + Drive_Distance_Miles +
                      Driving_Time_mins + Attendance_Type + 
                      Age_Group + Year + Month, data =  data.train,
                    method = "class", cp = 0.0005)
rpart.plot(tree_class)

printcp(tree_class)
plotcp(tree_class)

tree_pred_prob <- predict(tree_class, newdata = data.test%>%mutate(Binary_Wait_Time=NULL), type= "prob")

library(ROCR)
## Decision tree.
score_dt <- prediction(tree_pred_prob[,2], data.test$Binary_Wait_Time)

# Plot precision-recall and AUCs.
plot(performance(score_dt,"prec","rec"), 
     main = paste("Decision Tree - AUC:", round(performance(score_dt,"auc")@y.values[[1]], 3)))

#Random Forest
rf <- randomForest(Binary_Wait_Time ~Site_Code + Site_Type +
                     Site_Loc_GPs + Site_Pop_20miles +
                     Pat_Loc_GPs + Pat_Loc_GP_List + Drive_Distance_Miles +
                     Driving_Time_mins + Attendance_Type + 
                     Age_Group + Year + Month, data =  data.train, na.action = na.exclude)



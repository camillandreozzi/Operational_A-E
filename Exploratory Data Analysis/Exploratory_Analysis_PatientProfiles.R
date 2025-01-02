## Patient Analysis
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

data$Year <- factor(data$Year, ordered = T)
data$Month <- factor(data$Month, ordered = T)

n_wait <- table(data$Wait_Time)
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
data$Driving_Time_mins <- as.numeric(data$Driving_Time_mins)
data$Attendance_Type <- as.factor(data$Attendance_Type)
data[data$Age_Group == "Missing",] <- NA
data <- na.omit(data)
data <- data %>% mutate(Total_Time = Driving_Time_mins + Wait_Time)

ggplot(data, aes(x = Total_Time))+
  geom_histogram() # The un-uniform structure is due to the mistake in 
# the data collection, no data between 329 and 360


# Summarize wait times by patient characteristics
total_time_summary <- data %>%
  group_by(Age_Group, Attendance_Type, Site_Code, Site_Type, Year, Month) %>%
  summarise(
    Avg_Total_Time = mean(Total_Time, na.rm = TRUE),
    Max_Total_Time = max(Total_Time, na.rm = TRUE),
    Min_Total_Time = min(Total_Time, na.rm = TRUE),
    .groups = 'drop'
  )

# Identify groups with the highest and lowest average wait times
most_wait <- total_time_summary %>%
  arrange(desc(Avg_Total_Time)) %>%
  head(10) 

least_wait <- total_time_summary %>%
  arrange(Avg_Total_Time) %>%
  head(10) # Top 10 groups with the lowest wait times

# View the results
print("Top 10 groups with the longest average wait times:")
print(most_wait)

print("Top 10 groups with the shortest average wait times:")
print(least_wait)


# Explore other relationships visually (e.g., by age group and attendance type)
ggplot(data, aes(x = Age_Group, y = Wait_Time, fill = Attendance_Type)) +
  geom_boxplot() +
  labs(title = "Wait Time by Age Group and Attendance Type", x = "Age Group", y = "Wait Time (minutes)") +
  theme_minimal()

find_average_time <- function(data, characteristic) {
  # First, calculate average Total_Time per characteristic
  avg_time <- data %>%
    group_by(across(all_of(characteristic))) %>%
    summarise(
      Avg_Total_Time = mean(Total_Time, na.rm = TRUE),
      .groups = 'drop'
    )
  
  # Now, calculate max and min values for Avg_Total_Time
  max_avg_time <- avg_time %>%
    filter(Avg_Total_Time == max(Avg_Total_Time, na.rm = TRUE)) %>%
    pull(!!sym(characteristic))
  
  min_avg_time <- avg_time %>%
    filter(Avg_Total_Time == min(Avg_Total_Time, na.rm = TRUE)) %>%
    pull(!!sym(characteristic))
  
  # Return a summary with the max and min values
  result <- tibble(
    Max_Characteristic = as.character(max_avg_time),
    Max_Avg_Time = max(avg_time$Avg_Total_Time, na.rm = TRUE),
    Min_Characteristic = as.character(min_avg_time),
    Min_Avg_Time = min(avg_time$Avg_Total_Time, na.rm = TRUE)
  )
  
  return(result)
}


# List of patient characteristics to analyze
characteristics <- c("Age_Group", "Attendance_Type", "Pat_Loc_GPs", "Pat_Loc_GP_List", 
                     "Pat_X", "Pat_Y", "Site_Loc_GPs", "Site_Type", 
                     "Site_Loc_GP_List", "Month", "Year",
                     "Site_Pop_20miles", "Site_Code")

# Find the average total time for each characteristic
average_summary <- lapply(characteristics, function(char) {
  result <- find_average_time(data, char)
  result$Characteristic <- char
  result
})

# Combine results into a single data frame
average_summary_df <- bind_rows(average_summary)

# View the results
print("Characteristics with highest and lowest average Total_Time:")
print(average_summary_df)


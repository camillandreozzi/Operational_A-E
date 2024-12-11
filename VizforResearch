## Research Questions

## Data Cleaning ####

setwd("~/Desktop/Operational Research EDI")
data <- read_excel("OR_AE2_Project_Adjusted.xlsx")
data$Number_Of_Attendances <- as.numeric(data$Number_Of_Attendances)
repetitions <- data$Number_Of_Attendances
data.longer <- data[rep(seq_len(nrow(data)), repetitions), -19]
data.longer$Site_Code <- as.factor(data.longer$Site_Code)
data.longer$Month <- as.factor(data.longer$Month)
data.longer$Year <- as.factor(data.longer$Year)
data.longer$Attendance_Type <- as.factor(data.longer$Attendance_Type)
data.longer$Age_Group <- factor(data.longer$Age_Group, ordered = T)
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
data_scaled$Binary_Wait_Time <- data.longer$Binary_Wait_Time


# Quali postcodes sono più svantaggiati a livello di tempistiche? X WAIT X DRIVING X SOMMA

postcodes <- data.longer %>% group_by(Pat_X, Pat_Y) %>% 
  summarise(wait = sum(Mean_Wait_Time),
            driving = sum(Driving_Time_mins),
            proportion = sum(Binary_Wait_Time)/n(),
            .groups = "keep") %>% 
  mutate(tot = wait + driving)

postcodes$Pat_X <- as.numeric(postcodes$Pat_X)
postcodes$Pat_Y <- as.numeric(postcodes$Pat_Y)
ggplot(postcodes, aes(x = Pat_X, y = Pat_Y))+
  geom_point(aes(size = tot, col = proportion)) + 
  scale_color_gradient(low = "lightgreen", high = "darkgreen") +
  theme_light() + ggtitle("Map of Postcodes with size depending on Time to service")

postcodes$Pat_X <- as.factor(postcodes$Pat_X)
ggplot(postcodes, aes(x = Pat_X))+
  geom_col(aes(y = wait), fill = "orange", col = "black")+
  geom_col(aes(y = driving), fill = "red", col = "black")+
  ggtitle("Difference in magnitude between Wait time and driving time")

ggplot(postcodes, aes(x = Pat_X))+
  geom_col(aes(y = proportion), fill = "darkblue", col = "black")+
  ggtitle("Proportion of >1.5 hr Wait Time by Postcodes")

postcodes[order(postcodes$tot, decreasing = T),] # Più Svantaggiati
postcodes[order(postcodes$tot, decreasing = F),] # Più Avvantaggiati

# Sites, least and most wait time

sites <- data.longer %>% group_by(Site_X, Site_Y) %>%
  summarise(wait = sum(Mean_Wait_Time),
            driving = sum(Driving_Time_mins),
            proportion = sum(Binary_Wait_Time)/n(),
            .groups = "keep") %>%
  mutate(tot = wait + driving)

ggplot(sites, aes(x = Site_X, Site_Y))+
  geom_point(aes(size = tot)) +
  theme_light() + ggtitle("Map of Sites, size depending on tot Time to service")

ggplot(sites, aes(x = Site_X, Site_Y))+
  geom_point(aes(size = wait)) +
  theme_light() + ggtitle("Map of Sites, size depending on Wait Time to service")

# Most efficient sites
sites[order(sites$wait, decreasing = T),]

# Most inefficient sites 
sites[order(sites$wait, decreasing = F),]


# Combine the two graphs
postcodes <- data.longer %>% group_by(Pat_X, Pat_Y) %>% 
  summarise(wait = sum(Mean_Wait_Time),
            driving = sum(Driving_Time_mins),
            proportion = sum(Binary_Wait_Time)/n(),
            .groups = "keep") %>% 
  mutate(tot = wait + driving)
ggplot()+
  geom_point(data = postcodes, aes(x = Pat_X, y = Pat_Y, size = tot, col = proportion)) + 
  theme_light() + ggtitle("Map of Postcodes with size depending on Time to service")+
  geom_point(data = sites, aes(x = Site_X, y = Site_Y), col = "red")

# How come the area with no Sites has the lowest times?
# Probably they choose NOT to go to the hospital but to local GPs

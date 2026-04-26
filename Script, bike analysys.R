# Load libraries
library(tidyverse)
library(lubridate)

# Set working directory (adjust to your folder)
setwd("C:/Users/andre/Downloads/case study bike")

# Load all CSV files
files <- list.files(pattern = "*.csv", full.names = TRUE)

trips_raw <- files %>%
  map_df(~ read_csv(.x, col_types = cols(
    ride_id = col_character(),
    rideable_type = col_character(),
    started_at = col_datetime(),
    ended_at = col_datetime(),
    start_station_name = col_character(),
    start_station_id = col_character(),
    end_station_name = col_character(),
    end_station_id = col_character(),
    start_lat = col_double(),
    start_lng = col_double(),
    end_lat = col_double(),
    end_lng = col_double(),
    member_casual = col_character()
  )))

# Data cleaning
trips_clean <- trips_raw %>%
  mutate(
    ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
    day_of_week = wday(started_at, label = TRUE),
    month = month(started_at, label = TRUE),
    hour = hour(started_at)
  ) %>%
  filter(
    ride_length > 0,
    ride_length <= 1440,
    !is.na(member_casual)
  ) %>%
  distinct(ride_id, .keep_all = TRUE)

# Fix day order
trips_clean$day_of_week <- factor(
  trips_clean$day_of_week,
  levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
)

# ---- ANALYSIS ----

# Summary 
summary_stats <- trips_clean %>%
  group_by(member_casual) %>%
  summarise(
    total_rides = n(),
    avg_ride_length = mean(ride_length),
    median_ride_length = median(ride_length),
    .groups = "drop"
  )

print(summary_stats)

# Rides by day of week
rides_day <- trips_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(rides = n(), .groups = "drop")

# Rides by hour
rides_hour <- trips_clean %>%
  group_by(member_casual, hour) %>%
  summarise(rides = n(), .groups = "drop")

# ---- VISUALIZATIONS ----

# Create visuals folder if not exists
dir.create("visuals", showWarnings = FALSE)

    # 1- Rides by Hour
p1 <- ggplot(rides_hour, aes(x = hour, y = rides, color = member_casual)) +
  geom_line(size = 1) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Rides by Hour of Day", x = "Hour", y = "Number of Rides")

ggsave("visuals/rides_by_hour.png", p1, width = 8, height = 5)

   # 2- Rides by Day
p2 <- ggplot(rides_day, aes(x = day_of_week, y = rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Rides by Day of Week", x = "Day", y = "Number of Rides")

ggsave("visuals/rides_by_day.png", p2, width = 8, height = 5)

  # 3- Average Ride Length
p3 <- trips_clean %>%
  group_by(member_casual) %>%
  summarise(avg_ride_length = mean(ride_length)) %>%
  ggplot(aes(x = member_casual, y = avg_ride_length, fill = member_casual)) +
  geom_col() +
  labs(title = "Average Ride Length", x = "User Type", y = "Minutes")

ggsave("visuals/avg_ride_length.png", p3, width = 6, height = 4)
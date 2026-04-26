# Cyclistic Bike-Share Case Study

## 1. Business Task  
The goal of this project is to analyze Cyclistic’s trip data to understand how casual riders and annual members use the service differently,
and use those insights to suggest ways to convert casual riders into members.

---

## 2. Data Source  
I used publicly available Cyclistic trip data covering the full year of 2025.

---

## 3. Data Cleaning & Processing  
All data cleaning was done in R. The main steps included:  
- Combining the 12 monthly datasets into one dataset  
- Converting date and time columns into the correct format  
- Creating new variables such as ride length, day of the week, and hour of the day  
- Removing invalid rides (e.g., negative or extremely long durations)  
- Removing duplicate records  

---

## 4. Analysis Summary  
After analyzing the data, several clear patterns emerged:

- Casual riders take longer rides on average (~19 minutes) compared to members (~12 minutes), suggesting more leisure-oriented usage.  
- Members show strong usage peaks around 8 AM and 5 PM, which aligns with typical commuting hours.  
- Casual riders are more active on weekends, while members ride more frequently during weekdays.  

Overall, this indicates that members use the bikes as part of a regular routine (such as commuting),
while casual riders use them more flexibly and less consistently.

---

## 5. Visualizations  

![Rides by Hour](../visuals/rides_by_hour.png)  
![Rides by Day](../visuals/rides_by_day.png)  
![Average Ride Length](../visuals/avg_ride_length.png)

---

## 6. Recommendations  

### 1. Weekday Conversion Incentives  
Encourage casual riders to use bikes during weekdays by offering discounts or short-term commuter passes.
This could help build consistent riding habits.

---

### 2. Target High-Frequency Casual Riders  
Focus on casual riders who already use the service frequently and offer them personalized membership deals, 
as they are more likely to convert.

---

### 3. Weekend-Based Membership Options  
Since casual riders are most active on weekends, offering flexible or weekend-focused plans could make membership more appealing to them.

---

## 7. Conclusion  
Cyclistic members use bikes in a consistent and routine way, mainly for commuting. Casual riders,
on the other hand, use bikes more occasionally and for leisure.

To increase memberships, Cyclistic should focus on encouraging more consistent usage among casual riders 
and offer membership options that align with their current behavior.

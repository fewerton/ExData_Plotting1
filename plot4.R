library(tidyverse)
library(lubridate)

### Load data into R memory
### Loads full data set into R #####
### Very large data table (and file size)
household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          delim = ";", escape_double = FALSE, 
                                          col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                                                           Time = col_time(format = "%H:%M:%S")), 
                                          trim_ws = TRUE)


### Subsets the data to only two days #####
household_power_consumption_subset <- household_power_consumption %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")


### In order to plot Global Active Power by Weekday
household_power_consumption_subset <- household_power_consumption_subset %>%
    mutate(DateTime = ymd_hms(paste(Date, Time))) 


### Saves plots to single png file ####

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

plot(household_power_consumption_subset$DateTime, 
     household_power_consumption_subset$Global_active_power, type="l", xlab="Date and Time", ylab="Global Active Power (kilowatts)")

plot(household_power_consumption_subset$DateTime, 
     household_power_consumption_subset$Voltage, type="l", xlab="Date and Time", ylab="Voltage (V)")

plot(household_power_consumption_subset$DateTime, 
     household_power_consumption_subset$Sub_metering_1, type="l", col="black", xlab="Date and Time", ylab="Energy sub meterring")
lines(household_power_consumption_subset$DateTime, 
     household_power_consumption_subset$Sub_metering_2, type="l", col="red")
lines(household_power_consumption_subset$DateTime, 
     household_power_consumption_subset$Sub_metering_3, type="l", col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Energy Sub metering 1", "Energy Sub metering 2", "Energy Sub metering 3"),  lwd = 4)

plot(household_power_consumption_subset$DateTime, 
     household_power_consumption_subset$Global_reactive_power, type="l", xlab="Date and Time", ylab="Global Reactive Power (kilowatts)")

dev.off()
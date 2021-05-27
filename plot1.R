library(tidyverse)

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

### Plot 01 ####
### Global Active Power histogram
### Saves plot to png file ####
png(filename = "plot1.png", width = 480, height = 480)
hist(household_power_consumption_subset$Global_active_power, col="red", 
     xlab = "Global active power (Kilowatts)", main="Histogram of Global Active Power") 
dev.off()
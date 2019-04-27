# Plot 2

# Load Data
# Check if "process_df" is loaded into environment, if not, load it
if(!exists("process_df")){
  source("LoadData.R")
}

# Process Data
# Create a datetime vector with POSIXct
date_time <- as.POSIXct(paste(process_df$Date, process_df$Time), 
                        format="%Y-%m-%d %H:%M:%S")


# Generate plot
# 1. Set up graphic device
png("plot2.png",width = 480,height = 480,units = "px")

# 2. Draw line graph "date_time" against "Global_active_power"
plot(date_time,
     process_df$Global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

# 3. Close graphic device
dev.off()

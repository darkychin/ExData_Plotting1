# Plot 3

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
png("plot3.png",width = 480,height = 480,units = "px")

# 2. Draw line graph "date_time" against "Sub_metering_1" in black
plot(date_time,
     process_df$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "l")

# 3. Draw line graph "date_time" against "Sub_metering_2" in red
lines(date_time,
      process_df$Sub_metering_2,
      col="red")

# 4. Draw line graph "date_time" against "Sub_metering_2" in red
lines(date_time,
      process_df$Sub_metering_3,
      col="blue")

# 5. Add a legend
legend(x = "topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1)

# 6. Close graphic device
dev.off()

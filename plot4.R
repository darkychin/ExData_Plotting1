# Plot 4

# Load Data
# Check if "process_df" is loaded into environment, if not, load it
if(!exists("process_df")){
  source("LoadData.R")
}

# Process Data
# Create a datetime vector with POSIXct
datetime <- as.POSIXct(paste(process_df$Date, process_df$Time), 
                        format="%Y-%m-%d %H:%M:%S")

# Generate plot
# 1. Set up graphic device
png("plot4.png",width = 480,height = 480,units = "px")

# 2. Separate graphic device into 4 sections , 2 each row and each column
par(mfcol=c(2,2))

# 3. Draw 1st graph  - "Global Active Power" against datetime , [1,1]
plot(datetime,
     process_df$Global_active_power,
     xlab = "",
     ylab = "Global Active Power",
     type = "l")

# 4. Draw 2nd graph  - "Energy sub metering" against datetime , [2,1]

# 4.1 Draw line graph "date_time" against "Sub_metering_1" in black
plot(datetime,
     process_df$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "l")

# 4.2 Draw line graph "date_time" against "Sub_metering_2" in red
lines(datetime,
      process_df$Sub_metering_2,
      col="red")

# 4.3 Draw line graph "date_time" against "Sub_metering_2" in red
lines(datetime,
      process_df$Sub_metering_3,
      col="blue")

# 4.4 Add a legend
legend(x = "topright",
       bty = "n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1,
       cex = 0.9)

# 5. Draw 3rd graph  - "Voltage" against datetime
plot(datetime,
     process_df$Voltage,
     ylab = "Voltage",
     type = "l")

# 6. Draw 4th graph  - "Global_reactive_power" against datetime
plot(datetime,
     process_df$Global_reactive_power,
     ylab = "Global_reactive_power",
     type = "l")

# 7. Close graphic device
dev.off()
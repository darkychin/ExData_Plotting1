# Plot 1

# Load Data
# Check if "process_df" is loaded into environment, if not, load it
if(!exists("process_df")){
  source("LoadData.R")
}

# Generate plot
# 1. Set up graphic device
png("plot1.png",width = 480,height = 480,units = "px")

# 2. Draw histogram
hist(process_df$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col="red")

# 3. Close graphic device
dev.off()
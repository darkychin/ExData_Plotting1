# Load Data
# This load data process that will be shared among plot1.R , plot2.R ,plot3.R , plot4.R

# Get Working Directory
wd <- getwd()

# 1. Download File

# Name the download file
zipFile <- "Dataset.zip"

# Validate if file does not exist in the directory, then download it
if(!file.exists(zipFile)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",zipFile,mode="wb")
}

##========================

# 2. Set Up Zip File

# Set up zip file directory
zip_dir <- paste0(wd,"/Dataset.zip")

##========================
# Dataset Size Estimation

# Try Load
# Read first row of data
#   > data_file <- unz(zip_dir,"household_power_consumption.txt")
#   > estimate <- read.table(data_file , header = TRUE , nrows = 1 , sep=";")

# Calculate bytes for this row
#   > bytes <- sum(nchar(estimate,type="bytes"))

# Estimate whole dataset size ( this row * total rows , total rows got from README.md)
#   > totalBytes <- bytes * 2075259

# Calculated in MB 
#   > totalBytes / 2^{20}

# Estimated total = 51.45715 MB

# Real Load
# Establish link to "household_power_consumption.txt" inside zip file 
#   > data_file <- unz(zip_dir,"household_power_consumption.txt")

# Read file into real
#   > real <- read.table(data_file , header = TRUE , sep=";")

# Get object size
#   > real_size <- format(object.size(real),units="auto")

# Real total = 79.9 MB

# Conclusion: Quite far fetch to be honest, with almost 30 MB difference

##========================
# ABANDONED Read File
# Note: Following attempt does not work, 
# because read.csv.sql does not work with file connection but only with exact physical file in the directory

# Establish link to "household_power_consumption.txt" inside zip file
#   > data_file <- unz(zip_dir,"household_power_consumption.txt")

# Read file into loaded_df (does not work)
#   > loaded_df <- read.csv2.sql(data_file , sql="SELECT * FROM file WHERE Date='01/02/2007' OR Date='02/02/2007'",header=TRUE)

##========================

# 3. Unzip File into directory
unzip(zip_dir)

##========================

# 4. Read file
# Note: Reading data that from the dates "2007-02-01" and "2007-02-02" only

# Get file name
filename <- "household_power_consumption.txt"

# Use library(sqldf) to read particular data like sql easily
library(sqldf)

# Read file into loaded_df
# Note : 
# 1. read.csv2 handle sep = ";" automatically // but run endlessly, not sure why...
# 2. "Date" in the data_file uses DD/MM/YYYY instead
loaded_df <- read.csv.sql(filename , sql="select * from file where Date='1/2/2007' or Date='2/2/2007'",header=TRUE,sep = ";")

# Close connection
close(filename)

##========================

# 5. Process file
# Save loaded_df into process_df
process_df <- loaded_df

# Convert process_df$Date into %Date data type
# Note : 
# 1. check out "?strptime" for date formatting 
# 2. comparing to "strptime", "as.Date" work more directly, hence is chose to apply here
process_df$Date <- as.Date(process_df$Date,format = "%d/%m/%Y")

### Check for present of "?"
# sum(sapply(process_df,grepl,pattern="\\?")) , 
# It return 0 , means no "?" is present in process_df , hence no convertion is needed

##========================

# 6. Clean Up Unwanted

# Delete "household_power_consumption.txt" from directory
file.remove(filename)

# Delete unwanted cache in R
rm(list=c("filename","loaded_df","zip_dir","zipFile","wd"))

# Note: only "process_df" will be remained in this environment
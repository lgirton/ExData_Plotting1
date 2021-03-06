# Check to see if a data directory exists already, if not create one
if(!file.exists("data")) {
  dir.create("data")
}

# Download file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip", method = "curl")

# Unzip archive to data directory
unzip("household_power_consumption.zip", exdir = "data/")

# Define column classes
classes <- c(rep("character", 2), rep("numeric", 7))

# Read file into consumption data frame 
consumption <- read.table(
  "data/household_power_consumption.txt", header = T, sep = ";", na.strings = "?", 
  colClasses = classes, stringsAsFactors = F);

# Subset data to only include the first two days of February 2007.
consumption <- subset(consumption,
                      Date == "1/2/2007" | Date == "2/2/2007")

# Concatenate Date and Time variables and parse as POSIXlt into new DateTime variable
consumption$DateTime <- strptime(
  paste(consumption$Date, consumption$Time, sep = " "), 
  format = "%d/%m/%Y %H:%M:%S")

#Specify PNG device to save to
png("plot1.png")

#Plot
hist(consumption$Global_active_power, 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

#Flush to file.
dev.off()
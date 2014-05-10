# Download file only if it does not exist
if(!file.exists("household_power_consumption.zip")) {
  # Url at which the data set is located
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  # Download zip file
  download.file(fileUrl, destfile="household_power_consumption.zip")
}

# load package data.table
library(data.table)

# Read data set. Call the data table "hpc"
hpc <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"),
                  header=TRUE, sep=";",na.strings=c("?"))

# Household power consumption for Feb. 1 and 2, 2007 only
hpc2 <- hpc[as.character(hpc$Date) %in% c("1/2/2007", "2/2/2007"),]

# Clear data table hpc
rm(hpc)

# Export plot to png file
png(file="plot1.png",width = 480, height = 480,units = "px")

# Plot histogram for Global active power
hist(hpc2$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# Close the png device
dev.off()
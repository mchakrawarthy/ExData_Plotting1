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

# Create a new column DateTime in DateTime format
hpc2$DateTime <- strptime(paste(hpc2$Date, hpc2$Time), format='%d/%m/%Y %H:%M:%S')

# Export plot to png file
png(file="plot3.png",width = 480, height = 480,units = "px")

# Plot DateTime and Sub_metering_1
plot(hpc2$DateTime,as.numeric(hpc2$Sub_metering_1),type="l",ylab="Energy sub metering",xlab="")

# Plot DateTime and Sub_metering_2
lines(hpc2$DateTime,as.numeric(hpc2$Sub_metering_2),type="l",col="red",xlab="")

# Plot DateTime and Sub_metering_3
lines(hpc2$DateTime,as.numeric(hpc2$Sub_metering_3),type="l",col="blue",xlab="")

# Add legend to the plot
legend("topright",cex=0.7, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the png device
dev.off()
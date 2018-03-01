setwd("~/R/DataScienceExample/R Coursera/Exploratory/Week 1")

library(dplyr)
#download household_power_consumption.txt 


powerconsumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                               colClasses = c(rep("character",2), rep("numeric",7)), na.strings = "?")

feb <- subset(powerconsumption, Date == "1/2/2007" | Date == "2/2/2007")
feb$datetime <- paste(feb$Date, feb$Time)
# feb[,"Date"] <- as.Date(feb[,"Date"],"%d/%m/%Y")
feb$datetime <- strptime(feb[,"datetime"], "%d/%m/%Y %H:%M:%S")

feb <- select(feb, -Date, -Time)

#Creating plot1.png
png("plot1.png", width = 480, height = 480)
with(feb, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", 
               col = "red", main = "Global Active Power"))
dev.off()

#Creating plot2.png
png("plot2.png", width = 480, height = 480)
plot(feb$datetime, feb$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

#plot3.png
png("plot3.png", width = 480, height = 480)
plot(feb$datetime, feb$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
legend("topright", col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", 
                  "Sub_metering_3"), lty= c(1,1,1))
points(feb$datetime, feb$Sub_metering_2, col = "red", 
       type = "l")
points(feb$datetime, feb$Sub_metering_3, col = "blue", 
       type = "l")
dev.off()

#plot4.png
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(feb$datetime, feb$Global_active_power, xlab = "", 
     ylab ="Global Active Power", type = "l")
with(feb, plot(datetime, Voltage, type = "l"))
plot(feb$datetime, feb$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
legend("topright", col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", 
                  "Sub_metering_3"), lty= c(1,1,1), bty = "n")
points(feb$datetime, feb$Sub_metering_2, col = "red", 
       type = "l")
points(feb$datetime, feb$Sub_metering_3, col = "blue", 
       type = "l")
with(feb, plot(datetime, Global_reactive_power, 
               type = "l"))
dev.off()

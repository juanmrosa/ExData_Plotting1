## Read the data
PowerData <- read.table("./household_power_consumption.txt", header = TRUE,
                        sep =";", na.strings = c("?",""),
                        stringsAsFactors = FALSE)

## Correct the classes of Date, Time and Sub Metering variables
PowerData$Date <- as.Date(PowerData$Date, format="%d/%m/%Y")
PowerData$Temp <- paste(PowerData$Date, PowerData$Time)
PowerData$Time <- strptime(PowerData$Temp, format = "%Y-%m-%d %H:%M:%S")
PowerData$Sub_metering_1 <- as.numeric(PowerData$Sub_metering_1)
PowerData$Sub_metering_2 <- as.numeric(PowerData$Sub_metering_2)
PowerData$Sub_metering_3 <- as.numeric(PowerData$Sub_metering_3)

## Subset data from the dates 2007-02-01 and 2007-02-02
PowerDataFeb07 <- subset(PowerData, Date == "2007-02-01" | Date =="2007-02-02")

# Create Sub Metering line plots
png(file = "plot3.png", width = 480, height = 480)
plot(x = PowerDataFeb07$Time, y = PowerDataFeb07$Sub_metering_1,
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = PowerDataFeb07$Time, y = PowerDataFeb07$Sub_metering_2,
      col = "red", type = "l")
lines(x = PowerDataFeb07$Time, y = PowerDataFeb07$Sub_metering_3,
      col = "blue", type = "l")
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

## Read the data
PowerData <- read.table("./household_power_consumption.txt", header = TRUE,
                        sep =";", na.strings = c("?",""),
                        stringsAsFactors = FALSE)

## Correct the classes of Date, Time, Global Active Power,
## Global Reactive Power, Voltage and Sub Metering variables
PowerData$Date <- as.Date(PowerData$Date, format="%d/%m/%Y")
PowerData$Temp <- paste(PowerData$Date, PowerData$Time)
PowerData$Time <- strptime(PowerData$Temp, format = "%Y-%m-%d %H:%M:%S")
PowerData$Global_active_power <- as.numeric(PowerData$Global_active_power)
PowerData$Global_reactive_power <- as.numeric(PowerData$Global_reactive_power)
PowerData$Voltage <- as.numeric(PowerData$Voltage)
PowerData$Sub_metering_1 <- as.numeric(PowerData$Sub_metering_1)
PowerData$Sub_metering_2 <- as.numeric(PowerData$Sub_metering_2)
PowerData$Sub_metering_3 <- as.numeric(PowerData$Sub_metering_3)

## Subset data from the dates 2007-02-01 and 2007-02-02
PowerDataFeb07 <- subset(PowerData, Date == "2007-02-01" | Date =="2007-02-02")

# Create panel of 4 graphs
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
plot(x = PowerDataFeb07$Time, y = PowerDataFeb07$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power")
plot(x = PowerDataFeb07$Time, y = PowerDataFeb07$Voltage,
     type = "l", xlab = "datetime", ylab = "Voltage")
plot(x = PowerDataFeb07$Time, y = PowerDataFeb07$Sub_metering_1,
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = PowerDataFeb07$Time, y = PowerDataFeb07$Sub_metering_2,
        col = "red", type = "l")
lines(x = PowerDataFeb07$Time, y = PowerDataFeb07$Sub_metering_3,
        col = "blue", type = "l")
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(x = PowerDataFeb07$Time, y = PowerDataFeb07$Global_reactive_power,
     type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

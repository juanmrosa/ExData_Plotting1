## Read the data
PowerData <- read.table("./household_power_consumption.txt", header = TRUE,
                        sep =";", na.strings = c("?",""),
                        stringsAsFactors = FALSE)

## Correct the classes of Date, Time and Global Active Power variables
PowerData$Date <- as.Date(PowerData$Date, format="%d/%m/%Y")
PowerData$Temp <- paste(PowerData$Date, PowerData$Time)
PowerData$Time <- strptime(PowerData$Temp, format = "%Y-%m-%d %H:%M:%S")
PowerData$Global_active_power <- as.numeric(PowerData$Global_active_power)

## Subset data from the dates 2007-02-01 and 2007-02-02
PowerDataFeb07 <- subset(PowerData, Date == "2007-02-01" | Date =="2007-02-02")

## Plot histogram of Global Active Power for those 2 days
png("plot1.png", width=480, height=480)
hist(PowerDataFeb07$Global_active_power, col="red", main ="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()

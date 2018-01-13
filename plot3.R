setwd("~/rcoursera")
# setting all variables
fileName <- "./household_power_consumption.txt"
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
compressedFile<-"household_power_consumption.zip"

# downloading file if not exist
if (!file.exists(fileName)) {
    download.file(url, destfile = compressedFile)
    unzip(compressedFile)
    file.remove(compressedFile)
}

# loading file in dataframe
houseHoldData <- read.csv(fileName, stringsAsFactors = FALSE, sep = ";", header = TRUE)
# updating date format
houseHoldData$Date <- as.Date(houseHoldData$Date, format = "%d/%m/%Y")
houseHoldData$Global_active_power <- as.numeric(houseHoldData$Global_active_power)
# subsetting only requried data
filterHouseHoldData <- subset(houseHoldData, Date >= "2007-02-01" & Date <= "2007-02-02")

# Introducing dateTime field
dateTime <- paste(filterHouseHoldData$Date, filterHouseHoldData$Time)
filterHouseHoldData$dateTime <- as.POSIXct(dateTime)

# Setting plot1.png for plot 
png(file = "plot3.png", width = 480, height = 480, units = "px")
# plotting graph of submetering by date date Time
plot(filterHouseHoldData$dateTime,filterHouseHoldData$Sub_metering_1,ylab="Energy sub metering", xlab = "", type = "l")
lines(filterHouseHoldData$dateTime,filterHouseHoldData$Sub_metering_2, col="red")
lines(filterHouseHoldData$dateTime,filterHouseHoldData$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
dev.off()


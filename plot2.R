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
png(file = "plot2.png", width = 480, height = 480, units = "px")
# plotting graph of Global active power by date time stamp
plot(filterHouseHoldData$dateTime,filterHouseHoldData$Global_active_power,ylab="Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()


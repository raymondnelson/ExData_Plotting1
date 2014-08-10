######## R script to read power consumption data from UCI 
# and make plot 3 for Coursera exdata-005
# 8-8-2014
# Raymond Nelson
#
####################

setwd("~/Documents/RAYMOND/Coursera/Exploratory data analysis/project 1")

fileName <- "./household_power_consumption.txt"
if (!file.exists(fileName)) {
        fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
        dFileName <- "./household_power_consumption.zip"
        download.file(fileUrl, destfile = dFileName)
        unzip(dFileName)
}

dat <- read.csv(fileName, sep=";", stringsAsFactors = FALSE)
datDate <- as.POSIXct(strptime(dat$Date, format = "%d/%m/%Y", tz = "GMT"))
febDates <- which(datDate >= strptime("2007-02-01", format = "%Y-%m-%d", tz = "GMT") & datDate <= strptime("2007-02-02", format = "%Y-%m-%d", tz = "GMT"))
subDat <- dat[febDates,]

Global_active_power <- suppressWarnings(as.numeric(subDat$Global_active_power))
dateTime <- strptime(paste(subDat$Date, subDat$Time), format = "%d/%m/%Y %H:%M:%S")
dateTime <- as.POSIXct(dateTime)
plot(dateTime, Global_active_power, type = "l")
plotName <- "plot2.png"
dev.copy(png, plotName)
dev.off()

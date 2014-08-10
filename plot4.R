######## R script to read power consumption data from UCI 
# and make plot 2 for Coursera exdata-005
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
par(mfcol = c(2, 2)) # to arrange the plots in columns

# first plot (same as plot2)
plot(dateTime, Global_active_power, type = "l")

# second plot (same as plot3)
plot(x = dateTime, y = subDat$Sub_metering_1, type = "l", ylab = "Engergy Sub_metering")
points(x = dateTime, y = subDat$Sub_metering_2, type = "l", col = "red")
points(x = dateTime, y = subDat$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1), 
       col = c("black", "red", "blue"))


# third plot 
plot(dateTime, subDat$Voltage, type = "l", ylab = "Voltage")

# fourth plot
plot(dateTime, subDat$Global_reactive_power, type = "l", ylab = "Global_reactive_power")

plotName <- "plot4.png"
dev.copy(png, plotName)

dev.off()

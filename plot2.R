######## R script to read power consumption data from UCI 
# and make plot 1 for Coursera exdata-004
# 7-7-2014
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

febDates <- which(datDate >= strptime("2007-02-01", format = "%Y-%d-%m", tz = "GMT") & datDate <= strptime("2007-02-02", format = "%Y-%d-%m", tz = "GMT"))

subDat <- dat[febDates,]



######################################################
#        Exploratory Data Analysis
#   Johns Hopkins - Coursera exdata-011
#            Course Project 1
#                Graph 2
######################################################
#
#
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(lubridate))
#
###   Read in and examine dataset
#
# if files are stored somewhere other than normal working directory, set it here:
#setwd("C:/Users/Rick/Desktop/Exploratory Data Analysis/Week 1/Homework/Course Project 1")

plot_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
plot_data <- as.data.frame(plot_data)
#str(plot_data)

#
###   put date in desired format
#
plot_data$Date <- strptime(plot_data$Date, format="%d/%m/%Y", tz="")
#plot_data$Date <- dmy(plot_data$Date)
#head(plot_data)

#
###   select only rows for 2007-02-01 and 2007-02-02
#
date1 <- as.POSIXlt("2007-02-01", format="%Y-%m-%d", tz="")
date2 <- as.POSIXlt("2007-02-02", format="%Y-%m-%d", tz="")
plot_data <- plot_data[(plot_data$Date == date1 | plot_data$Date == date2), ]

#
###   put time in desired format
#
dates <- as.character(plot_data$Date)
times <- as.vector(plot_data$Time)
timeStamps <- paste(dates, times)

plot_data$Time <- strptime(timeStamps, format = "%Y-%m-%d %H:%M:%S", tz="")
#plot_data$Time <- hms(timeStamps)
#head(plot_data)
#
###   remove rows with "?"s as NAs
#
 if (sum(plot_data[,"Global_active_power"]=="?") == TRUE) {
   plot_data <- plot_data[plot_data[,!"Global_active_power"]=="?",]
 }
#length(plot_data[,"Global_active_power"])
#sum(plot_data[,"Global_active_power"]=="?")
#sum(is.na(plot_data$Global_active_power))

#
###   open png file as graphics device
#
if (file.exists("./plot2.png")) file.remove("./plot2.png")
png("plot2.png", height = 480, width = 480, bg = "white")

#
###   plot values as line
#
with(plot_data, plot(Time, Global_active_power, type="n",
   ylab ="Global Active Power (kilowatts)",
   xlab = "",
   bg = "white"))
with(plot_data, lines(Time, Global_active_power))

#
###   close device to save plot as .png file
#
dev.off() 






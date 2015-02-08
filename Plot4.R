
######################################################
#        Exploratory Data Analysis
#   Johns Hopkins - Coursera exdata-011
#            Course Project 1
#                Graph 4
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
 if (sum(plot_data[,"Sub_metering_1"]=="?") == TRUE) {
   plot_data <- plot_data[plot_data[,!"Sub_metering_1"]=="?",]
 }
if (sum(plot_data[,"Sub_metering_2"]=="?") == TRUE) {
  plot_data <- plot_data[plot_data[,!"Sub_metering_2"]=="?",]
}
if (sum(plot_data[,"Sub_metering_3"]=="?") == TRUE) {
  plot_data <- plot_data[plot_data[,!"Sub_metering_3"]=="?",]
}
#length(plot_data[,"Sub_metering_1"])
#sum(plot_data[,"Sub_metering_1"]=="?")
#sum(is.na(plot_data$Sub_metering_1))

#
###   open png file as graphics device
#
if (file.exists("./plot4.png")) file.remove("./plot4.png")
png("plot4.png", height = 480, width = 480, bg = "white")

#
###   set up 2x2 plot panes
#
par(mfrow = c(2,2))
#
###   plot data in pane 1
#
with(plot_data, {plot(Time, Global_active_power, type="n",
                     ylab ="Global Active Power",
                     xlab ="",
                     bg = "white")
                 lines(Time, Global_active_power)
     
#
###   plot data in pane 2
#
                 plot(Time, Voltage, type="n",
                     ylab ="Voltage",
                     xlab ="datetime",
                     bg = "white")
                 lines(Time, Voltage, col="black")

#
###   plot data in pane 3
#
                plot(Time, Sub_metering_1, type="n",
                    ylab ="Energy sub metering",
                    xlab ="",
                    bg = "white")
                lines(Time, Sub_metering_1, col="black")
                lines(Time, Sub_metering_2, col="red")
                lines(Time, Sub_metering_3, col="blue")
                legend("topright", col = c("black", "red", "blue"), 
                      legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
                      bty = "n",
                      lty = "solid")

#
###   plot data in pane 4
#
                plot(Time, Global_reactive_power, type="n",
                    ylab ="Global_reactive_power",
                    xlab ="datetime",
                    bg = "white")
                lines(Time, Global_reactive_power, col="black")

})
#
###   close device to save plot as .png file
#
dev.off() 






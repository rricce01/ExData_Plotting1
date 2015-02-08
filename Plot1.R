
######################################################
#        Exploratory Data Analysis
#   Johns Hopkins - Coursera exdata-011
#            Course Project 1
#                Graph 1
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
###   put data in desired formats
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
if (file.exists("./plot1.png")) file.remove("./plot1.png")
png("plot1.png", height = 480, width = 480, bg = "white")

#
###   plot values as histogram
#
hist(as.numeric(plot_data$Global_active_power), 
     col = "red", 
     main = "Global Active Power", 
     xlab ="Global Active Power (kilowatts)",  
     bg = "white")
         
#
###   close device to save plot as .png file
#
dev.off() 






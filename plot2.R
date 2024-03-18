library(dplyr)
library(tidyr)
library(lubridate)
library(datasets)

fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <-download.file(fileUrl,destfile = "household_power_consumption.zip",method ="curl")
unzip_file <-unzip("household_power_consumption.zip")

data <- read.table("household_power_consumption.txt",header = TRUE,sep =";",na.strings = "?")
#create new column Date_time 
datetime <- paste(data$Date,data$Time)
datetime <- as.POSIXct(datetime,format = "%d/%m/%Y %H:%M:%S")
data<-mutate(data,Date_time = datetime)

# convert Date column to data object
data$Date <-as.Date(data$Date,format = "%d/%m/%Y")
data <- data[(data$Date=="2007-02-01"| data$Date=="2007-02-02"), ]

plot(Global_active_power ~ Date_time, data,type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA)

dev.copy(png,"plot2.png",width=480,height = 480)
dev.off()

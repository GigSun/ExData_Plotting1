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

# convert Date column to data object and filter dataset 
data$Date <-as.Date(data$Date,format = "%d/%m/%Y")
data <- data[(data$Date=="2007-02-01"| data$Date=="2007-02-02"), ]

par(mfrow = c(2,2))
plot(data$Global_active_power~data$Date_time,type ="l",ylab = "Global Active Power")
plot(data$Voltage~data$Date_time,  type ="l",ylab = "Global Active Power")
plot(data$Sub_metering_1~data$Date_time,type="l",ylab = "Energy sub metering",xlab = "")
lines(data$Sub_metering_3 ~ data$Date_time,col="blue")
lines(data$Sub_metering_2 ~ data$Date_time,col="red")
legend("topright",lty = 1 ,col = c("black","red","blue"),legend =c("Sub_metering_1","sub_metering_2","sub_metering_3"))
plot(data$Global_reactive_power~data$Date_time,  type ="l",ylab = "Global Active Power")

dev.copy(png,"plot4.png",width =480,height =480)
dev.off()

#Imports the data, formats and combines the date and time, subsets to the dates of interest

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
# imports data, separating by ';', assigning classes to each column

data$Date <- as.Date(data$Date, "%d/%m/%Y")
# converts characters into dates

data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
# selects the date range

data <- data[complete.cases(data),]
# keeps only complete cases

dTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
# combines date and time into one object

dTime <- setNames(dTime, "DateTime")
# names the vector

data <- data[ ,!(names(data) %in% c("Date","Time"))]
# removes the old columns

data <- cbind(dTime, data)
# adds the new date-time column

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# makes the layout for the plots and sets the margins

with(data, {
  plot(Global_active_power~dTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dTime,col='Red')
  lines(Sub_metering_3~dTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
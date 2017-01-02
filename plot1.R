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

hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
# plots Global Active Power vs Frequency

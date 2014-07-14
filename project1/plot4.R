#zip file name
myzip = "exdata_data_household_power_consumption.zip"
#if data file has not yet been downloaded, fetch it
if (!file.exists(myzip)) {
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
destfile=myzip)
unzip(myzip)
}

#read the data
dfData<-read.table("household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.string="?",stringsAsFactors=FALSE)

#Subset the data to have the rows from 1/2/2007 and 2/2/2007
range<-dfData[with(dfData, Date=="1/2/2007"|Date=="2/2/2007"), ]
#merge covert date and Time column to date format
dateTime <- strptime( paste(range$Date,range$Time), format="%d/%m/%Y %H:%M:%S")
range$Datetime <- dateTime

#Plot to the file directly to get a better resolution
png(file="plot4.png")
par(mfcol=c(2,2))
#First plot
with(range,plot(range$Datetime,range$Global_active_power,type="s",ylab="Global Active Power(kilowatts)",xlab=""))
#Second Plot
with(range,plot(range$Datetime,range$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
lines (range$Datetime,range$Sub_metering_2,type = "l", col = "red")
points (range$Datetime,range$Sub_metering_3,type = "l", col = "blue")
legend("topright", lty = 1, bty="n",col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
#3rd plot
with(range,plot(range$Datetime,range$Voltage,type="l",xlab="datetime",ylab="Voltage",col="black"))
#4th plot
with(range,plot(range$Datetime,range$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",col="black"))
dev.off()
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
png(file="plot3.png")
#Draw the plot
with(range,plot(range$Datetime,range$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
#Add elements
lines (range$Datetime,range$Sub_metering_2,type = "l", col = "red")
points (range$Datetime,range$Sub_metering_3,type = "l", col = "blue")
#Add the legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
#dev.copy(png,file="./plot3.png")
dev.off()
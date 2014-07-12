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
#Plot the graph
hist(range$Global_active_power,col="red",freq=TRUE,main="Global Active Power",xlab="Global Active Power(kilowatts)")

#Store the data in png file
dev.copy(png,file="./plot1.png")
dev.off()
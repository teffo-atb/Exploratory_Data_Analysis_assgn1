# This program downloads data from Electric power consumption website and produced four plots on one box
# the exection of the program organized in four steps as follows

## STEP 1: Setup working directory
setwd("C:\\rproj\\Exploratory_Data_Analysis\\assig1\\")

## STEP 2: Download zipped file and unzipped it in the working folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="elec1.zip")
data <- unzip("elec1.zip")
assgndata <- read.table(data, sep=";", head = T, na.strings="?", stringsAsFactors=F)
# calculating memory requirements
(2075259 * 9 * 8)/2^20 # bytes/numeric
# 142.4967 MB

## STEP 3: Subsetting the dataset from the dates 2007-02-01 and 2007-02-02 and combined data/time
subdata <- subset(assgndata, Date == "1/2/2007" | Date =="2/2/2007")
rm(assgndata)
str(subdata)
subdata$x <- paste(subdata$Date, subdata$Time)
subdata$datatime <- strptime(subdata$x,format="%d/%m/%Y %H:%M:%S")


## STEP 4: Ploting Global Active Power, Voltage, Energey Sub Metering and Global Reactive Power by Date/Time on one box
# Plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(subdata,{
    plot(subdata$datatime, subdata$Global_active_power, type= "l", xlab = "datetime", ylab  = "Global Active Power (kilowatts)")
    plot(subdata$datatime, subdata$Voltage, type= "l",xlab = "datetime", ylab  = "Voltage")
    
    plot(subdata$datatime, subdata$Sub_metering_1, col="black", type="l", xlab = "datetime", ylab = "Energy sub metering")
    box()
    lines(subdata$datatime,subdata$Sub_metering_2, type="l",col="red")
    lines(subdata$datatime,subdata$Sub_metering_3, type="l",col="blue")
    legend("topright", lty=c(1,1,1), col = c("black","blue","red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(subdata$datatime, subdata$Global_reactive_powe, type= "l", xlab = "datetime", ylab  = "Global_reactive_power")
    
})
dev.off()
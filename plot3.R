############################################################################################
# 1. Download data-set into working directory and unzip
############################################################################################

setwd("C:/Users/dsanz001/Desktop/Clients/Data Science/Coursera/Exploratory Data Analysis/Project 1/ExData_Plotting1/")
if(!file.exists("./data")){
  dir.create("./data")
}

file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.dest <- "data/household_power_consumption.zip"

download.file(file.url,file.dest,method="auto")

unzip(file.dest,exdir="data")

############################################################################################
# 2. Read in text file and subset data to only include dates 1/2/2007 and 2/2/2007
############################################################################################

data.file <- "./data/household_power_consumption.txt"
data <- read.table(data.file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
data.subset <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

############################################################################################
# 3. Change values to be plotted to numeric and combine date and time features to create 
#    datetime value for plotting
############################################################################################

sub.metering.1 <- as.numeric(data.subset$Sub_metering_1)
sub.metering.2 <- as.numeric(data.subset$Sub_metering_2)
sub.metering.3 <- as.numeric(data.subset$Sub_metering_3)
datetime <- strptime(paste(data.subset$Date, data.subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

############################################################################################
# 4. Plot sub metering lines 1-3 and create legend
############################################################################################

png("plot3.png", width=480, height=480)
plot(datetime, sub.metering.1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, sub.metering.2, type="l", col="red")
lines(datetime, sub.metering.3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
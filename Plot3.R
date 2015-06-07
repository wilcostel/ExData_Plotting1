## Function to get the data 
getData<-function(bestand) {
  
## Getting full dataset  
data_full <- read.csv(bestand, header=T, sep=';', na.strings="?")
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

datetime<- paste(as.Date(data$Date),data$Time)
data$datetime <- as.POSIXct(datetime)

## returning the data 
return (data)
}

## calling the get Data function

data<-getData("household_power_consumption.txt")


## Making the plot

with(data, {
  plot(Sub_metering_1~datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       
       
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copying the plot

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


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

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(data, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(datetime,Voltage, type="l", 
       ylab="Voltage (volt)")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime,Global_reactive_power, type="l", 
       ylab="Global Rective Power (kilowatts)")
})

## Copying the plot
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
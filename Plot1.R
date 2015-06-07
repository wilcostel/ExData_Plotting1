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

hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Copying the plot

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()


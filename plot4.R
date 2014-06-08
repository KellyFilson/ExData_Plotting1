## This script uses a 2x2 canvas to display the following household_power_consumption plots based on data recorded 
## for Feb 1 and 2, 2007:
## (1,1) - Scatterplot; x=Observation Timestamp, y=Global Active Power
## (1,2) - Scatterplot; x=Observation Timestamp, y=Voltage
## (2,1) - Scatterplot; x=Observation Timestamp, y=Energy sub metering
## (2,2) - Scatterplot; x=Observation Timestamp, y=Global reactive Power

## read source data
## (a) Known - The source data has 2075259 rows - we can use that to minimize memory usage
## (b) Known - Missing values are coded as "if" ... hence, otherwise numeric columns will be interpreted as character
## using stringsAsFactors=FALSE ensures that all columns are received as character (rather than Factor)
data <- read.table( "household_power_consumption.txt", header=TRUE, sep=";", nrows=2075259, comment.char="", 
                    stringsAsFactors=FALSE )

## Filter data, keeping only data for Dates = Feb1&2, 2007
fdata <- data[ (data$Date=="1/2/2007" | data$Date=="2/2/2007") & data$Global_active_power!="if", ]

## Open a png graphics device - as requested width&height=480 (although, this is the default)
png( "plot4.png", width=480, height=480 )

## We'll be plotting x=Minutes since Start of Day on Feb 1, 2007
## We need to calculate that Start of Day to use in our data arithmetic
startOfPeriod <- strptime( "01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S" )

## define our grid (2x2) - which we'll traverse by row
par( mfrow=c(2,2) )

## =================
## plot (1,1) - Scatterplot; x=Observation Timestamp, y=Global Active Power
plot( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Global_active_power ), type="l", xaxt="n",
      xlab="", ylab="Global Active Power" )

## Add x-axis ... Note: x-axis scaled in minutes 
axis( side=1, at=c(0,1*60*24,2*60*24), 
      labels=c(weekdays(as.Date("1/2/2007",format="%d/%m/%Y"),abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+1,abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+2,abbreviate=TRUE) ) )

## =================
## plot (1,2) - Scatterplot; x=Observation Timestamp, y=Voltage
plot( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Voltage ), type="l", xaxt="n",
      xlab="datetime", ylab="Voltage" )

## Add x-axis ... Note: x-axis scaled in minutes 
axis( side=1, at=c(0,1*60*24,2*60*24), 
      labels=c(weekdays(as.Date("1/2/2007",format="%d/%m/%Y"),abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+1,abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+2,abbreviate=TRUE) ) )

## =================
## (2,1) - Scatterplot; x=Observation Timestamp, y=Energy sub metering
plot( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Sub_metering_1 ), type="n", xaxt="n", 
      xlab="", ylab="Energy sub metering" )

## Plot Points for Sub Meter 1 - type=line, color=black ... /60 to get result in minutes
points( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Sub_metering_1 ), type="l", col="black" )
## Plot Points for Sub Meter 2 - type=line, color=red ... /60 to get result in minutes
points( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Sub_metering_2 ), type="l", col="red" )
## Plot points for Sub Meter 3 - type=line, color=blue ... /60 to get result in minutes
points( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Sub_metering_3 ), type="l", col="blue" )

## Add x-axis ... Note: x-axis scaled in minutes 
axis( side=1, at=c(0,1*60*24,2*60*24), 
      labels=c(weekdays(as.Date("1/2/2007",format="%d/%m/%Y"),abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+1,abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+2,abbreviate=TRUE) ) )

## Add a legend to distinguish sub metering by color
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n" )

## =================
## plot (2,2) - Scatterplot; x=Observation Timestamp, y=Global reactive Power
plot( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Global_reactive_power ), type="l", xaxt="n",
      xlab="datetime", ylab="Global_reactive_power" )

## Add x-axis ... Note: x-axis scaled in minutes 
axis( side=1, at=c(0,1*60*24,2*60*24), 
      labels=c(weekdays(as.Date("1/2/2007",format="%d/%m/%Y"),abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+1,abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+2,abbreviate=TRUE) ) )

## Close the graphics device
dev.off()


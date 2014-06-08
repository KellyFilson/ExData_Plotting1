## This script produces a scatterplot from household_power_consumption: x=Minutes since Start of Day on Feb 1, 2007 for
## each of Sub Metering 1 (black), 2 (red), 3 (blue), y=Global_active_power - for the days Feb 1&2, 2007
## This scatterplot is rendered to plot3.png
## Both the source data and the .png file will exist in the current working directory

## read source data
## (a) Known - The source data has 2075259 rows - we can use that to minimize memory usage
## (b) Known - Missing values are coded as "if" ... hence, otherwise numeric columns will be interpreted as character
## using stringsAsFactors=FALSE ensures that all columns are received as character (rather than Factor)
data <- read.table( "household_power_consumption.txt", header=TRUE, sep=";", nrows=2075259, comment.char="", 
                    stringsAsFactors=FALSE )

## Filter data, keeping only data for Dates = Feb1&2, 2007
fdata <- data[ (data$Date=="1/2/2007" | data$Date=="2/2/2007") & data$Global_active_power!="if", ]

## Open a png graphics device - as requested width&height=480 (although, this is the default)
png( "plot3.png", width=480, height=480 )

## We'll be plotting x=Minutes since Start of Day on Feb 1, 2007
## We need to calculate that Start of Day to use in our data arithmetic
startOfPeriod <- strptime( "01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S" )

## Initial plot will be empty (type=n=none=empty)- we'll add 3 sets of points afterward , 1 for each sub meter
## Using Sub Meter 1 for the y-axis of this initial plot sets the y-axis as required (it has higher values
## than the other sub meters)
## xaxis (none), xlab (none), and ylab (as requested) can be defined at this point
## x axis will be added later
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
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1 )

## Close the graphics device
dev.off()


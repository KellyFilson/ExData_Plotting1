## This script produces a scatterplot from household_power_consumption: x=Minutes since Start of Day on Feb 1, 2007, 
## y=Global_active_power - for the days Feb 1&2, 2007
## This scatterplot is rendered to plot2.png
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
png( "plot2.png", width=480, height=480 )

## We'll be plotting x=Minutes since Start of Day on Feb 1, 2007
## We need to calculate that Start of Day to use in our data arithmetic
startOfPeriod <- strptime( "01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S" )

## Plot - Scatterplot for x=Minutes since Start of Day on Feb 1, 2007, y=Global_active_power; y label as requested;
##        no x axis - it will be added next; divide by 60 to convert to minutes; type="l" (line)
plot( as.numeric(strptime( paste( fdata$Date, fdata$Time ), format="%d/%m/%Y %H:%M:%S" ) - startOfPeriod )/60, 
      as.numeric( fdata$Global_active_power ), type="l", xaxt="n",
      xlab="", ylab="Global Active Power (kilowatts)" )

## Add x-axis ... Note: x-axis scaled in minutes 
axis( side=1, at=c(0,1*60*24,2*60*24), 
      labels=c(weekdays(as.Date("1/2/2007",format="%d/%m/%Y"),abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+1,abbreviate=TRUE),
               weekdays(as.Date("1/2/2007",format="%d/%m/%Y")+2,abbreviate=TRUE) ) )

## Close the graphics device
dev.off()


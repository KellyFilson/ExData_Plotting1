## This script plots a histogram of household_power_consumption$Global_active_power for the days Feb 1&2, 2007
## This histogram is rendered to plot1.png
## Both the source data and the .png file will exist in the current working directory

## read source data
## (a) Known - The source data has 2075259 rows - we can use that to minimize memory usage
## (b) Known - Missing values are coded as "if" ... hence, otherwise numeric columns will be interpreted  as character
## using stringsAsFactors=FALSE ensures that all columns are received as character (rather than Factor)
data <- read.table( "household_power_consumption.txt", header=TRUE, sep=";", nrows=2075259, comment.char="", 
                    stringsAsFactors=FALSE )

## Filter data, keeping only data for Dates = Feb1&2, 2007
fdata <- data[ (data$Date=="1/2/2007" | data$Date=="2/2/2007") & data$Global_active_power!="if", ]

## Open a png graphics device - as requested width&height=480 (although, this is the default)
png( "plot1.png", width=480, height=480 )

## Plot - Histogram for Global_active_power; main title & x-axis label as requested
hist( as.numeric( fdata$Global_active_power ), col="red", main="Global Active Power", 
      xlab="Global Active Power (kilowatts)" )

## Close the graphics device
dev.off()


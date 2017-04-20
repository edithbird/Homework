setwd("/Users/Chris Iyer/Documents/")
library(forecast)
library(caret)
library(dplyr)
library(xts)
library(zoo)
rainfall <- read.csv("MelbourneRainfall.csv")
rainfall <- rainfall %>% rename(mmDay = Rainfall.amount..millimetres.)

tail(rainfall)
#convert to ts
rainfall.ts <- ts(rainfall$mmDay, start = c(2000, 1), frequency = 360)
#partition
time <- time(rainfall.ts)
validLength <- 672
trainLength <- length(rainfall.ts) - validLength
train.ts <- window(rainfall.ts, start = time[1], end = time[trainLength])
valid.ts <- window(rainfall.ts, start = time[trainLength + 1], end = time[trainLength + validLength])
yearlyRainfall <- aggregate(rainfall.ts, nfrequency = 12, FUN = sum)
plot(yearlyRainfall, ylab = "Rainfall in mm", xlab = "Year")

# set the outer margin area to the right a bit bigger
par(oma = c(0, 0, 0, 2))

# We have 13.25 years of data
xrange <- c(1,13)
# Get the range of the ridership to set up a nicely formatted plot
yrange <- range(yearlyRainfall)
length(yearlyRainfall)

# set up the plot 
plot(xrange, yrange, type="n", xlab="Year", ylab="Rainfall", bty="l")

# Give each of the months its own color, line type, and character
colors <- rainbow(12) 
linetype <- c(1:12) 
plotchar <- c(1:12)

# add lines 
for (i in 1:12) { 
  currentMonth <- subset(yearlyRainfall, cycle(yearlyRainfall)==i)
  lines(currentMonth, type="b", lwd=1.5,
        lty=linetype[i], col=colors[i], pch=plotchar[i]) 
} 

# add a title
title("Rainfall Broken Out by Month")

# add a legend 
legend(12.5,150, 1:12, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Month", xpd=NA)


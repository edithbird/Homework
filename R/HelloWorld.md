
---
title: "Hello World Predictive Analytics Assignment 1"
author: "Christine Iyer"
date: "January 20, 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## HelloWorld

```{r}
happy <- readLines("http://www.slate.com/full_slate.html?wpisrc=burger_bar")
head(happy)
```


```{r}
travel <- read.csv("travel911.csv", header = TRUE, stringsAsFactors = FALSE)
#travel <- travel[-c(1:2), ]
names(travel)

names(travel)[1:4] <- c("month_yr", "air.miles", "rail.miles", "car.miles.in.billions")
air.travel.ts <- ts(travel$air.miles, start = c(1990, 1), end = c(2004, 5), frequency = 12)

plot(air.travel.ts, xlab = "Year", ylab = "Airline Revenue Passenger Miles", type = "l",  bty = "l",  main = "Airline Revenue Passenger Miles")

abline(v = c(2001.75), col = "blue")
```


```{r}
rail.travel.ts <- ts(travel$rail.miles, start = c(1990, 1), end = c(2004, 5), frequency = 12)
plot(rail.travel.ts, xlab = "Year", ylab = "Rail Passenger Miles",bty = "l", 
     pch = 20, main = "Rail Passenger Miles")
abline(v = c(2001.75), col = "blue")

```


```{r}
car.travel.ts <- ts(travel$car.miles.in.billions, start = c(1990, 1), end = c(2004, 5), frequency = 12)
plot(car.travel.ts, xlab = "Year", ylab = "Vehicle Miles Driven (in billions)",bty = "l", main = "Miles Driven (in billions")
abline(v = c(2001.75), col = "blue")
```


###Chapter 1
1. Is the goal of this study descriptive or predictive? 
descriptive


2. What is the forecast horizon to consider in this task? Are next-month forecasts sufficient? 
Next month forecasts are insufficient because of the planning involved in travelling. Both longterm and shorterm forecasts are necessary. THe purpose of the study was to examine the impact of the terrorist event, therefore predictions into various time periods is required. 


3. What level of automation does this forecasting task require? Consider the four questions related to automation. 


4. What is the meaning of t = 1, 2, 3 in the Air series? Which time period does t = 1 refer to? 
5. What are the values for y1, y2, and y3 in the Air series?

ridership.ts <- ts(Amtrak.data$Ridership, start = c(1991,1), end = c(2004, 3), freq = 12) plot(ridership.ts, xlab = "Time", ylab = "Ridership", ylim = c(1300, 2300), bty = "l")

```{r}
library(dplyr)
library(lubridate)
train <- read.csv("Amtrak.csv"#, header = TRUE,  stringsAsFactors = FALSE
                  )
train <- train %>% mutate(Month = mdy(Month))
ridership.ts <- ts(train$Ridership_in_thousands, start = c(1991,1), end = c(2004, 3), frequency = 12)
plot(ridership.ts, xlab = "Time", ylab = "Ridership in 10K", ylim = c(1300, 2300), type = "l")
#lines(ride.lm$fitted, lwd = 2)

is.ts(ridership.ts)
str(ridership.ts)
```





```{r}
library(forecast)

ridership.lm <- tslm(ridership.ts ~ trend + I(trend^2)) 
par(mfrow = c(2, 1)) 
plot(ridership.ts, xlab = "Time", ylab = "Ridership", ylim = c(1300, 2300), bty = "l")
lines(ridership.lm$fitted, lwd = 2) 
ridership.ts.zoom <- window(ridership.ts, start = c(1997, 1), end = c(2000, 12)) 
#ridership.ts.zoom.lm <- window(ridership.ts.zoom ~ trend + I(trend ^ 2))
#plot(ridership.ts.zoom.lm, xlab = "Time", ylab = "Ridership", ylim = c(1300, 2300), bty = "l")


```


```{r}

ridership.lm <- tslm(ridership.ts ~ trend + I(trend^2))
par(mfrow = c(2, 1))
plot(ridership.ts, xlab = "Time", ylab = "Ridership", ylim = c(1300, 2300), bty = "l")
lines(ridership.lm$fitted, lwd = 2)
ridership.ts.zoom <- window(ridership.ts, start = c(1997, 1), end = c(2000, 12))

 
plot(ridership.ts.zoom, xlab = "Time", ylab = "Ridership", ylim = c(1300, 2300), bty = "l")

```
 
###Chapter 2

Impact of September 11 on Air Travel in the United States: The Research and Innovative Technology Administration's Bureau of Transportation Statistics (BTS) conducted a study to evaluate the impact of the September 11, 2001, terrorist attack on U.S. transportation. The study report and the data can be found [here](https://www.rita.dot.gov/bts/sites/rita.dot.gov.bts/files/publications/estimated_impacts_of_9_11_on_us_travel/index.html). The goal of the study was stated as follows: "The purpose of this study is to provide a greater understanding of the passenger travel behavior patterns of persons making long distance trips before and after September 11. The report analyzes monthly passenger movement data between January 1990 and April 2004. Data on three monthly time series are given in the file Sept11Travel.xls for this period: (1) actual airline revenue passenger miles (Air), (2) rail passenger miles (Rail), and (3) vehicle miles traveled (Auto). In order to assess the impact of September 11, BTS took the following approach: Using data before September 11, it forecasted future data (under the assumption of no terrorist attack).
Then, BTS compared the forecasted series with the actual data to assess the impact of the event. Plot each of the three pre-event time series (Air, Rail, Car).


```{r}
travel <- read.csv("travel911.csv", header = TRUE, stringsAsFactors = FALSE)
#travel <- travel[-c(1:2), ]
names(travel)[1:4] <- c("month_yr", "air.miles", "rail.miles", "car.miles.in.billions")
air.travel.ts <- ts(travel$air.miles, start = c(1990, 1), end = c(2001, 8), frequency = 12)

plot(air.travel.ts, xlab = "Year", ylab = "Airline Revenue Passenger Miles", type = "l",  bty = "l",  main = "Airline Revenue Passenger Miles")

#abline(v = c(2001.75), col = "blue")
```


```{r}
rail.travel.ts <- ts(travel$rail.miles, start = c(1990, 1), end = c(2001, 8), frequency = 12)
plot(rail.travel.ts, xlab = "Year", ylab = "Rail Passenger Miles",bty = "l", 
     pch = 20, main = "Rail Passenger Miles")
#abline(v = c(2001.75), col = "blue")

```


```{r}
car.travel.ts <- ts(travel$car.miles.in.billions, start = c(1990, 1), end = c(2001, 8), frequency = 12)
plot(car.travel.ts, xlab = "Year", ylab = "Vehicle Miles Driven (in billions)",bty = "l", main = "Miles Driven (in billions)")
#abline(v = c(2001.75), col = "blue")
```




1. (a) What time series components appear from the plot? 
Air: trend, seasonality
Rail: seasonality, slight down trend
Car: Seasonality, trend



"The systematic part is typically divided into three components: level, trend, and seasonality. The nonsystematic part is called noise."


(b) What type of trend appears? Change the scale of the series, add trend lines, and suppress seasonality to better visualize the trend pattern

```{r}
library(forecast)
library(ggvis)
airlinear <- tslm(air.travel.ts ~ trend)
summary(airlinear)
plot(air.travel.ts, xlab = "Year", ylab = "Airline Revenue Passenger Miles", bty = "l", main = "Air Revenue Passenger Miles")
lines(airlinear$fitted, lwd=2)
airQuad <- tslm(air.travel.ts ~ trend + I(trend^2))
summary(airQuad)
lines(airQuad$fitted, lty = 2, lwd = 3)
ggseasonplot(air.travel.ts, col =rainbow(12), year.labels=TRUE, ylab = "Air Passenger Revenue Miles")
```

```{r}
rail.linear <- tslm(rail.travel.ts ~trend)
summary(rail.linear)
plot(rail.travel.ts, xlab = "Year", ylab = "Rail Passenger Miles", bty = "l", main = "Rail Passenger Miles")
lines(rail.linear$fitted, lwd = 2)
rail.quad <- tslm(rail.travel.ts ~ trend + I(trend^2))
summary(rail.quad)
lines(rail.quad$fitted, lty = 2, lwd = 3)
ggseasonplot(rail.travel.ts, col =rainbow(12), year.labels=TRUE, ylab = "Rail Passenger Revenue Miles")

```

```{r}
car.linear <- tslm(car.travel.ts ~trend)
summary(car.linear)
plot(car.travel.ts, xlab = "Year", ylab = "Car Passenger Miles", bty = "l", main = "Car Passenger Miles")
lines(car.linear$fitted, lwd = 2)
car.quad <- tslm(car.travel.ts ~ trend + I(trend^2))
summary(car.quad)
lines(car.quad$fitted, lty = 2, lwd = 3)
ggseasonplot(car.travel.ts, col =rainbow(12), year.labels=TRUE, ylab = "Car Passenger Revenue Miles")

```

3. Shipments of Household Appliances: The file ApplianceShipments.xls contains the series of quarterly shipments (in millions of USD) of U.S. household appliances between 1985- 1989. 6 6 Data courtesy of Ken Black (a) Create a well-formatted time plot of the data. (b) Which of the four components (level, trend, seasonality, noise) seem to be present in this series?

```{r}
appliances <- read.csv("ApplianceSHipments.csv")
head(appliances)
  appliances.ts <- ts(appliances, start = c(1985, 1),frequency = 4)
plot(appliances.ts, xlab = "Quarter", ylab = "Shipments", bty = "l", main = "Appliance Shipments by Quarter")
```

6. Forecasting Shampoo Sales: The file ShampooSales.xls contains data on the monthly sales of a certain shampoo over a 3-year period.9 9 Source: R. J. Hyndman Time Series Data Library, http://data.is/TSDLdemo; accessed on Mar 28, 2016 (a) Create a well-formatted time plot of the data. (b) Which of the four components (level, trend, seasonality, noise) seem to be present in this series? (c) Do you expect to see seasonality in sales of shampoo? Why?



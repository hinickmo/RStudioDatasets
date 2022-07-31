library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
install.packages("forecast") #for autoplot with geom_smooth linear regression
install.packages("tseries") #for autoplot with geom_smooth linear regression
?datasets
library(help = "datasets")
?AirPassengers

AirPassengers
head(AirPassengers)
#this dataset does not have column names, but that won't stop us

class(AirPassengers) #ts is the output = this means the data is a time series 
start(AirPassengers) #shows first year 
end(AirPassengers) #shows last year

plot(AirPassengers, xlab="Year", ylab="Air Passengers (1,000s)", main="Time Series of Air Passengers", 
     sub="The classic Box & Jenkins airline data. Monthly totals of international airline passengers, 1949 to 1960.")


boxplot(AirPassengers~cycle(AirPassengers),xlab="Date", ylab = "Air Passengers (1,000s)" ,main ="Monthly Air Passengers Boxplot from 1949 to 1961")

autoplot(AirPassengers) + 
  geom_smooth(method="lm")+ 
  labs(x ="Date", y = "Air Passengers (1,000s)", title="Air Passengers from 1949 to 1961") 
  
#ARIMA is an acronym for “autoregressive integrated moving average.” It's a model used in statistics and econometrics to measure events that happen over a period of time.
arimaAirPassengers <- auto.arima(AirPassengers)
arimaAirPassengers

#if the residuals plot is around - w/ no movement, then ARIMA model is a good fit
ggtsdiag(arimaAirPassengers)

#95% confidence looking 48 months into the future
forecastAirPassengers <- forecast(arimaAirPassengers, level = c(95), h = 48)
autoplot(forecastAirPassengers)
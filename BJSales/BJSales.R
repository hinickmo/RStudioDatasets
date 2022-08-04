library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(tseries) #for autoplot with geom_smooth linear regression
library(forecast) #for autoplot with geom_smooth linear regression
?datasets
library(help = "datasets")
?BJsales

BJsales
head(BJsales)


class(BJsales) #ts is the output = this means the data is a time series 
start(BJsales) #shows first year 
end(BJsales) #shows last year

plot(BJsales, xlab="Time", ylab="Sales", main="Sales ", col.main="SteelBlue",
     sub="The data are given in Box & Jenkins (1976). Obtained from the Time Series Data Library at https://robjhyndman.com/TSDL/")

boxplot(BJsales~cycle(BJsales),xlab="Date (unknown scale)", ylab = "Sales (unknown scale)" ,main ="Sales Over Time")

autoplot(BJsales) + 
  geom_smooth(method="lm")+ 
  labs(x ="Date (unknown scale)", y = "Sales (unknown scale)", title="Sales Over Time") 

#ARIMA is an acronym for “autoregressive integrated moving average.” It's a model used in statistics and econometrics to measure events that happen over a period of time.
arimaBJsales <- auto.arima(BJsales)
arimaBJsales

#if the residuals plot is around - w/ no movement, then ARIMA model is a good fit
ggtsdiag(arimaBJsales)

#95% confidence looking 10 months into the future
forecastBJsales <- forecast(arimaBJsales, level = c(95), h = 10)
autoplot(forecastBJsales)



forecastedJsales <- forecast(arimaBJsales, 10)
plot(forecastedJsales, main="Forecast of Sales Over Time", col.main="SteelBlue", ylab = "Sales (unknown scale)", xlab="Date (unknown scale)")

library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)
library(ggcorrplot)
library(tseries) #for autoplot with geom_smooth linear regression
library(forecast)

?datasets
library(help = "datasets")
?JohnsonJohnson

#Quarterly earnings (dollars) per Johnson & Johnson share 1960–80.

JohnsonJohnson
head(JohnsonJohnson)
str(JohnsonJohnson)

#If I want to view raw csv
write.csv(JohnsonJohnson,"C:/Users/Siggi/Downloads/JohnsonJohnson.csv", row.names = FALSE)

class(JohnsonJohnson) #timeseries


plot(JohnsonJohnson, ylab = 'Earnings', main = 'Quarterly Earnings of Johnson & Johnson')
plot(log(JohnsonJohnson), ylab = 'Log of Earnings', main = 'Log Transformed Quarterly Earnings of Johnson & Johnson') 

#If I want to use ggplot you have to switch to data frame and make Date numeric column
JohnsonJohnsonDF<-as.data.frame(JohnsonJohnson) 
JohnsonJohnsonDF$Date <- as.numeric(time(JohnsonJohnson)) 
JohnsonJohnsonDFlog <- log(JohnsonJohnsonDF$x)
JohnsonJohnsonDFlog

ggplot(JohnsonJohnsonDF, aes(x=Date, y=JohnsonJohnson))+
  geom_line()
ggplot(JohnsonJohnsonDF, aes(x=Date, y=JohnsonJohnsonDFlog))+
  geom_line()



plot(decompose(log(JohnsonJohnson)))


JJHW1 <- HoltWinters(JohnsonJohnson)
JJHW1

#Custom HoltWinters fitting
JJHW2 <- HoltWinters(JohnsonJohnson, alpha=0.2, beta=0.1, gamma=0.1)
JJHW2

#Visually evaluate the fits
plot(JohnsonJohnson, ylab="value", xlim=c(1960,1981))
lines(JJHW1$fitted[,1], lty=2, col="blue")
lines(JJHW2$fitted[,1], lty=2, col="red")


JJHW1.pred <- predict(JJHW1, 24, prediction.interval = TRUE, level=0.95)
#Visually evaluate the prediction
plot(JohnsonJohnson, ylab="value", xlim=c(1960,1983), ylim=c(0,25))
lines(JJHW1$fitted[,1], lty=2, col="blue")
lines(JJHW1.pred[,1], col="red")
lines(JJHW1.pred[,2], lty=2, col="orange")
lines(JJHW1.pred[,3], lty=2, col="orange")
















#ARIMA is an acronym for “autoregressive integrated moving average.” It's a model used in statistics and econometrics to measure events that happen over a period of time.
arimaJohnsonJohnson <- auto.arima(JohnsonJohnson)
arimaJohnsonJohnson

#if the residuals plot is around - w/ no movement, then ARIMA model is a good fit
ggtsdiag(arimaJohnsonJohnson)
       
#95% confidence looking 10 months into the future
forecastarimaJohnsonJohnson <- forecast(arimaJohnsonJohnson, level = c(95), h = 10)
autoplot(forecastarimaJohnsonJohnson)

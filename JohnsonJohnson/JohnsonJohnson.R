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

#Sources:
#https://rpubs.com/scarden/757860
#https://towardsdatascience.com/time-series-forecasting-in-r-with-holt-winters-16ef9ebdb6c0
#https://www.statology.org/ljung-box-test/
#https://www.r-bloggers.com/2012/07/holt-winters-forecast-using-ggplot2/ 

JohnsonJohnson
head(JohnsonJohnson)
str(JohnsonJohnson)

#If I want to view raw csv
write.csv(JohnsonJohnson,"C:/Users/Siggi/Downloads/JohnsonJohnson.csv", row.names = FALSE)

class(JohnsonJohnson) #timeseries


plot(JohnsonJohnson, ylab = 'Earnings', main = 'Quarterly Earnings of Johnson & Johnson')
#the log will reduce variance
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
plot(JJHW1, JJHW1.pred)

#Custom HoltWinters fitting
JJHW2 <- HoltWinters(JohnsonJohnson, alpha=0.2, beta=0.1, gamma=0.1)
JJHW2

#Visually evaluate the fits
plot(JohnsonJohnson, ylab="value", xlim=c(1960,1981))
lines(JJHW1$fitted[,1], lty=2, col="blue")
lines(JJHW2$fitted[,1], lty=2, col="red")


#Predicting 24 months into future with 95% confidence. 
JJHW1.pred <- predict(JJHW1, 24, prediction.interval = TRUE, level=0.95)
#Visually evaluate the prediction
plot(JohnsonJohnson, ylab="value", xlim=c(1960,1983), ylim=c(0,25))
lines(JJHW1$fitted[,1], lty=2, col="blue")
lines(JJHW1.pred[,1], col="red")
lines(JJHW1.pred[,2], lty=2, col="brown")
lines(JJHW1.pred[,3], lty=2, col="brown")




#seasonality prediction 
JJHW3 <- HoltWinters(JohnsonJohnson, seasonal = "multiplicative")
JJHW3.pred <- predict(JJHW3, 24, prediction.interval = TRUE, level=0.95)
plot(JohnsonJohnson, ylab="value", xlim=c(1960,1983), ylim=c(0,25))
lines(JJHW3$fitted[,1], lty=2, col="blue")
lines(JJHW3.pred[,1], col="red")
lines(JJHW3.pred[,2], lty=2, col="brown")
lines(JJHW3.pred[,3], lty=2, col="brown")



#Using forecast (similar to ARIMA)
JJHW1_forecast <- forecast(JJHW1, h=12, level=c(80,95))
plot(JJHW1_forecast, xlim=c(1960,1983))
lines(JJHW1_forecast$fitted, lty=2, col="red")

#acf bars should be within blue bars if there is correlation of fit residuals.
acf(JJHW1_forecast$residuals, lag.max=20, na.action=na.pass)
#Ideally, we would like to fail to reject the null hypothesis. That is, 
#we would like to see the p-value of the test be greater than 0.05 because
#this means the residuals for our time series model are independent, which 
#is often an assumption we make when creating a model.
Box.test(JJHW1_forecast$residuals, lag=20, type="Ljung-Box")
#no skew is good!
hist(JJHW1_forecast$residuals)









#ARIMA METHOD

#ARIMA is an acronym for “autoregressive integrated moving average.” It's a model used in statistics and econometrics to measure events that happen over a period of time.
arimaJohnsonJohnson <- auto.arima(JohnsonJohnson)
arimaJohnsonJohnson

#if the residuals plot is around - w/ no movement, then ARIMA model is a good fit
ggtsdiag(arimaJohnsonJohnson)
       
#95% confidence looking 10 months into the future
forecastarimaJohnsonJohnson <- forecast(arimaJohnsonJohnson, level = c(80,95), h = 12)
autoplot(forecastarimaJohnsonJohnson)





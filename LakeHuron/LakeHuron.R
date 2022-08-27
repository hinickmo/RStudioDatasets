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
?LakeHuron

#Annual measurements of the level, in feet, of Lake Huron 1875–1972.


LakeHuron
head(LakeHuron)
str(LakeHuron)

#If I want to view raw csv
write.csv(LakeHuron,"C:/Users/Siggi/Downloads/LakeHuron.csv", row.names = FALSE)

class(LakeHuron) #timeseries

plot(LakeHuron, ylab = 'Water Level (Feet)', main = 'Lake Huron Annual Water Level 1875-1972')
#the log will reduce variance
plot(log(LakeHuron), ylab = 'Log of Water Level (Feet)', main = 'Log Transformed Lake Huron Annual Water Level 1875-1972')

acf(LakeHuron)

ts.plot(filter(LakeHuron,rep(1,17),method="convolution"))  

#gradual decrease as the lags increase (this signifies a trend in the time series)
ggAcf(LakeHuron)
ggPacf(LakeHuron)


# forecasting model using arima model Autoregressive Integrated Moving Average Model
#the mean value appears to be follow a pattern downward, so we can't use a simple ARMA model.
fit <- auto.arima(LakeHuron) #(0,1,0)
fit2 <- arima(LakeHuron, order=c(1,1,1))
fit3 <- arima(LakeHuron, order=c(0,1,5))

#AICc: The information score of the model (the lower-case ‘c’ indicates that the value has been calculated from the 
#AIC test corrected for small sample sizes). The smaller the AIC value, the better the model fit.
fit
fit2 
fit3

# Next 5 forecasted values
forecast(fit, 12)
forecast(fit2, 12)
forecast(fit3, 12)


tsdiag(fit)
tsdiag(fit2)
tsdiag(fit3)


#if the residuals plot is around - w/ no movement, then ARIMA model is a good fit
ggtsdiag(fit)
ggtsdiag(fit2)
ggtsdiag(fit3)

Box.test(fit$residuals,lag=1)
Box.test(fit2$residuals,lag=1)
Box.test(fit3$residuals,lag=1)

LH.pred<-predict(fit,n.ahead=6)
LH.pred2<-predict(fit2,n.ahead=6)
LH.pred3<-predict(fit3,n.ahead=6)

plot(LakeHuron,xlim=c(1875,1980),ylim=c(575,584)) 

LH.pred<-predict(fit,n.ahead=6) 
lines(LH.pred$pred,col="red") 
lines(LH.pred$pred+2*LH.pred$se,col="red",lty=3) 
lines(LH.pred$pred-2*LH.pred$se,col="red",lty=3)

LH.pred2<-predict(fit2,n.ahead=6) 
lines(LH.pred2$pred,col="red") 
lines(LH.pred2$pred+2*LH.pred$se,col="red",lty=3) 
lines(LH.pred2$pred-2*LH.pred$se,col="red",lty=3)

LH.pred3<-predict(fit3,n.ahead=6) 
lines(LH.pred3$pred,col="red") 
lines(LH.pred3$pred+2*LH.pred$se,col="red",lty=3) 
lines(LH.pred3$pred-2*LH.pred$se,col="red",lty=3)


plot(LH.pred, ylab = 'Water Level (Feet)', main = 'Lake Huron Annual Water Level 1875-1972')











#error "time series has no or less than 2 periods"
plot(decompose(log(LakeHuron)))


#Gamma = season / Beta = trend. False for gamma since this is annual data, not quarterly or monthly.
HWLakeHuron = HoltWinters(LakeHuron, gamma=FALSE, beta=TRUE)
HWLakeHuron




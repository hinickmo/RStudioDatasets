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





# forecasting model using arima model Autoregressive Integrated Moving Average Model
fit <- auto.arima(LakeHuron)
fit2 <- arima(LakeHuron, order=c(1,0,1))

# Next 5 forecasted values
forecast(fit, 12)
forecast(fit2, 12)

tsdiag(fit)
tsdiag(fit2)

#if the residuals plot is around - w/ no movement, then ARIMA model is a good fit
ggtsdiag(fit)
ggtsdiag(fit2)

Box.test(fit$residuals,lag=1)
Box.test(fit2$residuals,lag=1)



LH.pred<-predict(fit2,n.ahead=8)


plot(LakeHuron,xlim=c(1875,1980),ylim=c(575,584)) 

LH.pred<-predict(fit2,n.ahead=8) 
lines(LH.pred$pred,col="red") 
lines(LH.pred$pred+2*LH.pred$se,col="red",lty=3) 
lines(LH.pred$pred-2*LH.pred$se,col="red",lty=3)

plot(LH.pred, ylab = 'Water Level (Feet)', main = 'Lake Huron Annual Water Level 1875-1972')











#error "time series has no or less than 2 periods"
plot(decompose(log(LakeHuron)))


#Gamma = season / Beta = trend. False for gamme since this is annual data, not quarterly or monthly.
HWLakeHuron = HoltWinters(LakeHuron, gamma=FALSE, beta=TRUE)
HWLakeHuron




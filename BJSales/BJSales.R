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


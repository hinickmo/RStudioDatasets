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

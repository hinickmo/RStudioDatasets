library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)
library(ggcorrplot)

?datasets
library(help = "datasets")
?JohnsonJohnson

#Quarterly earnings (dollars) per Johnson & Johnson share 1960–80.

JohnsonJohnson
head(JohnsonJohnson)

#If I want to view raw csv
write.csv(JohnsonJohnson,"C:/Users/Siggi/Downloads/JohnsonJohnson.csv", row.names = FALSE)

class(JohnsonJohnson) #ts



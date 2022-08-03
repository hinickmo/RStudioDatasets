library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)

?datasets
library(help = "datasets")
?ChickWeight

ChickWeight
head(ChickWeight)

class(ChickWeight) #data frame

#The body weights of the chicks were measured at birth and every second day thereafter until day 20. 
#They were also measured on day 21. There were four groups on chicks on different protein diets.

#same thing as basic ggplot
qplot(Time, weight, data=ChickWeight, color=factor(Diet), facets = Diet ~ .,
      geom=c("point", "smooth"), 
      main="Protein Diet Versus Chick Weight ", xlab = "Time (days)", ylab = "Chick Weight (gm)" )



ggplot(ChickWeight, aes(x=Diet, y=weight)) + 
  geom_boxplot()

ggplot(ChickWeight, aes(x=Chick, y=weight)) + 
  geom_boxplot()

t.test(ChickWeight$weight ~ ChickWeight$Diet)

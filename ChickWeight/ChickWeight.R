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

tail(ChickWeight)

chick0 <- ChickWeight[ChickWeight$Time %in% 0:5, ]
chick1 <- ChickWeight[ChickWeight$Time %in% 6:10, ]
chick2 <- ChickWeight[ChickWeight$Time %in% 11:15, ]
chick3 <- ChickWeight[ChickWeight$Time %in% 16:21, ]

chick0
chick1
chick2
chick3



par(mfrow = c(2,2)) 
boxplot(chick0$weight ~ chick0$Diet, 
        main = "Chick Weight By Diet Type (0-5 Days)",
        xlab = "Diet Types",
        ylab = "Weight",
        ylim = c(0, 300))
boxplot(chick1$weight ~ chick1$Diet, 
        main = "Chick Weight By Diet Type (6-10 Days)",
        xlab = "Diet Types",
        ylab = "Weight",
        ylim = c(0, 300))
boxplot(chick2$weight ~ chick2$Diet, 
        main = "Chick Weight By Diet Type (11-15 Days)",
        xlab = "Diet Types",
        ylab = "Weight",
        ylim = c(0, 300))
boxplot(chick3$weight ~ chick3$Diet, 
        main = "Chick Weight By Diet Type (16-21 Days)",
        xlab = "Diet Types",
        ylab = "Weight",
        ylim = c(0, 300))




chickDiet1 <- ChickWeight[ChickWeight$Diet == 1, ]
chickDiet2 <- ChickWeight[ChickWeight$Diet == 2, ]
chickDiet3 <- ChickWeight[ChickWeight$Diet == 3, ]
chickDiet4 <- ChickWeight[ChickWeight$Diet == 4, ]

chickDiet1
chickDiet2
chickDiet3
chickDiet4

par(mfrow = c(2,2)) 
boxplot(chickDiet1$weight ~ chickDiet1$Time, 
        main = "Chick Weight By Diet Type (1)",
        xlab = "Days",
        ylab = "Weight (gm)",
        ylim = c(0, 300))
boxplot(chickDiet2$weight ~ chickDiet2$Time, 
        main = "Chick Weight By Diet Type (2)",
        xlab = "Days",
        ylab = "Weight (gm)",
        ylim = c(0, 300))
boxplot(chickDiet3$weight ~ chickDiet3$Time, 
        main = "Chick Weight By Diet Type (3)",
        xlab = "Days",
        ylab = "Weight (gm)",
        ylim = c(0, 300))
boxplot(chickDiet4$weight ~ chickDiet4$Time, 
        main = "Chick Weight By Diet Type (4)",
        xlab = "Days",
        ylab = "Weight (gm)",
        ylim = c(0, 300))





#same thing as basic ggplot
qplot(Time, weight, data=ChickWeight, color=factor(Diet), facets = Diet ~ .,
      geom=c("point", "smooth"), 
      main="Protein Diet Versus Chick Weight ", xlab = "Time (days)", ylab = "Chick Weight (gm)" )



ggplot(ChickWeight, aes(x=Diet, y=weight)) + 
  geom_boxplot()


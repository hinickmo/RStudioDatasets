library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)
library(ggcorrplot)

?datasets
library(help = "datasets")
?InsectSprays

#The counts of insects in agricultural experimental units treated with different insecticides.

InsectSprays
head(InsectSprays)

#If I want to view raw csv
write.csv(InsectSprays,"C:/Users/Siggi/Downloads/InsectSprays.csv", row.names = FALSE)

class(InsectSprays) #data frame




#Either method for boxplot 1.)
ggplot(InsectSprays, aes(x=spray, y=count))
  +geom_boxplot()

#2.)
boxplot(count ~ spray, data = InsectSprays,
        xlab = "Type of spray", ylab = "Insect count",
        main = "InsectSprays data", varwidth = TRUE, col = "lightgray")

  
ANOVAsprays <- aov(count ~ spray, data = InsectSprays)

summary(ANOVAsprays) #Reject null hypothesis. P-value less than 0.05. There is a sig difference.
anova(ANOVAsprays) #same thing as using summary


pairwise.t.test(x=InsectSprays$count, g=InsectSprays$spray, p.adj="bonf")
plot(ANOVAsprays)






#Using SQRT to satisfy ANOVA conditions and ensure results are more accurate
ggplot(InsectSprays, aes(x = spray, y = sqrt(count))) + 
  geom_boxplot()

boxplot(sqrt(count) ~ spray, data = InsectSprays,
        xlab = "Type of spray", ylab = "Insect count",
        main = "InsectSprays data", varwidth = TRUE, col = "lightgray")


ANOVAspraysSQRT <- aov(sqrt(count) ~ spray, data = InsectSprays)
summary(ANOVAspraysSQRT)
anova(ANOVAspraysSQRT)


plot(ANOVAspraysSQRT)


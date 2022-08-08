library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)
library(ggcorrplot)

?datasets
library(help = "datasets")
?mtcars

#The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel 
#consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).

mtcars
head(mtcars)

#Only would do this if I want to export file to csv so I can manipulate it to work more easily with corrplot / renaming
getwd()
write.csv(mtcars,"C:/Users/Siggi/Downloads/mtcars.csv", row.names = FALSE)

#renaming columns 
mtcarsnew <- rename(mtcars, "# Gears" = gear, "# Carburetors" = carb, Transmission = am, 
                    Engine = vs, "1/4 Mile Time" = qsec, Weight = wt, "Rear Axle Ratio" = drat, 
                    Horsepower = hp, Displacement = disp, "# Cylinders" = cyl, MPG = mpg)

mtcarsnew

class(mtcarsnew) #data frame
mtcarsCOR = cor(mtcarsnew)
mtcarsCOR


ggcorrplot(mtcarsCOR, hc.order = TRUE, outline.col = "white")

corrplot(mtcarsCOR, is.corr = TRUE, method = "square", diag = FALSE, order = 'AOE', addCoef.col = "gray")


testmtcarsCOR = cor.mtest(mtcarsCOR, conf.level = 0.95)
testmtcarsCOR

corrplot(mtcarsCOR, is.corr = TRUE, method = "square", diag = FALSE, order = 'AOE', addCoef.col = "gray", p.mat = testmtcarsCOR$p, sig.level = 0.05)

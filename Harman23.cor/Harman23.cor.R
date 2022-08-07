library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)

?datasets
library(help = "datasets")
?Harman23.cor

#A correlation matrix of eight physical measurements on 305 girls between ages seven and seventeen.

Harman23.cor
head(Harman23.cor)

class(Harman23.cor) #list

Harman23DF <- as.data.frame(Harman23.cor,  col.names = c("", "", ""))#dataframe now
Harman23DF #dataframe now so ggcorrplot will work
class(Harman23DF)

#anything correlated to itself will be 1 so ignore middle diagonal and anything paired to itself
ggcorrplot(Harman23DF, hc.order = TRUE, outline.col = "white")







install.packages("corrplot")
library(corrplot)

#removing unnecessary columns
Harman23DF$c.0..0..0..0..0..0..0..0. <- NULL
Harman23DF$X305 <- NULL
Harman23DF

corrplot(as.matrix(Harman23DF), is.corr = TRUE, method = "square")

corrplot(as.matrix(Harman23DF), is.corr = TRUE, method = "square", diag = FALSE)





testHarman23DF = cor.mtest(Harman23DF, conf.level = 0.95)
testHarman23DF
#could not get this to work perfectly
corrplot(as.matrix(Harman23DF), is.corr = TRUE, method = "square", diag = FALSE, p.mat = testHarman23DF$p, sig.level = 0.05)
 

#main problem was reformatting original dataset to work with the corrplot function


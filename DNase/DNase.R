library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)

?datasets
library(help = "datasets")
?DNase

#The DNase data frame has 176 rows and 3 columns of data obtained during development of 
#an ELISA assay for the recombinant protein DNase in rat serum.

DNase
head(DNase)

class(DNase) #data frame

#Looking at distribution of data 
par(mfrow = c(1,1))
hist(DNase$density, breaks=10, main = "")

boxplot(density ~ Run, data = DNase)



#Plotting outliers
par(mfrow = c(1,1))
boxplot(DNase$density~DNase$conc,xlab="Concentration of Protein (ng/ml)",ylab="Optical Density")

#Finding outliers
boxplot.stats(DNase$density[DNase$conc==12.5])$out
boxplot.stats(DNase$density[DNase$conc==6.25])$out

#Removing outliers
df_no_outliers <- subset(x=DNase, !density %in% boxplot.stats(DNase$density[DNase$conc==12.5])$out & !density %in% boxplot.stats(DNase$density[DNase$conc==6.25])$out ) 

#Final Graph
ggplot(df_no_outliers, aes(x=conc, y=density)) + 
  geom_smooth()+
  geom_point()+
  expand_limits(y=0, x=0)+
  labs(title="Recombinant Protein DNase ELISA Assay Density Versus Concentration", x = "Concentration of Protein (ng/ml)", y = "Optical Density",  
       caption="The DNase data frame has 176 rows and 3 columns of data obtained during development of an ELISA assay for the recombinant protein DNase in rat serum.")


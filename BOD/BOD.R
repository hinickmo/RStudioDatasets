library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)

?datasets
library(help = "datasets")
?BOD

BOD
head(BOD)

class(BOD) #data frame

#same thing as basic ggplot
qplot(Time, demand, data=BOD)

ggplot(BOD, aes(Time, demand))+
  geom_point()

ggplot(BOD, aes(Time, demand))+
  geom_line()+
  expand_limits(y=0, x=0)+
  labs(title="Biochemical Oxygen Demand Versus Time", x = "Time (days)", y = "Biochemical Oxygen Demand (mg/l)",  
       caption="Bates, D.M. and Watts, D.G. (1988), Nonlinear Regression Analysis and Its Applications, Wiley, Appendix A1.4.")+
  theme(plot.title = element_text(color = "SteelBlue"))



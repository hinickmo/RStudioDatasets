library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)

?datasets
library(help = "datasets")
?CO2

CO2
head(CO2)

class(CO2) #data frame

#same thing as basic ggplot
qplot(uptake, conc, data=CO2, fill=Type)




ggplot(CO2, aes(x=Treatment, y=uptake)) + 
  geom_boxplot()



t.test(CO2$uptake ~ CO2$Treatment)

ggplot(CO2, aes(x=Type, y=uptake)) + 
  geom_boxplot()

t.test(CO2$uptake ~ CO2$Type)



par(mfrow = c(1,2))
boxplot(CO2$uptake ~ CO2$Treatment)
boxplot(CO2$uptake ~ CO2$Type)



par(mfrow = c(1,1))
boxplot(CO2$uptake ~ CO2$Type + CO2$Treatment)


par(mfrow = c(1,1))
boxplot(subset(CO2$uptake, CO2$conc == 95), 
        subset(CO2$uptake, CO2$conc == 175),
        subset(CO2$uptake, CO2$conc == 250),
        subset(CO2$uptake, CO2$conc == 350),
        subset(CO2$uptake, CO2$conc == 500),
        subset(CO2$uptake, CO2$conc == 675),
        subset(CO2$uptake, CO2$conc == 1000), 
        names = c("95", "175", "250", "350", "500", "675", "1000"))



par(mfrow = c(2,2))
plot(uptake ~ conc, data = subset(CO2, 
                                  Type == "Quebec" & Treatment == "chilled"), 
     main="Chilled Quebec")
plot(uptake ~ conc, data = subset(CO2,
                                  Type == "Mississippi" & Treatment == "chilled"), 
     main="Chilled Mississippi")
plot(uptake ~ conc, data = subset(CO2, 
                                  Type == "Quebec" & Treatment == "nonchilled"),
     main="Nonchilled Quebec")
plot(uptake ~ conc, data = subset(CO2, 
                                  Type == "Mississippi" & Treatment == "nonchilled"), 
     main="Nonchilled Mississippi")




ggplot(CO2, aes(conc, uptake, color=Treatment, shape=Type)) + 
  geom_point()+
  expand_limits(y=0, x=0)+
  labs(title="CO2 Uptake of Plants from Mississippi and Quebec", x = "Concentration (ML/L)", y = "Carbon Dioxide Uptake (μmol/m2s)",  
       caption="The CO2 data frame has 84 rows and 5 columns of data from an experiment on the cold tolerance of the grass species Echinochloa crus-galli.")

ggplot(CO2, aes(conc, uptake, color=Plant, type=Treatment)) + 
  geom_line()+
  geom_point()+
  expand_limits(y=0, x=0)+
  labs(title="CO2 Uptake of Plants from Mississippi and Quebec", x = "Concentration (ML/L)", y = "Carbon Dioxide Uptake (μmol/m2s)",  
       caption="The CO2 data frame has 84 rows and 5 columns of data from an experiment on the cold tolerance of the grass species Echinochloa crus-galli.")
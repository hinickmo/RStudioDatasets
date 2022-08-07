library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)

?datasets
library(help = "datasets")
?HairEyeColor

#Distribution of hair and eye color and sex in 592 statistics students.

HairEyeColor
head(HairEyeColor)

class(HairEyeColor) #table
  
ggplot(HairEyeColor, aes(Eye, Freq, fill=Sex))+
    geom_boxplot()

ggplot(HairEyeColor, aes(Hair, Freq, fill=Sex))+
  geom_boxplot()

ggplot(HairEyeColor, aes(Hair, fill=Hair))+
  scale_fill_manual(values=c("#1C1504", "#5E4303", "#F07743", "#FFFBF1"))+
  geom_density(alpha=0.7)

ggplot(HairEyeColor, aes(Eye, fill=Eye,))+
  scale_fill_manual(values=c("#3B1002", "cyan3", "#93820B", "chartreuse4"))+
  geom_density(alpha=0.7)








install.packages("vcd")
library(vcd)
mosaic(HairEyeColor, shade = TRUE)
  







HairEyeColorchi <- HairEyeColor[,,"Male"] + HairEyeColor[,,"Female"]
HairEyeColorchi
#p-value < 2.2e-16 significant
chisq.test(HairEyeColorchi)

HairEyeColorchi/sum


barplot(HairEyeColorchi, beside=TRUE, legend.text=TRUE, xlab="Eye Color", ylab="Frequency", main="Eye Color vs. Hair Color", 
        col=c("#1C1504", "#5E4303", "#F07743", "#FFFBF1")) 






HairEyeColor

#2 means columns, 1 means rows
MH <- apply(HairEyeColor[,,"Male"],1,sum)
MH
FH <- apply(HairEyeColor[,,"Female"],1,sum)
FH

HairEyeColorchi2 <- cbind(MH,FH)
HairEyeColorchi2
#p-value = 0.04613 somehwta significant 
chisq.test(HairEyeColorchi2)
  
barplot(HairEyeColorchi2, beside=TRUE, legend.text=TRUE, xlab="Gender", ylab="Frequency", main="Gender vs. Hair Color", 
        names.arg=c("Male","Female"), col=c("#1C1504", "#5E4303", "#F07743", "#FFFBF1"))









HairEyeColor

#2 means columns, 1 means rows
ME <- apply(HairEyeColor[,,"Male"],2,sum)
FE <- apply(HairEyeColor[,,"Female"],2,sum)
HairEyeColorchi3 <- cbind(ME,FE)

HairEyeColorchi3
#p-value = 0.6754 not significant 
chisq.test(HairEyeColorchi3)

barplot(HairEyeColorchi3, beside=TRUE, legend.text=TRUE, xlab="Gender", ylab="Frequency", main="Gender vs. Eye Color",
        names.arg=c("Male","Female"), col=c("#3B1002", "cyan3", "#93820B", "chartreuse4"))


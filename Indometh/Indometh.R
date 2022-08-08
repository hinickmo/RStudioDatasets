library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)
library(ggcorrplot)

?datasets
library(help = "datasets")
?Indometh

#The Indometh data frame has 66 rows and 3 columns of 
#data on the pharmacokinetics of indometacin (or, older spelling, ‘indomethacin’).

Indometh
head(Indometh)

#If I want to view raw csv
write.csv(Indometh,"C:/Users/Siggi/Downloads/Indometh.csv", row.names = FALSE)

class(Indometh) #grouped data AND data frame

boxplot(time ~ Subject, data = Indometh)
boxplot(conc ~ Subject, data = Indometh)

ggplot(Indometh, aes(x=time, y=conc, color=Subject)) + 
  geom_smooth()+
  geom_point()+
  labs(title="Indometacin Plasma Concentration vs. Time", x = "Time (hr)", y = "Plasma Concentrations of Indometacin (mcg/ml)",  
       caption="The Indometh data frame has 66 rows and 3 columns of data on the pharmacokinetics of indometacin")



install.packages("plotly")
library(plotly)

ggplot(Indometh, aes(x=time, y=conc, color=Subject)) + 
  geom_smooth()+
  geom_point()+
  labs(title="Indometacin Plasma Concentration vs. Time", x = "Time (hr)", y = "Plasma Concentrations of Indometacin (mcg/ml)",  
       caption="The Indometh data frame has 66 rows and 3 columns of data on the pharmacokinetics of indometacin")


plot_ly(data = Indometh, x=~time, y=~conc, type = 'scatter', mode = 'lines', color=~Subject) %>% 
  arrange(Subject) %>% 
  layout(title="Indometacin Plasma Concentration vs. Time", 
         xaxis = list(title = "Time (hr)"), 
         yaxis = list(title = "Plasma Concentrations of Indometacin (mcg/ml)"),
         legend=list(title=list(text='<b> Subject </b>')),
         annotations = list(x = 1.0, y = -0.1, showarrow = F, xref='paper', yref='paper', 
         xanchor='right', yanchor='auto', xshift=0, yshift=0, text = "The Indometh data frame has 66 rows and 3 columns of data on the pharmacokinetics of indometacin"))

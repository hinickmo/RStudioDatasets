library(ggplot2) #qplot (basic scatterplot) 
library(ggthemes)
library(tidyverse)
library(datasets)
library(ggfortify)
library(rmarkdown)
library(broom)
library(dplyr)

?datasets
library(help = "datasets")
?EuStockMarkets

#Contains the daily closing prices of major European stock indices: Germany DAX (Ibis), 
#Switzerland SMI, France CAC, and UK FTSE. The data are sampled in business time, i.e., weekends and holidays are omitted.

EuStockMarkets
head(EuStockMarkets)

class(EuStockMarkets) #timeseries
EuStockDF<-as.data.frame(EuStockMarkets) 
EuStockDF$Date <- as.numeric(time(EuStockMarkets)) 

#now the dates have an official column
head(EuStockDF) 


ggplot(EuStockDF,aes(x = Date))+
  expand_limits(y=c(2000, 9000))+
  labs(title="European Stock Indices 1991 to 1998", x = "Year", y = "Stock Price",  
       caption="Contains the daily closing prices of major European stock indices: Germany DAX (Ibis), Switzerland SMI, France CAC, 
                and UK FTSE. The data are sampled in business time, i.e., weekends and holidays are omitted.")+
  geom_line(aes(y = DAX), color="darkslateblue")+
  geom_line(aes(y = SMI), color="darkorchid")+
  geom_line(aes(y = CAC), color="mediumseagreen")+
  geom_line(aes(y = FTSE), color="indianred3")+  
  theme(legend.position = "bottom")

tidyEuStockMarkets <- tidy(EuStockMarkets)
tidyEuStockMarkets <- tidyEuStockMarkets %>%
  rename(Date=index,Stock_Index=series,Price=value)

tidyEuStockMarkets

ggplot(tidyEuStockMarkets,aes(x=Date,y=Price))+
  geom_line(aes(color=Stock_Index))+
  expand_limits(y=c(2000, 10000))+
  labs(title="European Stock Indices 1991 to 1998", x = "Year", y = "Stock Price",  
       caption="Contains the daily closing prices of major European stock indices: Germany DAX (Ibis), Switzerland SMI, France CAC, 
                and UK FTSE. The data are sampled in business time, i.e., weekends and holidays are omitted.")

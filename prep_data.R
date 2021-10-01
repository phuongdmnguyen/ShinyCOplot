library(dplyr)
library(ggplot2)

## data downloaded from ftp://ftp.env.gov.bc.ca/pub/outgoing/AIR/Hourly_Raw_Air_Data/Air_Quality/

COdata <- read.csv("data/CO.csv")
COdata <- subset(COdata, select = c(DATE_PST, STATION_NAME, REPORTED_VALUE, UNITS))
COdata <- na.omit(COdata)

## finding out names of stations where [CO] is collected from
stations <- unique(COdata$STATION_NAME)
length(stations) # 21

## Reformating day_time to Date type to compare later on to select range for plot
COdata = COdata %>% mutate(DATE_PST = as.POSIXct(DATE_PST, format = "%Y-%m-%d %H:%M", tz = "US/Pacific"))
plot = ggplot(COdata %>% filter(STATION_NAME == "Burnaby South")) +
  theme(panel.background = element_rect(fill = "white", color = "black")) +
  geom_line(aes(x = DATE_PST, y = REPORTED_VALUE), color = "blue", size = 0.5) +
  labs(x = "Date",
       y = "CO Concentration (ppm)")
ggplotly(plot)
save(COdata, file = "COdata.RData")

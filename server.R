library(shiny)
library(dplyr)

## data downloaded from ftp://ftp.env.gov.bc.ca/pub/outgoing/AIR/Hourly_Raw_Air_Data/Air_Quality/
COdata <- read.csv("data/CO.csv")
COdata <- subset(COdata, select = c(DATE_PST, STATION_NAME, REPORTED_VALUE, UNITS))
COdata <- na.omit(COdata)

## finding out names of stations where [CO] is collected from
stations <- unique(COdata$STATION_NAME)
length(stations) # 21

## Reformating day_time to Date type to compare later on to select range for plot
day_time <- unique(COdata$DATE_PST)
date <- strsplit(day_time, " ")
date <- sapply(date, '[', 1)
as.Date(date, format = "%Y-%m-%d")
length(day_time) #733



#COdata_Abbo <- filter(COdata, STATION_NAME == stations[1])

# Define server logic required to plot various variables 
shinyServer(function(input, output) {
  
  
  # want "REPORTED_VALUE ~ DATE_PST"
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$COplot <- renderPlot({
    station_name <- input$station
    min_date <- input$date[1]
    max_date <- input$date[2]
    
    ## filtering plot according to chosen station and date range
    filtered_data <- filter(COdata, STATION_NAME == station_name, DATE_PST <= max_date, DATE_PST >= min_date)
    plot(strptime(filtered_data$DATE_PST, "%Y-%m-%d %H:%M"), filtered_data$REPORTED_VALUE, type = "l", col = "blue", 
         xlab = "Date",
         ylab = "CO concentration (ppm)",
         main = paste("CO concentration in ", station_name))
  })
  
})

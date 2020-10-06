library(shiny)
library(dplyr)

## data downloaded from ftp://ftp.env.gov.bc.ca/pub/outgoing/AIR/Hourly_Raw_Air_Data/Air_Quality/
COdata <- read.csv("data/CO.csv")
COdata <- subset(COdata, select = c(DATE_PST, STATION_NAME, REPORTED_VALUE, UNITS))
COdata <- na.omit(COdata)

## finding out names of stations where [CO] is collected from
stations <- unique(COdata$STATION_NAME)
length(stations) # 21
day_time <- unique(COdata$DATE_PST)
length(day_time) #733



#COdata_Abbo <- filter(COdata, STATION_NAME == stations[1])

# Define server logic required to plot various variables 
shinyServer(function(input, output) {
  
  
  # want "REPORTED_VALUE ~ DATE_PST"
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$COplot <- renderPlot({
    station_name <- input$station
    filtered_data <- filter(COdata, STATION_NAME == station_name)
    plot(strptime(filtered_data$DATE_PST, "%Y-%m-%d %H:%M"), filtered_data$REPORTED_VALUE, type = "l", col = "blue", 
         xlab = "Date",
         ylab = "CO concentration (ppm)",
         main = paste("CO concentration in ", station_name))
  })
  
})

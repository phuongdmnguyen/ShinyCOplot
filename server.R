library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
## data downloaded from ftp://ftp.env.gov.bc.ca/pub/outgoing/AIR/Hourly_Raw_Air_Data/Air_Quality/
load("COdata.RData")


# Define server logic required to plot various variables 
shinyServer(function(input, output) {
  
  
  # want "REPORTED_VALUE ~ DATE_PST"
  # Generate a plot of the requested variable against mpg and only 
  output$COplot <- renderPlotly({
    station_name <- input$station
    min_date <- input$date[1]
    max_date <- input$date[2]
    
    ## filtering plot according to chosen station and date range
    filtered_data <- filter(COdata, STATION_NAME == station_name, DATE_PST <= max_date, DATE_PST >= min_date)

    plot = ggplot(filtered_data, aes(x = DATE_PST, y = REPORTED_VALUE)) +
      theme(panel.background = element_rect(fill = "white", color = "black")) +
      geom_line(color = "blue", size = 0.5) +
      labs(x = "Date",
           y = "CO Concentration (ppm)")
    
    ggplotly(plot)
  })
})

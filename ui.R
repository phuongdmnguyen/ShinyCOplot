library(shiny)
library(shinyWidgets)
library(plotly)

## finding out names of stations where [CO] is collected from
load("COdata.RData")

## finding out names of stations where [CO] is collected from
stations <- unique(COdata$STATION_NAME)
# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Plotting the CO concentration across stations in Metro Vancouver Sept-Oct 2020"),

  sidebarPanel(
    selectInput("station", "Station:",
                choices = stations),
    sliderInput("date", "Date range", 
                min = as.POSIXct("2020-09-06"),
                max = as.POSIXct("2020-10-06"),
                value = c(as.POSIXct("2020-09-06"),as.POSIXct("2020-10-06")))),
  
  mainPanel(plotlyOutput("COplot"))
))


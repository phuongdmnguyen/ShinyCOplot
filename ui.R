library(shiny)
library(shinyWidgets)

## finding out names of stations where [CO] is collected from
COdata <- read.csv("data/CO.csv")
COdata <- subset(COdata, select = c(DATE_PST, STATION_NAME, REPORTED_VALUE, UNITS))
COdata <- na.omit(COdata)

## finding out names of stations where [CO] is collected from
stations <- unique(COdata$STATION_NAME)
# Define UI for CO concentration
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Plotting the CO concentration across stations in Metro Vancouver Sept-Oct 2020"),

  
  # Sidebar with controls to select stations
  # Date slider to select date range to plot
  sidebarPanel(
    selectInput("station", "Station:",
                choices = stations),
    sliderInput("date", "Date range", 
                min = as.Date("2020-09-06"),
                max = as.Date("2020-10-06 12:00"),
                value = c(as.Date("2020-09-06 00:00"),as.Date("2020-10-06 12:00")))),
  
  mainPanel(plotOutput("COplot"))
))

library(shiny)


## finding out names of stations where [CO] is collected from
COdata <- read.csv("data/CO.csv")
COdata <- subset(COdata, select = c(DATE_PST, STATION_NAME, REPORTED_VALUE, UNITS))
COdata <- na.omit(COdata)

## finding out names of stations where [CO] is collected from
stations <- unique(COdata$STATION_NAME)
# Define UI 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Plotting the CO concentration across stations in Metro Vancouver Sept-Oct 2020"),
  
  # Sidebar with controls to select the stations available
  sidebarPanel(
    selectInput("station", "Station:",
                choices = stations)
  ),
  
  mainPanel(plotOutput("COplot"))
))


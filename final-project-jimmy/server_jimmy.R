## this script will write the server side of the time plots

# loading in the relavant packages  
library(shiny)
library(tidyverse)

#confirming we are the right directory
getwd()

#loads the air quality data in that we will need
data <- read.csv('data/air_quality.csv')

# this script will define my server

server <- function(input, output) {
  
  # generates the plot element of our output
  
  output$timePlot <- renderPlot({
    
    # generates data based on user selections
    # filters list based on selected air quality metric and state
    
    plot_data <- data %>% 
      filter(StateName == input$State) %>% 
      filter(MeasureName == input$Metric) %>% 
      select(MeasureName,StateName,ReportYear,CountyName,Value)
    
    # creates the plot based on the filtered data set
    p <- ggplot(data = plot_data) +
      geom_line(mapping = aes(x = ReportYear, y = Value, color = CountyName)) +
      labs(
        x = "Year",
        color = "County Name") + 
      ylim(min(plot_data$Value),max(plot_data$Value))
    

    return(p)
    
  })

}

shinyServer(server)

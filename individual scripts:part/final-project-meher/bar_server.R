#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

airQual <- read.csv("../data/air_quality.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({
        
        x <- airQual %>%
            select(MeasureName, MeasureId, StateName, ReportYear, Value, CountyName)%>%
            filter(MeasureId == '85' | MeasureId == '87' | MeasureId == '84')%>%
            group_by(MeasureId)%>%
            group_by(StateName, .add = TRUE)%>%
            group_by(ReportYear, .add = TRUE)%>%
            filter(Value == max(Value)) %>%
            filter(ReportYear == input$year) %>%
            filter(MeasureId == input$Metric)
        
        # generate bins based on input$bins from ui.R
        states    <- x$StateName
        airQ <- x$Value

        # draw the histogram with the specified number of bins
       ggplot(data= x, aes(x= states, y=airQ, fill= states)) +
           geom_bar(stat="identity") +
           xlab("States") + ylab("Air Quality") +
           theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())+
           ggtitle("Air Quality during different Time Periods")

    })

})

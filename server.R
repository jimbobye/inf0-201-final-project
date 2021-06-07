## this script will write the server side of the time plots

# loading in the relavant packages  
library(shiny)
library(tidyverse)
library(shinythemes)
library(maps)

#confirming we are the right directory
getwd()

#loads the air quality data in that we will need
data <- read.csv('data/air_quality.csv')

#this filters through the data needed to create the map

PM2.5data = data %>%
  filter(Unit == "µg/m³")

# join our dataa with some longitude and latitude data to create our map

county_shapes <- map_data("county") %>%
  # load county boundary data (package "maps")
  unite(polyname, region, subregion, sep = ",") %>%
  # put the polygon name in the same form as in county.fips
  left_join(county.fips, by = "polyname")

PM2.5data_shapes = left_join(county_shapes, PM2.5data, by = c("fips"="CountyFips")) %>%
  filter(!is.na(lat) & !is.na(long))


green = colorRampPalette(c("#1B4D3E", "#228B22","#8DB600"))(200)                   
red = colorRampPalette(c("mistyrose", "red2","darkred"))(200)



# this script will define my server

server <- function(input,output) {
  
  #outputs our plot for the first panel
  
  output$first_plot <- renderPlot({
    
    plot_data <- data %>% 
      filter(StateName == input$State) %>% 
      filter(MeasureName == input$Metric) %>% 
      select(MeasureName,StateName,ReportYear,CountyName,Value)
    
    # creates the plot based on the filtered data set
    plot1 <- ggplot(data = plot_data) +
      geom_line( mapping = aes(x = ReportYear, y = Value, color = CountyName)) +
      labs(
        x = "Year",
        y = input$Metric,
        title = paste(input$Metric,"Changes Over Time"),
        color = "County Name")
    
    return(plot1)
  })
  
  #output the message describing what the first plot is and the purpose of it 
  
  output$first_message <- renderText({
    
    m1 <- paste("The plot above plots an air quality metric over time, allow the user to see how air quality changes over time 
                for all of the counties in the data set a chosen state. The two most common air quality metrics are PM2.5 levels 
                as well as ozone levels, which are the two metrics we have chosen to include.")
  
    return(m1)
    
    })
  
  #outputs our plot for the second panel
  
  output$second_plot <- renderPlot({
    
    plot2_data <- data %>%
      select(MeasureName, MeasureId, StateName, ReportYear, Value, CountyName)%>%
      filter(MeasureName == 'Number of days with ozone concentration over National Standard' | MeasureName == 'Percent of days with PM2.5 levels over the National Standard')%>%
      group_by(MeasureName)%>%
      group_by(StateName, .add = TRUE)%>%
      group_by(ReportYear, .add = TRUE)%>%
      filter(Value == max(Value)) %>%
      filter(ReportYear == input$year) %>%
      filter(MeasureName == input$Metric2)
    
    # generate bins based on input$bins from ui.R
    states    <- plot2_data$StateName
    airQ <- plot2_data$Value
    
    # draw the histogram with the specified number of bins
    plot2 <- ggplot(data= plot2_data, aes(x= states, y=airQ, fill= states)) +
      geom_bar(stat="identity") +
      xlab("States") + ylab(input$Metric2) +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
      labs(
        title = paste("Air Quality Between States in",input$year)
      )
    
    return(plot2)
  })
  
  #output the message describing what the second plot is and the purpose of it 
  
  output$second_message <- renderText({
    
    m2 <- paste("In this graph, we are comparing the air quality between all the states. The air quality is 
                measured by two measuremeant types, PM2.5 levels and ozone concentration levels, which are 
                the two most common metrics used to quantify air quality. There is a widget on the left to selected 
                between these two metrics, as well as a widget to manipulate the particular year of data you would 
                like to compare. going from 1999 to 2013. After selecting the metric and year, the plot will compare 
                air quality between the states." )
    
    return(m2)
    
  })
  
  #outputs our plot for the third panel
  
  plot3_r <- reactive({
    ggplotMap(input$Year3,input$Location)
  })
  
  output$third_plot <- renderPlot({
    
      air_data <-  PM2.5data_shapes %>%
        filter(ReportYear == input$Year3)
      if(input$Location != "USA") {
        air_data = air_data %>%
          filter(StateName == input$Location)
      }
      return(
        ggplot(air_data, aes(x=long, y=lat, group=group)) +
          geom_polygon(colour = alpha("black", 1/2), size = 0.05, aes(fill=Value)) +
          scale_fill_gradientn(colors = c(green,"white",red)) +
          coord_quickmap() +
          theme_void() +
          labs(fill="Concentration of PM2.5 
            (µg/m³)", title=
                 paste0("Annual average ambient concentrations of PM 2.5 in ",
                        input$Location, ", ", input$Year3))
      )
    })
    
  #output the message describing what the third plot is and the purpose of it 
  
  output$third_message <- renderText({
    m3 <- paste("PM 2.5 is the concentration of particulate matter suspended in the air with a diameter of 2.5 μm or less. It's one
          of the key metrics in determining air quality. The higher level of 
          PM 2.5 the worse the quality of air. This map plots the CDC PM 2.5 measurements
          for years 1999-2013, with the states/coutnies shaded according to their PM2.5 concentrations,
          data for some years/states might be missing. This map allows the user to visualize how air qualtity
          differs between different geographical regionsin the U.S and within a given state.")
    
    return(m3)
    
          })
}

shinyServer(server)


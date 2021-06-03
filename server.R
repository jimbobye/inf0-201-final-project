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

PM2.5data = data %>%
  filter(Unit == "µg/m³")

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
  
  output$second_plot <- renderPlot({
    
    plot2_data <- data %>%
      select(MeasureName, MeasureId, StateName, ReportYear, Value, CountyName)%>%
      filter(MeasureId == '85' | MeasureId == '84')%>%
      group_by(MeasureId)%>%
      group_by(StateName, .add = TRUE)%>%
      group_by(ReportYear, .add = TRUE)%>%
      filter(Value == max(Value)) %>%
      filter(ReportYear == input$year) %>%
      filter(MeasureId == input$Metric2)
    
    # generate bins based on input$bins from ui.R
    states    <- plot2_data$StateName
    airQ <- plot2_data$Value
    
    # draw the histogram with the specified number of bins
    plot2 <- ggplot(data= plot2_data, aes(x= states, y=airQ, fill= states)) +
      geom_bar(stat="identity") +
      xlab("States") + ylab("Air Quality") +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
      labs(
        title = paste("Air Quality Between States in",input$year)
      )
    
    return(plot2)
  })
  
  output$second_message <- renderText({
    
    m2 <- paste("In this data, we are comparing the air quality between all the states. The air quality is measured by three measuremeant types. These 
                types being: (1) The percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS), (2) The number of days with a maximum 8-hour
                average ozone concentration over the National Ambient Air Quality Standard, and (3) The annual average ambient concentrations of PM2.5 in micrograms per cubic meter.
                There is widget on the left side to select through these measurments. Along with that, the data can be manipulated to be seen through out the years. It starts
                in the year 1999 and ends in 2013, there is an widget to see the different measurments through these years.")
    
    return(m2)
    
  })
  
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
                        input$Location, ", ", input$Year3, " (monitor and modeled data)"))
      )
    })
    
  
  output$third_message <- renderText({
    m3 <- paste("PM 2.5 is the concentration of particulate matter suspended in the air with a diameter of 2.5 μm or less. It's one
          of the key metrics in determining air quality. The higher level of 
          PM 2.5 the worse the quality of air. This map uses CDC PM 2.5 measurements
          and projections for years 1999-2013, data for some years/states might be missing")
    
    return(m3)
    
          })
}

shinyServer(server)


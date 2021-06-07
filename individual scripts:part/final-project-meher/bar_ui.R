

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Air Quality change through Years"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
        selectInput("year", "Select Year", 
                    choices = list("1999" = "1999", "2000" = "2000", "2001" = "2001", "2002" = "2002", "2003" = "2003", "2004" = "2004", "2005" = "2005",
                                   "2006" = "2006", "2007" = "2007", "2008" = "2008", "2009" = "2009", "2010" = "2010", "2011" = "2011",
                                   "2012" = "2012", "2013" = "2013"), 
                    selected = "1999", multiple = FALSE),
 
        selectInput("Metric", "Air Quality Metric", 
             choices = list("Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)" = "85",
                           "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard" = "84",
                           "Annual average ambient concentrations of PM2.5 in micrograms per cubic meter (based on seasonal averages and daily measurement)" = "87"),
                            selected = "87")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            p("In this data, we are comparing the air quality between all the states. The air quality is measured by three measuremeant types. These 
              types being: (1) The percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS), (2) The number of days with a maximum 8-hour
              average ozone concentration over the National Ambient Air Quality Standard, and (3) The annual average ambient concentrations of PM2.5 in micrograms per cubic meter.
              There is widget on the left side to select through these measurments. Along with that, the data can be manipulated to be seen through out the years. It starts
              in the year 1999 and ends in 2013, there is an widget to see the different measurments through these years.")
        )
    )
))


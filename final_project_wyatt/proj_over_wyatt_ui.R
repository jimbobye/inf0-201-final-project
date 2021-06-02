
library(shiny)

shinyUI(fluidPage(
    tags$head(
        tags$style(
            ".title {margin: auto; width: 300px}"
        )
    ),
    tags$div(class="title", titlePanel("Project Overview")),

        mainPanel(
            titlePanel("About Our Project"),
                paste("Our project covers a CDC data set that provides air quality
                     measurements over time and across the United States.  With 
                     the use of this data, our project will include maps, graphs,
                     and bar plots that will change depending on different user 
                     inputs including, states, counties, PM measurements, and year.
                     One of our graphs is a line plot that shows the change in 
                     county air quality over time with the ability to change the 
                     input of states and air quality metrics.  This will give the
                     user the ability to see different measurements in varying
                     states and counties over time.  Another one of our graphs 
                     will be a map that shows the concentration of poor air quality 
                     in different states and counties. This will give the user a
                     very good visual to compare different parts of the U.S. to
                     others.  Our last graph is a bar plot that shows air quality
                     metrics by state.  By inputing a state and air quality metic,
                     there will by an output of state by air quality, by year. 
                     "),
            
            titlePanel("Why We Wanted To Work With This Data"),
                paste("Our goal in working with this data is to display the ways
                      in which air quality has changed from the years 1999 to 2013
                      in the United States.  With the expectation that air quality and
                      other environmental features decrease in standard, it is
                      important to track these data points to better understand 
                      our downfalls so that we will be able to efficiently combat
                      environmental problems.  If it has gotten better over time 
                      it is also important to understand how we improved the air 
                      quality and how we can continue in that path toward cleaner
                      air.  Through working with this data, our group wants to find 
                      states with the worst air quality vs. the best air quality,
                      with this knowledge we get a better understanding of how we
                      can improve air quality as a country and translate that into
                      impacting our environment less and less over time."),
            
            titlePanel("CDC Data"),
          
            
                paste("The data we used comes from data.gov and is covers air
                      quality measurements run by the CDC.  This data set is 
                      called the “Air Quality Measures on the National Environmental
                      Health Tracking Network” and provides data about the ozone
                      and PM (particulate matter) levels in the United States.
                      This data set covers air quality statistics from 1999 to 
                      2013 through 4000 county measuring facilities.  This gives
                      us a very thorough overview of U.S. air quality throughout
                      the years and shows a decent summery of cities with bad air 
                      quality vs. good air quality."),
            titlePanel(""),
            tags$img(src = "CDClogo.png"),
            
                tags$h1("Sources"),
                tags$a(href="https://catalog.data.gov/dataset/air-quality-measures-on-the-national-environmental-health-tracking-network ", 
                       "If you would like to take a look at our DATA, click here!"),
            titlePanel(""),
                tags$a(href="https://github.com/jimbobye/info-201-final-project", 
                   "If you would like to take a look at our GITHUB, click here!"),
            
            
            
            titlePanel("")
        )
    )
)
        


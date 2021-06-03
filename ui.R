## this script plots the changes in air quality over time

# loading in the relavant packages  
library(shiny)
library(tidyverse)
library(htmltools)
library(shinythemes)
library(ggplot2)

#confirming we are the right directory
getwd()

#loads the air quality data in that we will need
data <- read.csv('data/air_quality.csv')

#this creates the overview panel of the app

overview_panel <-  tabPanel(title = "Project Overview",
                            mainPanel(
                              h1("Air Quality In The USA"),
                              img(src = "CDClogo.png",width = "400px", height = "200px"),
                              h2("About Our Project"),
                              paste("Our project covers a CDC data set that provides air quality measurements over time and across the United States. With the use of this data, our project will include maps, graphs, and bar plots that will change depending on different user inputs including, states, counties, PM measurements, and year. One of our graphs is a line plot that shows the change in county air quality over time with the ability to change the input of states and air quality metrics.  This will give the user the ability to see different measurements in varying states and counties over time.  Another one of our graphs will be a map that shows the concentration of poor air quality in different states and counties. This will give the user a very good visual to compare different parts of the U.S. to others.  Our last graph is a bar plot that shows air quality metrics by state.  By inputing a state and air quality metic, there will by an output of state by air quality, by year."),
                              br(),
                              h2("Why We Wanted To Work With This Data"),
                              paste("Our goal in working with this data is to display the ways in which air quality has changed from the years 1999 to 2013 in the United States.  With the expectation that air quality and other environmental features decrease in standard, it is important to track these data points to better understand our downfalls so that we will be able to efficiently combat environmental problems.  If it has gotten better over time it is also important to understand how we improved the air quality and how we can continue in that path toward cleaner air.  Through working with this data, our group wants to find states with the worst air quality vs. the best air quality, with this knowledge we get a better understanding of how we can improve air quality as a country and translate that into impacting our environment less and less over time."),
                              br(),
                              paste("The data we used comes from data.gov and is covers air quality measurements run by the CDC.  This data set is called the “Air Quality Measures on the National Environmental Health Tracking Network” and provides data about the ozone and PM (particulate matter) levels in the United States. This data set covers air quality statistics from 1999 to 2013 through 4000 county measuring facilities.  This gives us a very thorough overview of U.S. air quality throughout the years and shows a decent summery of cities with bad air quality vs. good air quality."),
                              br(),
                              h2("About The Data"),
                              paste("The data we used comes from data.gov and is covers air quality measurements run by the CDC.  This data set is called the “Air Quality Measures on the National Environmental Health Tracking Network” and provides data about the ozone and PM (particulate matter) levels in the United States. This data set covers air quality statistics from 1999 to 2013 through 4000 county measuring facilities.  This gives us a very thorough overview of U.S. air quality throughout the years and shows a decent summery of cities with bad air quality vs. good air quality."),
                              br(),
                              h2("Sources"),
                              a("If you would like to view where the data came from, click here!", 
                                href = "https://catalog.data.gov/dataset/air-quality-measures-on-the-national-environmental-health-tracking-network"),
                              br(),
                              a("If you would like to see the Github repo for this app, click here!", 
                                href = "https://github.com/jimbobye/info-201-final-project"),
                              br(),
                              br(),
                              br()
                            )
)

                           
#this part will create the first panel of the app

first_panel <- tabPanel(title = "Air Quality Over Time",
                        sidebarLayout(
                          sidebarPanel(
                            # widget to filter between three air quality metrics
                            selectInput("Metric", label = "Air Quality Metric", 
                                        choices = list("Percent of days with PM2.5 levels over the National Standard" = "Percent of days with PM2.5 levels over the National Standard",
                                                       "Number of days with ozone concentration over the National Standard" = "Number of days with ozone concentration over the National Standard"),
                                        selected = "Percent of days with PM2.5 levels over the National Standard"),
                            
                            # widget to filter between the states you want to see
                            
                            selectInput("State", label = "State", 
                                        choices = list("Alabama" = "Alabama","Alaska" = "Alaska","Arizona" = "Arizona","Arkansas" = "Arkansas","California" = "California",
                                                       "Colorado" = "Colorado","Connecticut" = "Connecticut","Delaware" = "Delaware","Florida" = "Florida","Georgia" = "Georgia",
                                                       "Hawaii" = "Hawaii","Idaho" = "Idaho","Illinois" = "Illinois","Indiana" = "Indiana","Iowa" = "Iowa",
                                                       "Kansas" = "Kansas","Kentucky" = "Kentucky","Louisiana" = "Louisiana","Maine" = "Maine","Maryland" = "Maryland",
                                                       "Massachusetts" = "Massachusetts","Michigan" = "Michigan","Minnesota" = "Minnesota","Mississippi" = "Mississippi","Missouri" = "Missouri",
                                                       "Montana" = "Montana","Nebraska" = "Nebraska","Nevada" = "Nevada","New Hampshire" = "New Hampshire","New Jersey" = "New Jersey",
                                                       "New Mexico" = "New Mexico","New York" = "New York","North Carolina" = "North Carolina","North Dakota" = "North Dakota","Ohio" = "Ohio",
                                                       "Oklahoma" = "Oklahoma","Oregon" = "Oregon","Pennsylvania" = "Pennsylvania","Rhode Island" = "Rhode Island","South Carolina" = "South Carolina",
                                                       "South Dakota" = "South Dakota","Tennessee" = "Tennessee","Texas" = "Texas","Utah" = "Utah","Vermont" = "Vermont",
                                                       "Virginia" = "Virginia","Washington" = "Washington","West Virginia" = "West Virginia","Wisconsin" = "Wisconsin","Wyoming" = "Wyoming"),
                                        selected = "Tennessee")
                          ),
                          
                          # Show a plot of the generated distribution
                          mainPanel(
                            plotOutput("first_plot")
                          )
                        )
)
                        
# this code creates our second panel

second_panel <- tabPanel(title = "Air Quality Comparison",
                         sidebarLayout(
                           sidebarPanel(
                             selectInput("year", "Select Year", 
                                         choices = list("1999" = "1999", "2000" = "2000", "2001" = "2001", "2002" = "2002", "2003" = "2003", "2004" = "2004", "2005" = "2005",
                                                        "2006" = "2006", "2007" = "2007", "2008" = "2008", "2009" = "2009", "2010" = "2010", "2011" = "2011",
                                                        "2012" = "2012", "2013" = "2013"), 
                                         selected = "1999", multiple = FALSE),
                             
                             selectInput("Metric2", "Air Quality Metric", 
                                         choices = list("Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)" = "85",
                                                        "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard" = "84"),
                                         selected = "84")
                             ),
                           
                           # Show a plot of the generated distribution
                           mainPanel(
                             plotOutput("second_plot"),
                             textOutput("second_message")
                           )
                         )
)
                      
#this creates the third panel

Choices =  list(
  "USA" = "USA",
  "Alabama" = "Alabama",
  "Arizona" = "Arizona",
  "Arkansas" = "Arkansas",
  "California" = "California",
  "Colorado" = "Colorado",
  "Connecticut" = "Connecticut",
  "Delaware" = "Delaware",
  "Florida" = "Florida",
  "Georgia" = "Georgia",
  "Idaho" = "Idaho",
  "Illinois" = "Illinois",
  "Indiana" = "Indiana",
  "Iowa" = "Iowa",
  "Kansas" = "Kansas",
  "Kentucky" = "Kentucky",
  "Louisiana" = "Louisiana",
  "Maine" = "Maine",
  "Maryland" = "Maryland",
  "Massachusetts" = "Massachusetts",
  "Michigan" = "Michigan",
  "Minnesota" = "Minnesota",
  "Mississippi" = "Mississippi",
  "Missouri" = "Missouri",
  "Montana" = "Montana",
  "Nebraska" = "Nebraska",
  "Nevada" = "Nevada",
  "New Hampshire" = "New Hampshire",
  "New Jersey" = "New Jersey",
  "New Mexico" = "New Mexico",
  "New York" = "New York",
  "North Carolina" = "North Carolina",
  "North Dakota" = "North Dakota",
  "Ohio" = "Ohio",
  "Oklahoma" = "Oklahoma",
  "Oregon" = "Oregon",
  "Pennsylvania" = "Pennsylvania",
  "Rhode Island" = "Rhode Island",
  "South Carolina" = "South Carolina",
  "South Dakota" = "South Dakota",
  "Tennessee" = "Tennessee",
  "Texas" = "Texas",
  "Utah" = "Utah",
  "Vermont" = "Vermont",
  "Virginia" = "Virginia",
  "Washington" = "Washington",
  "West Virginia" = "West Virginia",
  "Wisconsin" = "Wisconsin",
  "Wyoming" = "Wyoming"
)

third_panel <- tabPanel(title = "Air Quality Map",
                        titlePanel("Air Quality in USA by PM2.5 Concentration"),
                        sidebarLayout(
                          sidebarPanel(
                            sliderInput("Year3", label = h3("Year"), min = 1999,
                                        max = 2013, value = 2006),
                            selectInput("Location", label = h3("Location"),
                                        choices = Choices, selected = "Texas")
                          ),
                          mainPanel(
                            plotOutput("third_plot"),
                            textOutput("third_message")
                          )
                        )
)


#this creates the about us panel

about_panel <-  tabPanel(title = "About Us",
                            mainPanel(
                              h1("About Us"),
                              h4("App Contributors: Daniel Melikhov, Meher Singh Seera, Wyatt Richard Stanley and Jimmy Ye"),
                              paste("We are a group of students taking INFO 201 at the University of Washington.")
                            )
)
  
# this is the code for the summary panel

summary_panel <-  tabPanel(title = "Summary + Conclusion",
                            mainPanel(
                              h1("Summary + Conclusion"),
                              h2("What We Learned"),
                              paste("Looking at our air quality over time, we were surprised a general trend of air quality getting better as time went on. As with anything, there are exceptions to this, however when looking across many states, air quality got better when using either air quality metric. In most cases, the numbers of days either PM2.5 or ozone concentrations were above the National Standard went down. However, it is important to note that this can only be said up to 2013, as the dataset stops there."),
                              br(),
                              br(),
                              paste("Comparing our data across states, it seems as if California has the worst air quality when using any of the air quality metrics in the dataset. This was not surprising to us."),
                              br(),
                              br(),
                              paste("Finally, looking at our map of PM2.5 concentrations, we can see that geographically speaking, the northern part of the U.S seems to have the best air quality. Where we live, the Pacific Northwest, also has good quality when comapred to the rest of the U.S. The areas that seem to have the worst air quality are California and the states that are south of the midwest region of the U.S, which may reflect the types of industries and/or policies related to the enviornment and industrial practices, however a more definitive analysis and investigation would have to be done to confirm this"),
                              br(),
                              br(),
                              h2("Conclusion + Closing Thoughts"),
                              paste("In conclusion, while there are a few things we can say about what states and regions of the U.S has the best/worst air quality and the trends in air quality over time, there are a few things that must be kept in mind. Although this is a good source of data, there are a few problems that could effect the quality of data measurements.  According to the CDC, data is recorded every three days and only in the 4000 measuring facilities (mostly urban), with this data they predict measurements for the days they don’t record and assign neighboring counties a number without a real measurement. Although this is likely reasonable and accurate to a true measurement, it is still an approximated guess that could result in inaccurate measurements in some cases. Furthermore, the data in this particular dataset only goes up until 2013 and thus more recent data will need to be found elsewhere. We chose to mitigate some of these issues by carefully forming our analyses and conclusions around the data that was avaialble and not choosing to include any of the modeled data, only the measured data. Lastly, if someone were to look at this data and want to take it a step further and mitigate all of the mentioned issues, they shoudl start with finding data that is more recent, as well as finding data for counties that may not have been included in this dataset. While it may prove difficult to do, doing so would provide a much more relavant and comprehensive look at U.S air quality and woudl be able to draw much more concrete conclusions."),
                              br(),
                              br()
                            )
)

                       
#this code will organize our ui into a navbar format with panels

ui <- fluidPage(theme = shinytheme("flatly"),
  navbarPage(
    "Air Quality Analysis",
    overview_panel,
    first_panel,
    second_panel,
    third_panel,
    summary_panel,
    about_panel
  )
)

shinyUI(ui)


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
                              paste("Our project covers a CDC air quality dataset that provides air quality measurements 
                                    over time and across the United States. With the use of this data, our project will 
                                    include maps, graphs, and bar plots that will change depending on different user
                                    inputs including, states, ozone levels, PM measurements, and years. One of our graphs
                                    is a line plot that shows the change in county air quality over time with the
                                    ability to change the input of states and air quality metrics.  This will give 
                                    the user the ability to see different measurements in varying states and counties 
                                    over time and pick out any trends that may be present. Another one of our graphs will be a 
                                    map that shows the concentration of PM2.5 in different states and the USA as a whole. This will 
                                    give the user a very good visual to compare the air quality in different geographical regions. Our last 
                                    graph is a bar plot that shows air quality metrics by state and will allow the user to compare
                                    air quality by state.  By inputing a state and air quality metic, there will by an output of state 
                                    by air quality, by year."),
                              br(),
                              h2("Why This Data Is Important"),
                              paste("Our goal in working with this data is to display the ways in which air quality 
                                    has changed from the years 1999 to 2013 in the United States.  This data is important 
                                    as air quality is one of the forgotten and less known enviornmental issues that we as
                                    a society are currently dealing with. If it has gotten better over time it is also important
                                    to understand how we improved the air quality and how we can continue in that path toward better 
                                    air quality. If it has gotten worse, it would be good to know so that we can start to look for 
                                    areas where improvement can me made so that future generations can have better and cleaner air.
                                    Through working with this data, our group wants to find states with the worst air quality vs. the 
                                    best air quality, locate how air quality differs between different geographical regions of the U.S,
                                    how air quality has changed over time, and finally look to for a way to visualize how the air 
                                    quality might be in the reigon you live in. With this knowledge we get a better understanding of 
                                    how we can improve air quality as a country and translate that into impacting our environment
                                    less and less over time, with the hopes that it will lead to better air quality for future generations"),
                              br(),
                              h2("About The Data"),
                              paste("The data we used comes from data.gov and includes air quality measurements collected by the CDC.  
                                    This data set is called the “Air Quality Measures on the National Environmental Health Tracking 
                                    Network” and provides data about the ozone and PM (particulate matter) levels in the United States.
                                    This data set covers air quality statistics from 1999 to 2013 through 4000 county measuring facilities.  
                                    This gives us a very thorough overview of U.S. air quality throughout the years."),
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

                           
#this part will create the first panel of the app - the plots over time

first_panel <- tabPanel(title = "Air Quality Over Time",
                        titlePanel("Air Quality in USA Over Time"),
                        sidebarLayout(
                          sidebarPanel(
                            # widget to filter between three air quality metrics
                            selectInput("Metric", label = "Air Quality Metric", 
                                        choices = list("Percent of days with PM2.5 levels over the National Standard" = "Percent of days with PM2.5 levels over the National Standard",
                                                       "Number of days with ozone concentration over National Standard" = "Number of days with ozone concentration over National Standard"),
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
                          
                          # Show a plot of the generated data and a message describing what this plot is looking to show
                          mainPanel(
                            plotOutput("first_plot"),
                            textOutput('first_message')
                          )
                        )
)
                        
# this code creates our second panel

second_panel <- tabPanel(title = "Air Quality Comparison",
                         titlePanel("Air Quality Comparison"),
                         sidebarLayout(
                           sidebarPanel(
                             #widget to select the relavant air quality metric
                             selectInput("Metric2", "Air Quality Metric", 
                                         choices = list("Percent of days with PM2.5 levels over the National Standard" = "Percent of days with PM2.5 levels over the National Standard",
                                                        "Number of days with ozone concentration over National Standard" = "Number of days with ozone concentration over National Standard"),
                                         selected = "Number of days with ozone concentration over the National Standard"),
                             #widget to select the relavant year 
                             selectInput("year", "Year", 
                                         choices = list("1999" = "1999", "2000" = "2000", "2001" = "2001", "2002" = "2002", "2003" = "2003", "2004" = "2004", "2005" = "2005",
                                                        "2006" = "2006", "2007" = "2007", "2008" = "2008", "2009" = "2009", "2010" = "2010", "2011" = "2011",
                                                        "2012" = "2012", "2013" = "2013"), 
                                         selected = "1999", multiple = FALSE)
                             
                             
                             ),
                           
                           # Show a plot of the generated data and a message describing what it is trying to show
                           mainPanel(
                             plotOutput("second_plot"),
                             textOutput("second_message")
                           )
                         )
)
                      
#this creates the third panel

# creates a the list of choices for the widget

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

#this code is to create the third panel of our page

third_panel <- tabPanel(title = "Air Quality Map",
                        titlePanel("Air Quality in USA by PM2.5 Concentration"),
                        sidebarLayout(
                          sidebarPanel(
                            # this is to create a widget to select the year and the area you would like to map
                            sliderInput("Year3", label = h3("Year"), min = 1999,
                                        max = 2013, value = 2006),
                            selectInput("Location", label = h3("Location"),
                                        choices = Choices, selected = "Texas")
                          ),
                          
                          #show the generated map and a brief description of what PM2.5 and the purpose of the map
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
                              paste("Looking at our air quality over time, we were surprised a general trend of air quality 
                                    getting better as time went on. As with anything, there are exceptions to this, however 
                                    when looking across many states, air quality got better when using either air quality 
                                    metric. In most cases, the numbers of days either PM2.5 or ozone concentrations were 
                                    above the National Standard went down. This could be seen in a number of states, including
                                    Ohio, Maryland and Tennesse to name a few. However, it is important to note that this can 
                                    only be said up to 2013, as the dataset stops there. It was also interesting to see the 
                                    sudden and drastic improvment in air quality from 2008-2009. This can be seen both in the 
                                    shape of the graphs plotting air quality over time or in the shifting in the color of the 
                                    map of the US as a whole as you shift across those years. This seems to implicate that air quality
                                    could also be tied to current political and economic state as well, as 2008 was the year of the 
                                    most recent recession, where gas prices were high and there were likely less people driving
                                    which would lead to less air pollution. However, further investigation and data would be 
                                    required to confirm this."),
                              br(),
                              br(),
                              paste("Comparing our data across states, it seems as if California has the worst air quality 
                                    when using any of the air quality metrics in the dataset. This could be seen when cycling throughout
                                    the years, using either air quality metric, California was consistently at the top of the list for
                                    states with the worst quality."),
                              br(),
                              br(),
                              paste("Finally, looking at our map of PM2.5 concentrations, we can see that geographically speaking, 
                                    the northern part of the U.S seems to have the best air quality. Where we live, the Pacific Northwest, 
                                    also has good quality when comapred to the rest of the U.S. The areas that seem to have the worst air 
                                    quality are California and the states that are south of the midwest region of the U.S. This may implicate and 
                                    reflect the types of industries and/or policies related to the enviornment and industrial practices, however a 
                                    more definitive analysis and investigation would have to be done to confirm this."),
                              br(),
                              br(),
                              h2("Conclusion + Closing Thoughts"),
                              paste("In conclusion, while there are a few things we can say about what states and regions of the U.S has the 
                                    best/worst air quality and the trends in air quality over time, there are a few things that must be kept 
                                    in mind. Although this is a good source of data, there are a few problems that could effect the quality 
                                    of data measurements.  According to the CDC, data is recorded every three days and only in the 4000 measuring 
                                    facilities (mostly urban), with this data they predict measurements for the days they don’t record and assign
                                    neighboring counties a number without a real measurement. Although this is likely reasonable and accurate to 
                                    a true measurement, it is still an approximated guess that could result in inaccurate measurements in some 
                                    cases. Furthermore, the data in this particular dataset only goes up until 2013 and thus more recent data 
                                    will need to be found elsewhere. We chose to mitigate some of these issues by carefully forming our analyses
                                    and conclusions around the data that was avaialble and not choosing to include any of the modeled data, only 
                                    the measured data. However, there are also some good things about this dataset as well. The CDC is 
                                    a national health proection agency and the data collected is not for profit, so there is minimal reason 
                                    to question its validity and purpose of collection. Lastly, if someone were to look at this data and want 
                                    to take it a step further mitigate all of the mentioned issues and advance the findings that we found,
                                    they should start with finding data that is more recent, as well as finding data for counties that may not
                                    have been included in this dataset. While it may prove difficult to do,doing so would provide a much more 
                                    relavant and comprehensive look at U.S air quality and would be able to draw much more concrete conclusions."),
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


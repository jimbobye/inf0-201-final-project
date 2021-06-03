## this script plots the changes in air quality over time


# loading in the relavant packages  
library(shiny)
library(tidyverse)

#confirming we are the right directory
getwd()

#loads the air quality data in that we will need
data <- read.csv('data/air_quality.csv')

#this sciprt will be used to define my UI

ui <- fluidPage(
  
  # title
  titlePanel("USA Air Quality Changes Over Time"),
  
  # sidebar with widgets
  sidebarLayout(
    sidebarPanel(
      
      # widget to filter between three air quality metrics
      selectInput("Metric", label = "Air Quality Metric", 
                  choices = list("Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)" = "Percent of days with PM2.5 levels over the National Ambient Air Quality Standard (NAAQS)",
                                 "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard" = "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard",
                                 "Annual average ambient concentrations of PM2.5 in micrograms per cubic meter (based on seasonal averages and daily measurement)" = "Annual average ambient concentrations of PM2.5 in micrograms per cubic meter (based on seasonal averages and daily measurement)"),
                  selected = "Annual average ambient concentrations of PM2.5 in micrograms per cubic meter (based on seasonal averages and daily measurement)"),
      
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
                  selected = "Washington")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("timePlot")
    )
  )
)





shinyUI(ui)


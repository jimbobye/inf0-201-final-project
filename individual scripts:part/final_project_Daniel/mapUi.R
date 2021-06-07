library(shiny)

Choices = list(
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

shinyUI(fluidPage(
    titlePanel("Air quality in USA by PM 2.5"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("Year", label = h3("Year"), min = 1999, 
                    max = 2013, value = 2006),
        selectInput("Location", label = h3("Location"), 
                    choices = Choices)
        ),
    mainPanel(
      plotOutput("map"),
      textOutput("text")
    )
)))

library(shiny)
library(tidyverse)
library(dplyr)
library(maps)


air_data = read.csv("../data/air_quality.csv")

PM2.5data = air_data %>%
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

ggplotMap = function(year, level) {
    data = PM2.5data_shapes %>%
        filter(ReportYear == year)
    if(level != "USA") {
        data = data %>%
            filter(StateName == level)
    }
    return(
        ggplot(data, aes(x=long, y=lat, group=group)) +
            geom_polygon(colour = alpha("black", 1/2), size = 0.05, aes(fill=Value)) +
            scale_fill_gradientn(colors = c(green,"white",red)) +
            coord_quickmap() +
            theme_void() +
            labs(fill="Concentration of PM2.5 
            (µg/m³)", title=
                     paste0("Annual average ambient concentrations of PM 2.5 in ",
                            level, ", ", year, " (monitor and modeled data)"))
    )
}

shinyServer(function(input, output) {
    plot = reactive({
        ggplotMap(input$Year, input$Location)
    })
    output$map = renderPlot({plot()})
    output$text = renderText({"PM 2.5 is the concentration of particulate matter
    suspended in the air with a diameter of 2.5 μm or less. It's one
    of the key metrics in determining air quality. The higher level of 
    PM 2.5 the worse the quality of air. This map uses CDC PM 2.5 measurements
    and projections for years 1999-2013, data for some years/states might be missing"})
})

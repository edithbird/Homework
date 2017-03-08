#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(maps)
library(mapproj)
source("helpers.R")
counties <- readRDS("data/counties.rds")

shinyServer(
  function(input, output) {
    
    output$map <- renderPlot({
      
      
      
      data <- switch(input$var,
                     "Percent White"= counties$white, 
                     "Percent Black" = counties$black, 
                     "Percent Hispanic" = counties$hispanic, 
                     "Percent Asian" = counties$asian)
      
      color <- switch(input$var,
                      "Percent White" = "darkgreen",
                      "Percent Black" = "red",
                      "Percent Hispanic" = "darkorange",
                      "Percent Asian" = "darkviolet")
      
      legend <- switch(input$var, 
                       "Percent White" = "% White", 
                       "Percent Black" = "% Black", 
                       "Percent Hispanic" = "% Hispanic", 
                       "Percent Asian" = "% Asian")
      
      
      percent_map(var = data, 
                  color = color, 
                  legend.title = legend, 
                   max = input$range[2], 
                  min = input$range[1])
    })
      
  }
  )
    
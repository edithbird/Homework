#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(forecast)
trains <- read.csv("data/amtrak.csv")
#trains.ts <- ts(trains$ridership_in_thousands, start = c(1991,1), frequency = 12)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  

   
  output$ex1 <- DT::renderDataTable({
    DT::datatable(trains, options = list(pageLength = 12))

  })
  
  output$trainplot <- renderPlot({
    plot(output$ex1)
    
    
    
  })
  
  
 
})

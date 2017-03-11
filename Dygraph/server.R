#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(dygraphs)
library(forecast)
air <- read.csv("data/CopyOfAirTravel2.csv")
air <- air %>% mutate(Air_Miles_in_Millions = round(air$Air),0) %>% select(Month, Air_Miles_in_Millions)
air.ts <- ts(air$Air/10000, start = c(1990, 1), end = c(2000, 12), frequency = 12)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  predicted <- reactive({
    hw <- HoltWinters(air.ts)
    predict(hw, n.ahead = input$months, 
            prediction.interval = TRUE,
            level = as.numeric(input$interval))
  })
  
  output$dygraph <- renderDygraph({
    dygraph(predicted(), main = "Predicted Air Miles Travelled/Month") %>%
      dySeries(c("lwr", "fit", "upr"), label = "Miles") %>%
      dyOptions(drawGrid = input$showgrid)
  })
  
  output$from <- renderText({
    strftime(req(input$dygraph_date_window[[1]]), "%d %b %Y")      
  })
  
  output$to <- renderText({
    strftime(req(input$dygraph_date_window[[2]]), "%d %b %Y")
  })
  
  output$clicked <- renderText({
    strftime(req(input$dygraph_click$x), "%d %b %Y")
  })
  
  output$point <- renderText({
    paste0('X = ', strftime(req(input$dygraph_click$x_closest_point), "%d %b %Y"), 
           '; Y = ', req(input$dygraph_click$y_closest_point))
  })
  
  output$tbl <- DT::renderDataTable({
         air
  
  # output$accuracy <- renderTable({
  #   accuracy <- accuracy(HoltWinters(air.ts))
  #   accuracy
    
  })
    
    
})
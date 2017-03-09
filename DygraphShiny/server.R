
library(shiny)
library(zoo)
library(dygraphs)
library(caTools)

library(RJSONIO)

train <- read.zoo("data/CopyOfAmtrak.csv", format = "%m/%d/%Y", sep = ",", header = T)
head(train)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  predicted <- reactive({
    print(train)
    
  })
  
   output$dygraph <- renderDygraph({
     dygraph(predicted(), main = "Ridership", ylab = "Number of Riders") %>% 
       dyOptions(drawGrid = input$showgrid) %>% 
       dyOptions(axisLineWidth = 1.5, fillGraph = TRUE) %>% 
       dySeries(label="# rider", color="blue") %>%
       dyShading(from="1995-1-1", to="1996-1-1", color="#FFE6E6") %>%
       dyShading(from="2000-1-1", to="2001-1-1", color="#CCEBD6") %>% 
       dyLegend(show = "follow") %>% 
       dyAxis("x", valueRange = c(low, high)) 
     
     
   })
  
  
})

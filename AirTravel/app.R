#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dygraphs)
library(forecast)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Air Passenger Data"),
   
   # Sidebar with a slider input for number of bins 
   
   DT::dataTableOutput("tbl")
   
      ) 
mainPanel(

dygraphOutput("dyplot"))
   


air <- read.csv("data/CopyOfAirTravel.csv")
air <- air %>% mutate(Air_Miles_in_Millions = round(air$Air/100000),0) %>% select(Month, Air_Miles_in_Millions)
air.ts <- ts(air$Air/10000, start = c(1990, 1), end = c(2000, 12), frequency = 12)

server <- function(input, output) {
   
   output$tbl <- DT::renderDataTable({
     air
     
     })
   
   output$dyplot <- renderDygraph({
     dygraph(air.ts(), main = "HHUHUHJKJKN")
     
     
     
     # par(mar = c(5.1, 4.1, 0, 1))
     # plot(air.ts(), ylim = c(2800, 7000), ylab = "Passangers", xlab = "Time", main = "")
     
     
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)


#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dygraphs)
library(caTools)

library(RJSONIO)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Amtrak Ridership through Time"), 
  sidebarLayout(
    sidebarPanel(
      numericInput("months", label = "Months to Predict", 
                   value = 12, min = 4, max = 12, step = 12), 
      selectInput("riders", label = "Number of Riders", 
                  choices = c("1300", "1500" ,"1700"  , "1900", "2100", "2300"), 
                  selected = "1500"), 
      checkboxInput("showgrid", label = "Show Grid", value = TRUE)
    ),
  #   hr(),
  #   div(strong("From: "), textOutput("from", inline = TRUE)),
  #   div(strong("To: "), textOutput("to", inline = TRUE)),
  #   div(strong("Date clicked: "), textOutput("clicked", inline = TRUE)),
  #   div(strong("Nearest point clicked: "), textOutput("point", inline = TRUE)),
  #   br(),
  #   helpText("Click and drag to zoom in (double click to zoom back out).")
  # ),
    mainPanel(dygraphOutput("dygraph"))
    
  )
) 
  
)

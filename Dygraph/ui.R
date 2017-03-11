#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Time Series"),
  
  
  
  
  sidebarLayout(
    sidebarPanel(
      numericInput("months", label = "Months to Predict", 
                   value = 72, min = 12, max = 144, step = 12), 
      
      selectInput("interval", label = "Prediction Interval",
                  choices = c("0.80", "0.90", "0.95", "0.99"),
                  selected = "0.95"),
      checkboxInput("showgrid", label = "Show Grid", value = TRUE),
      hr(),
      div(strong("From: "), textOutput("from", inline = TRUE)),
      div(strong("To: "), textOutput("to", inline = TRUE)),
      div(strong("Date clicked: "), textOutput("clicked", inline = TRUE)),
      div(strong("Nearest point clicked: "), textOutput("point", inline = TRUE)),
      br(),
      helpText("Click and drag to zoom in (double click to zoom back out).")
      
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      dygraphOutput("dygraph"),
      DT::dataTableOutput("tbl")
      
      #tableOutput("accuracy")
    )
  )
))

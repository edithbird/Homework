

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  
  # Application title
  title = "DataTable Options",
  tabPanel("Display", DT::dataTableOutput("ex1")
), 


h3("Train Plot"), 
plotOutput("trainplot")





))
  
 

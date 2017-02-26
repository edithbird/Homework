library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Scoring"),
  
  mainPanel(
    fluidRow(
      h4("Player Awesome"), 
      
      plotOutput("plot1"),
      
      h4("Player Excellent"),
      plotOutput("plot2"), 
      
      
      tableOutput("totals")
    )),
  fluidRow(
    column(3, offset = 3,
           h4("Player 1"),
           numericInput('R1_Pl', 'Round 1 Score', 
                        min=-15, max=60, value=10),
           numericInput('R2_Pl', 'Round 2 Score', 
                        min=-15, max=60, value=10),
           numericInput('R3_Pl', 'Round 3 Score', 
                        min=-15, max=60, value=10),
           numericInput('R4_Pl', 'Round 4 Score', 
                        min=-15, max=60, value=10),
           numericInput('R5_Pl', 'Round 5 Score', 
                        min=-15, max=60, value=10),
           numericInput('R6_Pl', 'Round 6 Score', 
                        min=-15, max=60, value=10),
           numericInput('R7_Pl', 'Round 7 Score', 
                        min=-15, max=60, value=10),
           numericInput('R8_Pl', 'Round 8 Score', 
                        min=-15, max=60, value=10)
           
           
    ),
    column(3, offset = 3,
           h4("Player 2"),
           numericInput('R1_P2', 'Round 1 Score', 
                        min=-15, max=60, value=10),
           numericInput('R2_P2', 'Round 2 Score', 
                        min=-15, max=60, value=10),
           numericInput('R3_P2', 'Round 3 Score', 
                        min=-15, max=60, value=10),
           numericInput('R4_P2', 'Round 4 Score', 
                        min=-15, max=60, value=10),
           numericInput('R5_P2', 'Round 5 Score', 
                        min=-15, max=60, value=10),
           numericInput('R6_P2', 'Round 6 Score', 
                        min=-15, max=60, value=10),
           numericInput('R7_P2', 'Round 7 Score', 
                        min=-15, max=60, value=10),
           numericInput('R8_P2', 'Round 8 Score', 
                        min=-15, max=60, value=10) 
           
           
           
    )
  )
  
  
))
  
  
 


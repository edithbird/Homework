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
  
  
  
  fixedRow(
    column(2, offset = 3,
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
    column(2, offset = 4,
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
           
           
           
    ), 
    
    
    
    
    
    
    
    
    column(2, offset = 3,
           h4("Longest?"), 
           
           #inputId, label, value 
           checkboxInput('P11', "Longest R 1?"),
           checkboxInput('P12', "Longest R 2?"),
           checkboxInput('P13', "Longest R 3?"),
           checkboxInput('P14', "Longest R 4?"),
           checkboxInput('P15', "Longest R 5?"),
           checkboxInput('P16', "Longest R 6?"),
           checkboxInput('P17', "Longest R 7?"),
           checkboxInput('P18', "Longest R 8?")
           
           
           
           
           
           
           
    ),
    
    
    column(2, offset = 4,
           h4("Longest?"), 
           
           #inputId, label, value 
           checkboxInput('P21', "Longest R 1?"),
           checkboxInput('P22', "Longest R 2?"),
           checkboxInput('P23', "Longest R 3?"),
           checkboxInput('P24', "Longest R 4?"),
           checkboxInput('P25', "Longest R 5?"),
           checkboxInput('P26', "Longest R 6?"),
           checkboxInput('P27', "Longest R 7?"),
           checkboxInput('P28', "Longest R 8?")
           
           
           
           
           
           
           
    )
  )
  
  
))
  
  
 


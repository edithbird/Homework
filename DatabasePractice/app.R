#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

#fileds for the final data table that is being built
fields <- c("name1", "sum1", "name2", "sum")

# Define UI for application that draws a histogram
ui <- fluidPage(
#this adds bootstrap
  tags$head(
    
    tags$link(rel = "stylesheet", type = "text/css", href = "Bootstrap.css"),
  
  h1("Quiddler Score"),
  mainPanel(
    fluidRow(
      column(4, 
             textInput("name1", "Name Player 1"),
             #input for player 1
             numericInput("integer1", "Round 1:",
                          min=-15, max=60, value=0),
             
             numericInput("integer3", "Round 2:", 
                          min=-15, max=60, value=0),
             
             numericInput("integer5", "Round 3:", 
                          min=-15, max=60, value=0),
             
             numericInput("integer7", "Round 4:",
                          min=-15, max=60, value=0),
             
             numericInput("integer9", "Round 5:", 
                          min=-15, max=60, value=0),
             
             numericInput("integer11", "Round 6:", 
                          min=-15, max=60, value=0),
             
             numericInput("integer13", "Round 7:", 
                          min=-15, max=60, value=0),
             
             numericInput("integer15", "Round 8:", 
                          min=-15, max=60, value=0), 
             h4("Player 2, are you ready to submit your score?"), 
             
             tableOutput("sum1"), 
             actionButton("submit", "Push ")
         ), 
      column(4,
               textInput("name2", "Name Player 2"), 
             #input for player 2
             numericInput("integer2", "Round 1:", 
                          min=-15, max=60, value=0),
             numericInput("integer4", "Round 2:",
                          min=-15, max=60, value=0),
             numericInput("integer6", "Round 3:", 
                          min=-15, max=60, value=0),
             numericInput("integer8", "Round 4:", 
                          min=-15, max=60, value=0),
             numericInput("integer10", "Round 5:",
                          min=-15, max=60, value=0),
             numericInput("integer12", "Round 6:", 
                          min=-15, max=60, value=0),
             numericInput("integer14", "Round 7:", 
                          min=-15, max=60, value=0), 
             numericInput("integer16", "Round 8:", 
                          min=-15, max=60, value=0), 
             h4("Player 2, are you ready to submit your score?"),
             tableOutput("sum2"),
             
             actionButton("submit", "Push ")
             
      ),
      
      #table of the final scores
      column(12, offset = 4,
             h2("Final Scores"
             ),
             DT::dataTableOutput("table1", width = 300), tags$hr(),
             
             #tableOutput("table1")),
      #performance table for this game
      plotOutput("barplot4")
  #Defining the three fields of the data table

)))))







# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$sum1 <- renderTable({
    data.frame(
    
    Total = sum(input$integer1,input$integer3, input$integer5,
               input$integer7,input$integer9, input$integer11,
               input$integer13,input$integer15)
)})
  
  output$sum2 <- renderTable({
    data.frame(
    
    Total = sum(input$integer2,input$integer4, input$integer6,
               input$integer8,input$integer10, input$integer12,
               input$integer14,input$integer16)
   )})
  
  
  output$table1 <- renderTable({
 
    data.frame(
      
      Player1 =  sum(input$integer1,input$integer3, input$integer5,
                     input$integer7,input$integer9, input$integer11,
                     input$integer13,input$integer15), 
      Player2 =  sum(input$integer2,input$integer4, input$integer6,
                     input$integer8,input$integer10, input$integer12,
                     input$integer14,input$integer16)
      )})
  
  output$barplot4 <- renderPlot({
    
    blue.bold.italic.16.text <- element_text(face = "bold", color = "black", size = 14)
    
    axisTitle <- element_text(face = "bold", color = "black", size = 16)
    
    
    Round_Number = c("1", "1", "2", "2", "3", "3",   
                     "4", "4", "5", "5", "6", "6",  
                     "7", "7", "8", "8") 
    
    Player = c("1", "2", "1", "2",  "1", "2",  "1", 
               "2",  "1", "2",  "1", "2",  "1", "2", 
                "1", "2")
    
    Score = c(input$integer1, input$integer2,  
              input$integer3, input$integer4,  input$integer5, 
              input$integer6,  input$integer7, input$integer8, 
              input$integer9, input$integer10,  
              input$integer11, input$integer12,  input$integer13, 
              input$integer14,  input$integer15, input$integer16)
    
    DF <- data.frame(Player, Round_Number, Score)
    
    ggplot(DF, aes(x = Round_Number, y = Score, fill = Player, main = "Title")) + 
      geom_bar(stat = "identity", size = 2, position = "dodge") + 
      scale_fill_manual(values=c("slateblue3", "yellow")) + 
      labs(x="Round", y="Score") +
      #scale_fill_hue(c=45, l=80) + 
      ylim(-15, 80) + theme(panel.grid.major = element_blank(), 
                            panel.grid.minor = element_blank(), 
                            panel.border = element_blank(), 
                            panel.background = element_blank(), 
                            axis.text.x = blue.bold.italic.16.text, 
                            axis.text.y = blue.bold.italic.16.text, 
                            axis.title.x = axisTitle, 
                            axis.title.y = axisTitle)
  })


  
  
 #Data table responses1 given the variable name data 
  saveData <- function(answers) {
    answers <- as.data.frame(t(answers))
    if (exists("table1")) {
      table1 <<- rbind(table1, answers)
    } else {
      table1 <<- answers
    }
  }
  
  #Load the data
  loadData <- function() {
    if (exists("table1")) {
      table1
    }
  }

  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    answers <- sapply(fields, function(x) input[[x]])
    answers
  })
  
  # When the Submit button is clicked, save the form answers
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  # Show the previous responses1
  # (update with current response when Submit is clicked)
  output$table1 <- DT::renderDataTable({
    
    
    input$submit
    loadData()
  })    
  
  
}
#})

# Run the application 
shinyApp(ui = ui, server = server)


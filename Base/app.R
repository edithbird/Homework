

library(shiny)
library(ggplot2)
fields <- fields <- c("name1", "sum1", "name2", "sum")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  
  
  
 
  fluidRow(
    column(4, 
      textInput("name1", "Name", ""),
  numericInput("integer1", "Round 1:",
               min=-15, max=60, value=0),
  
  numericInput("integer3", "Round 2:", 
               min=-15, max=60, value=0)
  
), 
column(4,
       textInput("name2", "Name Player 2"), 
       #input for player 2
       numericInput("integer2", "Round 1:", 
                    min=-15, max=60, value=0),
       numericInput("integer4", "Round 2:",
                    min=-15, max=60, value=0)
), 

column(4,
       tableOutput("Sum")
),
actionButton("submit", "Submit"), 
DT::dataTableOutput("responses", width = 300), tags$hr()



)

# , 
# plotOutput("barplot4")

)
  

# Define server logic required to draw a histogram
server <- function(input, output) {
  
#This is the table with the player names and the summed scores  
  output$Sum <- renderTable({
    data.frame(
      Player1 = print(input$name1), 
      Player1Score = sum(input$integer1, input$integer3), 
      Player2 = print(input$name2), 
      Player2Score = sum(input$integer2, input$integer4)
    )
  })
  
  saveData <- function(data) {
    data <- as.data.frame(t(data))
    if (exists("responses")) {
      responses <<- rbind(responses, data)
    } else {
      responses <<- data
    }
  }
  
  loadData <- function() {
    if (exists("responses")) {
      responses
    }
  }
  
  
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  output$responses <- DT::renderDataTable({
    input$submit
    loadData()
  })
  
  # output$barplot4 <- renderPlot({
  #   
  #   blue.bold.italic.16.text <- element_text(face = "bold", color = "black", size = 14)
  #   
  #   axisTitle <- element_text(face = "bold", color = "black", size = 16)
  #   
  #   
  #   Round_Number = c("1", "1", "2", "2") 
  #   
  #   Player = c("1", "2", "1", "2")
  #   
  #   Score = c(input$integer1, input$integer2, 
  #             input$integer3, input$integer4)
  #   
  #   DF <- data.frame(Player, Round_Number, Score)
  #   
  #   ggplot(DF, aes(x = Round_Number, y = Score, fill = Player)) + 
  #     geom_bar(stat = "identity", size = 2, position = "dodge") + 
  #     scale_fill_manual(values=c("slateblue3", "yellow")) + 
  #     labs(x="Round", y="Score") +
  #     #scale_fill_hue(c=45, l=80) + 
  #     ylim(-15, 80) + theme(panel.grid.major = element_blank(), 
  #                           panel.grid.minor = element_blank(), 
  #                           panel.border = element_blank(), 
  #                           panel.background = element_blank(), 
  #                           axis.text.x = blue.bold.italic.16.text, 
  #                           axis.text.y = blue.bold.italic.16.text, 
  #                           axis.title.x = axisTitle, 
  #                           axis.title.y = axisTitle)
  #})
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)



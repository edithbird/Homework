library(shiny)
library(ggplot2)


ui <- fluidPage(
  
  # Application title
  titlePanel("Quiddler Score"),
mainPanel(
  fluidRow(
    column(3, offset = 3,
           h4("Player 1"), 
           numericInput("integer1", "Round 1 USA:",
                        min=-15, max=60, value=0),
           
           numericInput("integer3", "Round 2 USA:", 
                        min=-15, max=60, value=0),
           
           numericInput("integer5", "Round 3 USA:", 
                        min=-15, max=60, value=0),
          
           numericInput("integer7", "Round 4 USA:",
                        min=-15, max=60, value=0),
           
           numericInput("integer9", "Round 5 USA:", 
                        min=-15, max=60, value=0),
           
           numericInput("integer11", "Round 6 USA:", 
                        min=-15, max=60, value=0),
           
           numericInput("integer13", "Round 7 USA:", 
                        min=-15, max=60, value=0),
           
           numericInput("integer15", "Round 8 USA:", 
                        min=-15, max=60, value=0)
           
    
           ), 
    column(3, offset = 3, 
           h4("Player 2"), 
           numericInput("integer2", "Round 1 Russia:", 
                        min=-15, max=60, value=0),
           numericInput("integer4", "Round 2 Russia:",
                        min=-15, max=60, value=0),
           numericInput("integer6", "Round 3 Russia:", 
                        min=-15, max=60, value=0),
           numericInput("integer8", "Round 4 Russia:", 
                        min=-15, max=60, value=0),
           numericInput("integer10", "Round 5 Russia:",
                        min=-15, max=60, value=0),
           numericInput("integer12", "Round 6 Russia:", 
                        min=-15, max=60, value=0),
           numericInput("integer14", "Round 7 Russia:", 
                        min=-15, max=60, value=0), 
           numericInput("integer16", "Round 8 Russia", 
                        min=-15, max=60, value=0)
    ),





  
  
  
  
  

      tableOutput("table1"),
      plotOutput("barplot"),
      plotOutput("barplot2")

    )
  ))


# Define server logic required to draw a histogram
server <- function(input, output) ({
  
  output$table1 <- renderTable({
    data.frame(
      #Name = c("USA", "Russia"), 
      USA =  sum(input$integer1,input$integer3, input$integer5,input$integer7,input$integer9, input$integer11,input$integer13,input$integer15), 
      Russia =  sum(input$integer2,input$integer4, input$integer6,input$integer8,input$integer10, input$integer12,input$integer14,input$integer16)
    
      )})
    
    output$barplot <- renderPlot({
      
      cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
      Round <- c("1", "2", "3", "4", "5", "6", "7", "8")
      ScorePl1 <- c(input$integer1,input$integer3, input$integer5,input$integer7,input$integer9, input$integer11,input$integer13,input$integer15)
      ScorePl2 <- c(input$integer2,input$integer4, input$integer6,input$integer8,input$integer10, input$integer12,input$integer14,input$integer16)

      Data <- data.frame(Round, ScorePl1, ScorePl2)
      
      
      ggplot(Data, aes(x=Round, y=ScorePl1)) + geom_bar(stat = "identity", fill ="blue") + 
        labs(x="Round", y="Score") +
        scale_fill_hue(c=45, l=80) + ggtitle("Player 1") + 
        theme(plot.title = element_text(lineheight= 3.8, face="bold"))
      
      
      
      
    
      
    
    })
    
    output$barplot2 <- renderPlot({
      cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
      Round <- c("1", "2", "3", "4", "5", "6", "7", "8")
      ScorePl1 <- c(input$integer1,input$integer3, input$integer5,input$integer7,input$integer9, input$integer11,input$integer13,input$integer15)
      ScorePl2 <- c(input$integer2,input$integer4, input$integer6,input$integer8,input$integer10, input$integer12,input$integer14,input$integer16)
      
      Data <- data.frame(Round, ScorePl1, ScorePl2)
      
      
      ggplot(Data, aes(x = Round, y = ScorePl2)) + geom_bar(stat = "identity", fill = "pink") + 
        labs(x="Round", y="Score") +
        scale_fill_hue(c=45, l=80) + ggtitle("Player 2") + 
        theme(plot.title = element_text(lineheight= 3.8, face="bold"))
    })
 })
    
    
  


# Run the application 
shinyApp(ui = ui, server = server)


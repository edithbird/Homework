library(shiny)
library(ggplot2)


ui <- fluidPage(
  

  h1("Quiddler Score"),
  mainPanel(
    fluidRow(
      column(4, 
             h2("Player 1"), 
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
                          min=-15, max=60, value=0)
             
             
      ), 
      column(4, #offset = 2, 
             h2("Player 2"), 
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
                          min=-15, max=60, value=0)
      ),
      
      column(4, 
             h2("Player 3"), 
             numericInput("integer17", "Round 1:", 
                          min=-15, max=60, value=0),
             numericInput("integer18", "Round 2:",
                          min=-15, max=60, value=0),
             numericInput("integer19", "Round 3:", 
                          min=-15, max=60, value=0),
             numericInput("integer20", "Round 4:", 
                          min=-15, max=60, value=0),
             numericInput("integer21", "Round 5:",
                          min=-15, max=60, value=0),
             numericInput("integer22", "Round 6:", 
                          min=-15, max=60, value=0),
             numericInput("integer23", "Round 7:", 
                          min=-15, max=60, value=0), 
             numericInput("integer24", "Round 8:", 
                          min=-15, max=60, value=0)
      ),
      
      
      
      
      
      
      
      
      
      column(12, offset = 4,
             h2("Scores"
                ), 
      tableOutput("table1")),
      column(4,
             h2("Player 1"),
      plotOutput("barplot")),
      column(4, 
             h2("Player 2"),
      plotOutput("barplot2")),
      column(4,
             h2("Player 3"),
      plotOutput("barplot3")), 
      #tableOutput("table2"), 
      plotOutput("barplot4")
      
    )    
    
  ))

server <- function(input, output) ({
  
  output$table1 <- renderTable({
    data.frame(
      #Name = c("Player 1", "Player 2"), 
      Player1 =  sum(input$integer1,input$integer3, input$integer5,input$integer7,input$integer9, input$integer11,input$integer13,input$integer15), 
      Player2 =  sum(input$integer2,input$integer4, input$integer6,input$integer8,input$integer10, input$integer12,input$integer14,input$integer16),
      Player3 = sum(input$integer17,input$integer18, input$integer19,input$integer20,input$integer21, input$integer22,input$integer23,input$integer24)
      
    )})
  
  output$barplot <- renderPlot({
    #rainbowcols <- rainbow(8)
    color <- c("slateblue3", "yellow", "red","slateblue3", "yellow", "red","slateblue3","red")
    
    Round <- c("1", "2", "3", "4", "5", "6", "7", "8")
    ScorePl1 <- c(input$integer1,input$integer3, input$integer5,input$integer7,input$integer9, input$integer11,input$integer13,input$integer15)
    ScorePl2 <- c(input$integer2,input$integer4, input$integer6,input$integer8,input$integer10, input$integer12,input$integer14,input$integer16)
    
    Data <- data.frame(Round, ScorePl1, ScorePl2)
    
    
    ggplot(Data, aes(x=Round, y=ScorePl1)) + geom_bar(stat = "identity",  size = 2, fill = color) + #"slateblue3"
      labs(x="Round", y="Score") +
      scale_fill_hue(c=45, l=80) +  #labs(title = "Player 1 Score") + 
      ylim(-15, 80) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_blank(), panel.background = element_blank())
      
     }) 
  
  output$barplot2 <- renderPlot({
    color <- c("slateblue3", "yellow", "red","slateblue3", "yellow", "red","slateblue3","red")
    rainbowcols <- rainbow(8)
    Round <- c("1", "2", "3", "4", "5", "6", "7", "8")
    ScorePl1 <- c(input$integer1,input$integer3, input$integer5,input$integer7,input$integer9, input$integer11,input$integer13,input$integer15)
    ScorePl2 <- c(input$integer2,input$integer4, input$integer6,input$integer8,input$integer10, input$integer12,input$integer14,input$integer16)
    ScorePl3 <- c(input$integer17,input$integer18, input$integer19,input$integer20,input$integer21, input$integer22,input$integer23,input$integer24)
    Data <- data.frame(Round, ScorePl1, ScorePl2, ScorePl3)
    
    
    ggplot(Data, aes(x = Round, y = ScorePl2)) + geom_bar(stat = "identity", size = 2, fill = color) + #"yellow
      labs(x="Round", y="Score") +
      scale_fill_hue(c=45, l=80) +
      ylim(-15, 80) + theme(panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank())
  })
  
  
  output$barplot3 <- renderPlot({
    color <- c("slateblue3", "yellow", "red","slateblue3", "yellow", "red","slateblue3","red")
    rainbowcols <- rainbow(8)
    Round <- c("1", "2", "3", "4", "5", "6", "7", "8")
    ScorePl3 <- c(input$integer17,input$integer18, input$integer19,input$integer20,input$integer21, input$integer22,input$integer23,input$integer24)
    Data <- data.frame(Round, ScorePl3)
    
    
    
    ggplot(Data, aes(x = Round, y = ScorePl3)) + geom_bar(stat = "identity", size = 2, fill = color) + 
      labs(x="Round", y="Score") +
      scale_fill_hue(c=45, l=80) + 
      ylim(-15, 80) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_blank(), panel.background = element_blank())
  
  })
  
  # output$table2 <- renderTable({
  #   data.frame(
  #     Round_Number = c("1", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8"), 
  #     Player = c("1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3"), 
  #     Score = c(input$integer1, input$integer2, input$integer17, input$integer3, input$integer4, input$integer18, input$integer5, input$integer6, input$integer19, input$integer7, input$integer8, input$integer20, input$integer9, input$integer10, input$integer21, input$integer11, input$integer12, input$integer22, input$integer13, input$integer14, input$integer23, input$integer15, input$integer16, input$integer24)
  #    )
  #   })
   output$barplot4 <- renderPlot({
     Round_Number = c("1", "1", "1", "2", "2", "2", "3", "3", "3", "4", "4", "4", "5", "5", "5", "6", "6", "6", "7", "7", "7", "8", "8", "8") 
     Player = c("1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", "3")
     Score = c(input$integer1, input$integer2, input$integer17, input$integer3, input$integer4, input$integer18, input$integer5, input$integer6, input$integer19, input$integer7, input$integer8, input$integer20, input$integer9, input$integer10, input$integer21, input$integer11, input$integer12, input$integer22, input$integer13, input$integer14, input$integer23, input$integer15, input$integer16, input$integer24)
     DF <- data.frame(Player, Round_Number, Score)

     ggplot(DF, aes(x = Round_Number, y = Score, fill = Player)) + geom_bar(stat = "identity", size = 2, position = "dodge") + 
       scale_fill_manual(values=c("slateblue3", "yellow", "red"))
   })
})
 
shinyApp(ui = ui, server = server)


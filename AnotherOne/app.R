library(shiny)
library(ggplot2)
#library(googlesheets)


ui <- fluidPage(
  
  
  h1("Quiddler Score"),
  mainPanel(
    fluidRow(
      column(4, 
             h2("Paul"), 
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
      column(4,  
             h2("Jeff"), 
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
             h2("Chris"), 
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
      
      h2("Score"),
      plotOutput("barplot4")
      
    )    
    
  ))

server <- function(input, output) ({
  
  output$table1 <- renderTable({
    data.frame(
      
      Paul =  sum(input$integer1,input$integer3, input$integer5,
                     input$integer7,input$integer9, input$integer11,
                     input$integer13,input$integer15), 
      Chris =  sum(input$integer2,input$integer4, input$integer6,
                     input$integer8,input$integer10, input$integer12,
                     input$integer14,input$integer16),
      Jeff = sum(input$integer17,input$integer18, input$integer19,
                    input$integer20,input$integer21, input$integer22,
                    input$integer23,input$integer24)
    )})
  
  #Want to create a database to save scores
  #[this site is helpful](https://shiny.rstudio.com/articles/persistent-data-storage.html#s3)
  
  
 
  
  output$barplot4 <- renderPlot({
    
    blue.bold.italic.16.text <- element_text(face = "bold", color = "black", size = 14)
    
    axisTitle <- element_text(face = "bold", color = "black", size = 16)
    
    
    Round_Number = c("1", "1", "1", "2", "2", "2", "3", "3", "3", 
                     "4", "4", "4", "5", "5", "5", "6", "6", "6", 
                     "7", "7", "7", "8", "8", "8") 
    
    Player = c("1", "2", "3", "1", "2", "3", "1", "2", "3", "1", 
               "2", "3", "1", "2", "3", "1", "2", "3", "1", "2", 
               "3", "1", "2", "3")
    
    Score = c(input$integer1, input$integer2, input$integer17, 
              input$integer3, input$integer4, input$integer18, input$integer5, 
              input$integer6, input$integer19, input$integer7, input$integer8, 
              input$integer20, input$integer9, input$integer10, input$integer21, 
              input$integer11, input$integer12, input$integer22, input$integer13, 
              input$integer14, input$integer23, input$integer15, input$integer16, 
              input$integer24)
    
    DF <- data.frame(Player, Round_Number, Score)
    
    ggplot(DF, aes(x = Round_Number, y = Score, fill = Player)) + 
      geom_bar(stat = "identity", size = 2, position = "dodge") + 
      scale_fill_manual(values=c("purple", "orange", "yellow2")) + 
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
})


shinyApp(ui = ui, server = server)


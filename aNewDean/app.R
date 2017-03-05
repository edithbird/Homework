#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(dplyr)
library(digest)
library(ggplot2)

# Define UI for application that draws a histogram

fieldsMandatory <- c("integer1", "integer2", "integer3", "integer4", 
                     "integer4", "integer5", "integer6", "integer7", 
                     "integer8", "integer9", "integer10", "integer11", 
                     "integer12", "integer13", "integer14", "integer15", 
                     "integer16")


fieldsAll <- c("integer1", "integer2", "integer3", "integer4",
               "integer4", "integer5", "integer6", "integer7",
               "integer8", "integer9", "integer10", "integer11",
               "integer12", "integer13", "integer14", "integer15",
               "integer16", "integer17", "integer18", "integer19",
               "integer20", "integer21", "integer22", "integer23",
               "integer24")

labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}
appCSS <- ".mandatory_star { color: red; }"

responsesDirectory <- file.path("C:\Users\Chris Iyer\Documents\responses.csv")

#humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")

ui <- fluidPage(
  shinyjs::useShinyjs(),
  shinyjs::inlineCSS(appCSS),
  titlePanel("Quiddler Score"),
  div(
    id = "form",
    
    mainPanel(
      fluidRow(
        column(4, 
               h2("Paul"), 
               numericInput("integer1", labelMandatory("Round 1:"),
                            min=-15, max=80, value=0),
               
               numericInput("integer3", labelMandatory("Round 2:"), 
                            min=-15, max=80, value=0),
               
               numericInput("integer5",labelMandatory("Round 3:"), 
                            min=-15, max=80, value=0),
               
               numericInput("integer7",labelMandatory("Round 4:"),
                            min=-15, max=80, value=0),
               
               numericInput("integer9", labelMandatory("Round 5:"), 
                            min=-15, max=80, value=0),
               
               numericInput("integer11", labelMandatory("Round 6:"), 
                            min=-15, max=80, value=0),
               
               numericInput("integer13", labelMandatory("Round 7:"), 
                            min=-15, max=80, value=0),
               
               numericInput("integer15", labelMandatory("Round 8:"), 
                            min=-15, max=80, value=0)
               
               
        ), 
        column(4,  
               h2("Chris"), 
               numericInput("integer2", labelMandatory("Round 1:"), 
                            min=-15, max=80, value=0),
               numericInput("integer4", labelMandatory("Round 2:"),
                            min=-15, max=80, value=0),
               numericInput("integer6", labelMandatory("Round 3:"), 
                            min=-15, max=80, value=0),
               numericInput("integer8", labelMandatory("Round 4:"), 
                            min=-15, max=80, value=0),
               numericInput("integer10", labelMandatory("Round 5:"),
                            min=-15, max=80, value=0),
               numericInput("integer12", labelMandatory("Round 6:"), 
                            min=-15, max=80, value=0),
               numericInput("integer14", labelMandatory("Round 7:"), 
                            min=-15, max=80, value=0), 
               numericInput("integer16", labelMandatory("Round 8:"), 
                            min=-15, max=80, value=0)
        ),
        
        column(4, 
               h2("Jeff"), 
               numericInput("integer17", "Round 1:", 
                            min=-15, max=80, value=0),
               numericInput("integer18", "Round 2:",
                            min=-15, max=80, value=0),
               numericInput("integer19", "Round 3:", 
                            min=-15, max=80, value=0),
               numericInput("integer20", "Round 4:", 
                            min=-15, max=80, value=0),
               numericInput("integer21", "Round 5:",
                            min=-15, max=80, value=0),
               numericInput("integer22", "Round 6:", 
                            min=-15, max=80, value=0),
               numericInput("integer23", "Round 7:", 
                            min=-15, max=80, value=0), 
               numericInput("integer24", "Round 8:", 
                            min=-15, max=80, value=0), 
               actionButton("submit", "Submit", class = "btn-primary")
        ),
        
        column(12, offset = 4,
               h2("Scores"
               ), 
               tableOutput("table1")),
        
        h2("Score"),
        plotOutput("barplot4"),
        
        
        div(id = "form", ...),
        shinyjs::hidden(
          div(
            id = "thankyou_msg",
            h3("Thanks, your response was submitted successfully!"),
            actionLink("submit_another", "Submit another response")
          )
        )
        
      )
    )
    
  )
)












# Define server logic required to draw a histogram
server <- function(input, output) ({
  
  server = function(input, output, session) {
    observe({
      mandatoryFilled <-
        vapply(fieldsMandatory,
               function(x) {
                 !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
      mandatoryFilled <- all(mandatoryFilled)
      
      shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
    })    
  } 
  
  
  
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
    
    
    
    Player = c("Paul", "Chris", "Jeff",
               "Paul", "Chris", "Jeff",
               "Paul", "Chris", "Jeff",
               "Paul", "Chris", "Jeff",
               "Paul", "Chris", "Jeff",
               "Paul", "Chris", "Jeff",
               "Paul", "Chris", "Jeff", 
               "Paul", "Chris", "Jeff")
    
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
  
  
  observe({
    # check if all mandatory fields have a value
    mandatoryFilled <-
      vapply(fieldsMandatory,
             function(x) {
               !is.null(input[[x]]) && input[[x]] != ""
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    # enable/disable the submit button
    shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  })
  
  
  
  formData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])

    data <- t(data)
              data
  })
  
  
  saveData <- function(data){
    fileName <- sprintf("%s_%s.csv",
                        #humanTime(),
                        digest::digest(data))
    
    write.csv(x = data, file = file.path(responsesDir, fileName),
              row.names = FALSE, quote = TRUE)
  }
  
  observeEvent(input$submit, {
    saveData(formData())
  })
  
    
  
  observeEvent(input$submit, {
    saveData(formData())
    shinyjs::reset("form")
    shinyjs::hide("form")
    #shinyjs::show("thankyou_msg")
  }) 
  
  observeEvent(input$submit_another, {
    shinyjs::show("form")
    #shinyjs::hide("thankyou_msg")
  }) 
  
  
})


shinyApp(ui = ui, server = server)



#responsesDir <- file.path("responses")

# epochTime <- function() {
#   as.integer(Sys.time())
# }


#   
#   saveData <- function(data) {
#     fileName <- sprintf("%s_%s.csv",
#                         humanTime(),
#                         digest::digest(data))
#     
#     write.csv(x = data, file = file.path(responsesDir, fileName),
#               row.names = FALSE, quote = TRUE)
#   }
#   
#   # action to take when submit button is pressed
#   observeEvent(input$submit, {
#     saveData(formData())
#   })  
#   
#   humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")
#   
#   # action to take when submit button is pressed
#   observeEvent(input$submit, {
#     saveData(formData())
#     shinyjs::reset("form")
#     shinyjs::hide("form")
#   })

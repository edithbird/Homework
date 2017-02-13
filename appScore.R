#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#    
#    http://shiny.rstudio.com/
# runApp()
# To get rid of error code options(shiny.error=browser)
# Authenticate in console rsconnect::setAccountInfo(name='christineiyer', token='2E312FF16FB5FD4C15781E041BCE57E3', secret='6YUxD6WUwnZ7a/wpq6E0u3XRTabc+aYxiSj/Ad0T')
# Deploy library(rsconnect)
# rsconnect::deployApp('path/to/your/app') Find path under session

# Token infofound here:   https://www.shinyapps.io/admin/#/tokens

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel(
     h1("Score Keeper")),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         numericInput("Round1",
                     "R1Points:",
                     min = 1,
                     max = 50,
                     value = 30),
     numericInput("Round2",
                   "R2Points:",
                   min = 1,
                   max = 50,
                   value = 30),
     numericInput("Round3",
                  "R3Points:",
                  min = 1,
                  max = 50,
                  value = 30), 
     numericInput("Round4",
                  "R4Points:",
                  min = 1,
                  max = 50,
                  value = 30), 
     numericInput("Round5",
                  "R5Points:",
                  min = 1,
                  max = 50,
                  value = 30), 
     numericInput("Round6",
                  "R6Points:",
                  min = 1,
                  max = 50,
                  value = 30), 
     numericInput("Round7",
                  "R7Points:",
                  min = 1,
                  max = 50,
                  value = 30), 
     numericInput("Round8",
                  "R8Points:",
                  min = 1,
                  max = 50,
                  value = 30)
    
      
   ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      Round1 <- seq(min(x), max(x), length.out = input$Round1)
      Round2 <- seq(min(x), max(x), length.out = input$Round2)
      Round3 <- seq(min(x), max(x), length.out = input$Round3)
      Round4 <- seq(min(x), max(x), length.out = input$Round4)
      Round5 <- seq(min(x), max(x), length.out = input$Round5)
      Round6 <- seq(min(x), max(x), length.out = input$Round6)
      Round7 <- seq(min(x), max(x), length.out = input$Round7)
      Round8 <- seq(min(x), max(x), length.out = input$Round8)
     
      # draw the histogram with the specified number of bins
      hist(x, breaks = Round1, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


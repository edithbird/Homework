#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
#this adds the bootstrap template  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href =
                "bootstrap.css")), 
  
  headerPanel("Geyser"),
  
  sidebarPanel(
    sliderInput("bins",
                "Number of bins:",
                min = 1,
                max = 50,
                value = 30)
  ),
  
  navbarPage(
    
    # theme = "cerulean",  # <--- To use a theme, uncomment this
    "shinythemes",
    tabPanel("Navbar 1",
             sidebarPanel(
               fileInput("file", "File input:"),
               textInput("txt", "Text input:", "general"),
               sliderInput("slider", "Slider input:", 1, 100, 30),
               tags$h5("Deafult actionButton:"),
               actionButton("action", "Search"),
               
               tags$h5("actionButton with CSS class:"),
               actionButton("action2", "Action button", class = "btn-primary")
    
    
  ),
  
  
  
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  ))))

travel <- read.csv("data/Travel.csv")
# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      VMT    <- travel[, 4] 
      bins <- seq(min(VMT), max(VMT), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(VMT, breaks = bins, col = 'maroon', border = 'purple')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


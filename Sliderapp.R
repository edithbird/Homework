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
   
   # Application title
   titlePanel("Plot"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         numericInput("numeric",
                     "How many numbers should we plot?",
                     value = 1000,
                     min = 1,
                     max = 50,
                     step = 1), 
         
         
         
         sliderInput("sliderX", "Pick minimum and maximum X values", -100, 100, value = c(-50, 50)),
         sliderInput("sliderY", "Pick minimum and maximum Y values", -100, 100, value = c(-50, 50)),
         checkboxInput("show_xlab", "Show/Hide X axis label", value = TRUE), 
         checkboxInput("show_ylab", "Show/Hide Y axis label", value = TRUE), 
         checkboxInput("show_title", "Show/Hide Title")
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        h3("Graph of Random Points"), 
         plotOutput("plot1")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$plot1 <- renderPlot({
     set.seed(2017-02-25)
     number_of_points <- input$numeric
     minX <- input$sliderX[1]
     maxX <- input$sliderX[2]
     minY <- input$sliderY[1]
     maxY <- input$sliderY[2]
     dataX <- runif(number_of_points, minX, maxX)
     dataY <- runif(number_of_points, minY, maxY)
     xlab <- ifelse(input$show_xlab, "X Axis", "")
     ylab <- ifelse(input$show_ylab, "Y Axis", "")
     main <- ifelse(input$show_title, "Title", "")
     plot(dataX, dataY, xlab = xlab, ylab = ylab, main = main, xlim = c(-100, 100), ylim = c(-100, 100), col = "blue")
      
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


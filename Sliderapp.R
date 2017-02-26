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
         numericInput("numeric1",
                     "Round 1 Score",
                     value = 100,
                     min = 1,
                     max = 100,
                     step = 1), 
         numericInput("numeric2",
                      "Round 2 Score",
                      value = 100,
                      min = 1,
                      max = 100,
                      step = 1),
         numericInput("numeric3",
                      "Round 3 Score",
                      value = 100,
                      min = 1,
                      max = 100,
                      step = 1)
         # 
         # 
         # sliderInput("sliderX", "Pick minimum and maximum X values", -100, 100, value = c(-50, 50)),
         # sliderInput("sliderY", "Pick minimum and maximum Y values", -100, 100, value = c(-50, 50)),
         # checkboxInput("show_xlab", "Show/Hide X axis label", value = TRUE), 
         # checkboxInput("show_ylab", "Show/Hide Y axis label", value = TRUE), 
         # checkboxInput("show_title", "Show/Hide Title")
         
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
     #set.seed(2017-02-25)
     #number_of_points <- input$numeric
     
     R1 <- input$numeric1
     R2 <- input$numeric2
     R3 <- input$numeric3
     dfAll <- data.frame(R1, R2, R3)
  barplot(dfAll, ~R1 ~R2 ~R3)
      
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


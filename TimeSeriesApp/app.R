setwd("/Users/Chris Iyer/Documents/TimeSeriesApp/data/")
air <- read.csv("AirTravel.csv", header = TRUE, stringsAsFactors = FALSE)
wine <- read.csv("AustralianWines.csv", header = TRUE, stringsAsFactors = FALSE)
travel <- read.csv("travel.csv", header = TRUE, stringsAsFactors = FALSE)
sales <- read.csv("DeptStoreSales.csv", header = TRUE, stringsAsFactors = FALSE)
souvenir <- read.csv("SouvenirSales.csv", header = TRUE, stringsAsFactors = FALSE)
amtrak <- read.csv("Amtrak.csv", header = TRUE, stringsAsFactors = FALSE)
shampoo <- read.csv("ShampooSales.csv", header = TRUE, stringsAsFactors = FALSE)
library(shiny)
library(dplyr)

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Time Series"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput("dataset",
                    "Select a Dataset:",
                    choices = c("air", "wine", "travel", "sales", 
                                "souvenir", "amtrak", "shampoo")), 
        numericInput("obs", "Number of observations to view", 10)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tableOutput("table"),
        plotOutput("plot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  datasetInput <- reactive({
    switch(input$dataset, "air" = air, 
           "wine" = wine, 
           "travel" = travel, 
           "sales" = sales, 
           "souvenir" = souvenir, 
           "amtrak" = amtrak)
   })
  
  output$table <- renderTable({
    datasetInput()
    
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


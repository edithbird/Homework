

library(shiny)
fields <- fields <- c("name1", "sum1", "name2", "sum")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  
  
  
  DT::dataTableOutput("responses", width = 300), tags$hr(),
  textInput("name", "Name", ""),
  checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
  sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
  actionButton("submit", "Submit")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
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
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


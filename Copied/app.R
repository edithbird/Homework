fields1 <- c("name", "used_shiny", "r_num_years")

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
  DT::dataTableOutput("responses1", width = 300), tags$hr(),
  textInput("name", "Name", ""),
  checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
  sliderInput("r_num_years", "Number of years using R",
              0, 25, 2, ticks = FALSE),
  actionButton("submit", "Submit")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  saveData <- function(data1) {
    data1 <- as.data.frame(t(data1))
    if (exists("responses1")) {
      responses1 <<- rbind(responses1, data1)
    } else {
      responses1 <<- data1
    }
  }
  
  loadData <- function() {
    if (exists("responses1")) {
      responses1
    }
  }
   
  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data1 <- sapply(fields1, function(x) input[[x]])
    data1
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  # Show the previous responses1
  # (update with current response when Submit is clicked)
  output$responses1 <- DT::renderDataTable({
    input$submit
    loadData()
  })   
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


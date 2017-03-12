#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#fileds for the final data table that is being built
fields <- c("name", "used_shiny", "r_num_years")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
  DT::dataTableOutput("responses", width = 300), tags$hr(),
  
  #Defining the three fields of the data table
  #Box to enter name
  textInput("name", "Name", ""),
  #Checkbox with yes or no
  checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
  #Slider for years used shiny
  sliderInput("r_num_years", "Number of years using R",
              0, 25, 2, ticks = FALSE),
  
  #submit button
  actionButton("submit", "Submit"))

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
 #Data table responses given the variable name data 
  saveData <- function(data) {
    data <- as.data.frame(t(data))
    if (exists("responses")) {
      responses <<- rbind(responses, data)
    } else {
      responses <<- data
    }
  }
  
  #Load the data
  loadData <- function() {
    if (exists("responses")) {
      responses
    }
  }

  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  # Show the previous responses
  # (update with current response when Submit is clicked)
  output$responses <- DT::renderDataTable({
    input$submit
    loadData()
  })    
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


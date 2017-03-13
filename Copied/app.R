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
  
  outputDir <- "responses1"
  
#Ex 2: Local file system  
  saveData <- function(data1) {
   
    
    data <- t(data)
    # Create a unique file name
    fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
    # Write the file to the local system
    write.csv(
      x = data,
      file = file.path(outputDir, fileName), 
      row.names = FALSE, quote = TRUE
    )
    
  }
  
  
#Ex 2: Local file system  
  loadData <- function() {
    # Read all the files into a list
    files <- list.files(outputDir, full.names = TRUE)
    data1 <- lapply(files, read.csv, stringsAsFactors = FALSE) 
    # Concatenate all data1 together into one data1.frame
    data1 <- do.call(rbind, data1)
    data1
  }
# Example 1:This is the code chunk that saves it locally on the app 
# and when the app is restarted, it starts without the data.    
    # data1 <- as.data.frame(t(data1))
    # if (exists("responses1")) {
    #   responses1 <<- rbind(responses1, data1)
    # } else {
    #   responses1 <<- data1
    # }
   
  
  
# Example 1"This is the code chunk that saves it locally on the app 
# and when the app is restarted, it starts without the data  
  # loadData <- function() {
  #   if (exists("responses1")) {
  #     responses1
  #   }
  # }
   
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


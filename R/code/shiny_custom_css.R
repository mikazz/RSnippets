

library(shiny)

# Define UI for app that draws a histogram ----
ui <- shinyUI(fluidPage(

  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
    "))
  ),
    
  headerPanel(
    h1("New Application", 
      style = "font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;")),
  
  sidebarPanel(
    sliderInput("obs", "Number of observations:", 
                min = 1, max = 1000, value = 500)
  ),
  
  mainPanel(plotOutput("distPlot"))
))



# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({

    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

    })

}

# Create Shiny app ----
shinyApp(ui = ui, server = server)


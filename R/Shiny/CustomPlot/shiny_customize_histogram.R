#https://shiny.rstudio.com/articles/css.html

# R Executable
# C:\Program Files\R\R-3.5.1\bin\R.exe

# ‘C:/Users/odziemczm/Documents/R/win-library/3.5’
# C:\Users\odziemczm\AppData\Local\Temp\RtmpqWB9xS\downloaded_packages

# gg z wykopu: 47028066

library(shiny)
library(shinythemes)

# UI.R ----------------------------------------------------------------------------------------------------

# Define UI for app that draws a histogram ----
ui <- fluidPage(

  # App title ----
  titlePanel("Hello Shiny!"),
  theme = shinytheme("darkly"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
        label = "Number of bins:",
        min = 1,
        max = 50,
        value = 30
        )
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "distPlot")

    )
  )
)

# SERVER.R ----------------------------------------------------------------------------------------------------

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


    # par() function can be used to change the color, font style and size for the graph titles.
    # The modifications done by the par() function are called permanent modification 
    # because they are applied to all the plots generated under the current R session."
	 par(bg = 'grey12',
      family = 'sans')

    # axes - show axes
    # labels (TRUE) - show values on columnes / frequency count labels
    # breaks - type of ticks/separators on axes
    # col - colum colors
    # col.main - main title color
    # col.axis - axes numbers color
    # col.lab - axes title color
    # col.sub - axes subtitle color
    # border - column border color
    # par(bg) - background
    # col.ticks - ticks color on scale
    # box(col) - color of box outside the plot 

    hist(x,
      axes=FALSE,
      breaks = bins,
		  col = "red",
      col.lab = "white",
      col.sub = "green",
      border = "grey12",
      sub="Live",
      main = NULL,
      col.main = "white",
      xlab = "Waiting time to next eruption (in mins)",
      ylab = NULL,
      labels = TRUE,
      )
      
    box(col = 'grey12')

    # Axes customization
    #axis(1, col = 'grey12', col.axis = 'white', col.ticks = 'grey12', font = 2, labels = FALSE)
    #axis(2, col = 'grey12', col.axis = 'white', col.ticks = 'grey12', font = 2, labels = FALSE)
    
    })

}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
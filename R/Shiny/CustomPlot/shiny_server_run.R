#SERVER

#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    prep <-  filter(iris, Species == input$speciesSelector)
    reg <- input$regr
    ggplot(data = prep, mapping = aes(x= prep$Sepal.Width, y = prep$Sepal.Length, color = prep$Species)) + geom_point() + facet_grid(cols = vars(prep$Species)) + theme_bw() +labs(title = "Iris data viz") + stat_smooth(method = reg)

  })

})


#UI

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Iris data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("speciesSelector", "Species to show:",
                         c("Setosa" = "setosa",
                           "Versicolor" = "versicolor",
                           "Virginica" = "virginica")),
     radioButtons("regr", "Species to show:",
                         c("lm" = "lm",
                           "loess" = "loess",
                           "glm" = "glm"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
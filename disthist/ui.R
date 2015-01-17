library(shiny)

shinyUI(fluidPage(
  titlePanel("Obs. v. Exp. interval distances"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("CpG Islands", "GWaS SNPs", 
                    "L1M5 elements", "Exons")),
      sliderInput("sample_size", 
                  "Number of intervals to sample.", 
                   value = 10000,
                   min = 1, 
                   max = 100000),
      sliderInput("max_dist", 
                  "Max. distance", 
                   value = 10000,
                   min = 1000, 
                   max = 1000000)
    ),
    mainPanel(plotOutput("distanceHist"))
  )
))


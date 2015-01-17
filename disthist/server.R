library(shiny)
source("helpers.R")


options(shiny.maxRequestSize=500*1024^2)

shinyServer(function(input, output) {

  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "CpG Islands" = "data/cpg.sorted.bed", 
           "GWaS SNPs" = "data/gwas.bed",
           "L1M5 elements" = "data/L1M5.sorted.merged.bed",
           "Exons" = "data/exons.sorted.bed")
  })
  
  output$distanceHist <- renderPlot({
      dataset <- datasetInput()
    
      dists <- distances(dataset, input$sample_size, opt.string="")
      d <- dists[,1]
      d1 <- d<input$max_dist
      
      shuf  <- shuf(dataset, input$sample_size, opt.string="")
      s <- shuf[,1]
      s1 <- s<input$max_dist 
      
      dh <- hist(d[d1], breaks=50)
      sh <- hist(s[s1], breaks=50)
      
      plot(dh, col=rgb(0,0,1,1/4), xlab="Distances", main="Histogram of interval distances")  # first histogram
      plot(sh, col=rgb(1,0,0,1/4), add=T)  # second
      legend("topright", inset=.05,
             c("observed","shuffled"), fill=c(rgb(0,0,1,1/4), rgb(1,0,0,1/4)), horiz=TRUE)
  })
})
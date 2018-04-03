library(shiny)
server <- function(input, output, session) {}
shinyApp(ui = ui, server = server)

data("faithful")
head(faithful)
    ui <- fluidPage (
    titlePanel("Old Faithful Eruptions"),
    sidebarLayout (
    sidebarPanel (
    sliderInput(inputId = "bins", label = "Number of bins:", min = 5, max = 20, value = 10)
    ),
    mainPanel (
    plotOutput(outputId = "distPlot")
    )
    )
    )
    print("ui")

server <- function(input, output)
    output$distPlot <- renderPlot({
      x <- faithful$waiting
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = heat.colors(10, alpha = 1), border = "white",
           xlab = "Waiting time to next eruption (mins)",
           main = "Histogram of waiting times")
    })
mainPanel(
  plotOutput(outputId = "distPlot"), 
  p("Going somewhere"),
  p("New Paragraph", style = "font-family: 'times'; font-si16pt"),
  strong("Text"),
  em("em(Text)")
)
mainPanel(
  plotOutput(outputId = "distPlot"), 
  img(src = "IMG_2019.jpg", height = 170, width = 296),
  p("humans beware")
)


server <- function(input, output, session) { 
  
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = heat.colors(20, alpha = 1), border = "white",
         xlab = "Waiting time to next eruption (mins)",
         main = "Histogram of waiting times")
  })
}
shinyApp(ui = ui, server = server)
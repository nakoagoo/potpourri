library(shiny)

ui <- fluidPage( #  Hint: Style rule #8
  titlePanel("Old Faithful Eruptions"), #  The title of our app goes here
  sidebarLayout( #  Sidebar layout with spaces for inputs and outputs
    sidebarPanel( #  for inputs
      sliderInput(inputId = "bins", #  Bins for our inputs
                  label = "Number of bins:",
                  min = 5,
                  max = 20,
                  value = 10)
    ),
    mainPanel(
      plotOutput(outputId = "distPlot"), #  We want to output a histogram
      img(src = "geyser.jpg", height = 170, width = 296),
      p("bison beware")
    )
  )
)


server <- function(input, output) { 
  # Define server logic required to draw a histogram
  # Calling renderPlot tells Shiny this plot is
  # 1. reactive, and will auto re-execute when inputs (input$bins) change
  # 2. the output type we want
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1) # Hint: Style rule #5
    hist(x, breaks = bins, col = heat.colors(input$bins, alpha = 1), border = "white",
         xlab = "Waiting time to next eruption (mins)",
         main = "Histogram of waiting times")
  })
}

shinyApp(ui = ui, server = server)
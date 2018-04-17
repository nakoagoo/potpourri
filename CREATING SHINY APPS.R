# It's critical that app.R is saved in its own special folder separate from other .R files 
# (unless those other files are used by your app). Don't confuse Shiny!

library(shiny)
ui <- fluidPage()
server <- function(input, output, session) {}
shinyApp(ui = ui, server = server)

# After saving this ^, R Studio will recognize that this is a Shiny app.
# Green triangle + Run  will appear on the righthand side of your app.R script in R Studio. Click it.
# Not much happens, as it's an empty app, but you'll see something like "Listening on...".
# Click the red button or Escape to exit.
# You can also run the app with runApp("appP3.R").




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














library(dplyr)
library(ggplot2)
bcl <- read.csv('bclData.csv', stringsAsFactors = F)
server <-  function(input, output, session) {
  print(str(bcl))
}
fluidPage("BC Liquor Store", "prices")
shinyApp(ui = ui, server = server)



server <-  function(input, output, session) {
  print(str(bcl))
}
fluidPage("BC Liquor Store", "prices")
fluidPage(
  h1("BC liquor product app"), "BC", "Liquor", br(), "Store", strong("prices") #  Hint: Style rule #4
)
fluidPage(
  h1("BC Liquor Product App"), "BC", "Liquor", br(), "Store", strong("prices")
)


mainPanel("DATA")
sidebarLayout(
  SidebarPanel("INPUTS"),
  print(ui),
  
  
  
  
  fluidRow(
    titlePanel("BC Liquor Store Prices"),
    column(width=4,
           column(width = 3, offset = 2),
           "Format Types"
    )
  )
)


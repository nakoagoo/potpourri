library(dplyr)
library(ggplot2)
library(shiny)
bcl <- read.csv('bclData.csv', stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store Prices"),
  sidebarLayout(
    sidebarPanel(sliderInput("priceInput", "Price",
             min = 0, max = 100, value = c(25,40), pre = "$"),
  radioButtons("typeInput", "Product type",
             choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
             selected = "WINE"),
  uiOutput("countryOutput")),
mainPanel(
  plotOutput("coolplot"),
  br(), br(),
  tableOutput("results")
    )
  )
)

server <- function(input, output, session) {
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)), selected = "CANADA")
  }) 
  
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    } # Hint: Style rule #6
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram()
  })
  
  
  output$results <- renderTable({
    filtered <-
      bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput)
    filtered
  })
}
shinyApp(ui = ui, server = server)

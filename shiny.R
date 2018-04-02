## 4/3: Collaboration mini project I: shiny
## shiny tutorial adapted from various sites, primarily http://shiny.rstudio.com/tutorial/ and https://www.r-bloggers.com/building-shiny-apps-an-interactive-tutorial/ 
## Package developed by: Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2017). 
## shiny: Web Application Framework for R. R package version 1.0.5. https://CRAN.R-project.org/package=shiny

### PART I ###

### Installation ###

install.packages('shiny')
library(shiny)
#  Launch a pre-built example app in R Studio and (if you want) your web browser
runExample('11_timer') #  All good? Keep going...

### Create a shiny app template (an empty shiny app), method #1 ###

# DO NOT!! run the following script- instead, copy and paste into a new R script. 
# It should be saved as: "app.R". 
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

### Create a shiny app template, method #2 ###

# You can also create a new Shiny app using R Studio's menu. 
# File > New Project > New Directory > Shiny Web Application
# RStudio will create a new folder and initialize a simple Shiny app there.
# There won't be an "app.R" file, but you will see ui.R (all code assigned to the ui object, as in the script above, goes here) and server.R (same, pertaining to the server object).


### PART II ###

bcl <- read.csv('bclData.csv') # Briefly explore the data.


## Read in the data

# In 'app.R' (or whatever you named it), type the following code, do NOT just run it here- won't work:
# Place this line in your app as the second line, just after calling the library. 

bcl <- read.csv('bclData.csv', stringsAsFactors=F) #  Hint: Style rule #5


## Ensure the app can read your data

# Replace the server function with the following:
  
server = function(input, output, session) { #  Hint: Style rule #8
  print(str(bcl))
  }


## Add elements to the UI

# Here, we'll render the text by placing some strings inside fluidPage().

fluidPage("BC Liquor Store", "prices")

# Save and run the app. Looking good? Add a few more strings (aka, column headers from the worksheet).
# Run the app again.

## Format the text in the UI

fluidPage(
h1("BC liquor product app"), "BC", "Liquor", br(), "Store", strong("prices") #  Hint: Style rule #4
)

?builder #  Experiment with some of the tags listed here (i.e., replace h1 with h4, etc.) and run the app.

# Overwrite your fluidPage() text with the following:

fluidPage(
  titlePanel("BC Liquor Store prices")
)

## Add some structure

# When you run the app, you may notice it looks a little messy. sidebarLayout() will help.
# Inputs will be on the left, results will be in the main panel.
# Paste this inside fluidPage(), after titlePanel(). Don't forget a , after titlePanel(). 

sidebarLayout(
  sidebarPanel("our inputs will go here"),
mainPanel("the results will go here")
)

# Add some UI into sidebarPanel and mainPanel, run the app, notice the changes.
# All UI functions are HTML wrappers in diguise. Shiny lets you run these without prior knowledge of HTML.
# In your R console, run the following:

print (ui) #  Hint: Style rule #5

# You can also control the minutiae of the display in fluidPage(). 

?column

# Replace fluidPage() with the following:

fluidRow(
  titlePanel("BC Liquor Store prices"),
  column(width = 4,
  column(width = 3, offset = 2,
         "3 offset 2"
)))


## Add a numbers widget

?sliderInput

# Place the code for the slider input inside sidebarPanel().
# These values are from the price data in the .csv.
sliderInput("priceInput", "Price", 
            min = 0, max = 100;value = c(25, 40), pre = "$") #  Hint: Style rule #9

## Add buttons

?radioButtons

# Add this input code inside sidebarPanel(), after the previous input:

radioButtons("typeInput", "Product type",
  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
  selected = "WINE")

## Create a list of selected inputs

selectInput("countryInput", "Country", choices = c("CANADA", "FRANCE", "ITALY"))
  
## Output a plot and a table summary of results

# Show the results in a plot using plotOutput(). Paste this text in mainPanel():

plotOutput("cool_plot") #  Hint: Style rule #2
tableOutput("results")

# Now that we've coded two output types, we need to tell Shiny what kind of graphics to display.
?renderPlot()

output$coolplot <- renderPlot({
  plot(input$priceInput[1])
  }) #  Run the app, see what this looks like.

# Time to add in ggplot():

library(ggplot2)
output$coolplot <- renderPlot({
  ggplot(bcl, aes(Alcohol_Content)) +
  geom_histogram()
  })

# Why did we do this? We have to 1) assign our output object to a list and 2) build the object with renderPlot.

# We also want to add code for our table:
library(dplyr) #  We are filtering some of the data using this package
output$results <- renderTable({
  filtered <-
  bcl %>%
  filter(Price >= input$priceInput[1],
  Price <= input$priceInput[2],
  Type == input$typeInput,
  Country == input$countryInput)
  filtered
  })

# Run the app and see how it looks.

## Reactivity in Shiny

# Add this to your code (modify the server function):
server <- function(input, output, session) {
  filtered <- reactive({
  bcl %>%
  filter(Price >= input$priceInput[1],
  Price <= input$priceInput[2],
  Type == input$typeInput,
  Country == input$countryInput)
  })

output$coolplot <- renderPlot({
  ggplot(filtered(), aes(Alcohol_Content)) +
  geom_histogram()
  })

output$results <- renderTable({
  filtered()
  })
}

# We've just created a dependency tree above.
# This tells Shiny where to look/when to react to variable value changes.
### PART III ###



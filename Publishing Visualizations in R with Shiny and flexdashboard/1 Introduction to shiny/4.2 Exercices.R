#2.2.8

#Exercice 1

library(shiny)

ui <- fluidPage(
  textInput("name", "", "Your name"),
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)

#Exercice 2

library(shiny)

ui <- fluidPage(
  sliderInput("date", "When should we deliver", min = as.Date("2020-09-16"), max = as.Date("2020-09-23"), value = as.Date("2020-09-17"))
  )

server <- function(input, output, session) {
  
}

shinyApp(ui, server)

?sliderInput

#Exercice 3

library(shiny)

ui <- fluidPage(
  sliderInput("slider", "Select Value", 
              min = 0, max = 100, value = 0, step = 5,
              animate = animationOptions(interval = 1000, loop = TRUE))
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)


#Exercice 4

# demoing group support in the `choices` arg
shinyApp(
  ui = fluidPage(
    selectInput("state", "Choose a state:",
                list(`East Coast` = list("NY", "NJ", "CT"),
                     `West Coast` = list("WA", "OR", "CA"),
                     `Midwest` = list("MN", "WI", "IA"))
    ),
    textOutput("result")
  ),
  server = function(input, output) {
    output$result <- renderText({
      paste("You chose", input$state)
    })
  }
)


#2.3.5 Exercises

#Exercice 1

#Which of textOutput() and verbatimTextOutput() should each of the following
#render functions be paired with?




# a)renderPrint(summary(mtcars)) 
# 
# b) renderText("Good morning!")
# 
# c) renderPrint(t.test(1:5, 2:6))
# 
# d) renderText(str(lm(mpg ~ wt, data = mtcars)))


#Answers

#a) verbatimTextOutput()

#b) textOutput() 

#c) verbatimTextOutput()

#d) verbatimTextOutput() 


#Exercice 2

# Re-create the Shiny app from Section 2.3.3,
#this time setting height to 300px and width to 700px.

#Set the plot “alt” text so that a visually impaired user 
#can tell that its a scatterplot of five random numbers.

library(shiny)

ui <- fluidPage(
  plotOutput("plot", width = "700px", height = "300px")
)
#alt is meant to give the plot a desription in case it can't load
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96, alt = "scatterplot of five random numbers")
}

shinyApp(ui, server)


#Exercice 3

# Update the options in the call to renderDataTable() below so that 
# the data is displayed, but all other controls are suppress 
# (i.e. remove the search, ordering, and filtering commands). 
# You’ll need to read ?renderDataTable and review the options 
# at https://datatables.net/reference/option/.

library(shiny)


#https://datatables.net/manual/options

#?renderDataTable
# shiny::renderDataTable()` is deprecated as of shiny 1.8.1.
# Please use `DT::renderDT()` instead.



ui <- fluidPage(
  dataTableOutput("table")
)

server <- function(input, output, session) {
  output$table <- renderDataTable(mtcars, options = list(pageLength = 5, searching = FALSE, ordering = FALSE, filtering = FALSE))
}

shinyApp(ui, server)


#Exercice 4
#Alternatively, read up on reactable, and convert the above app to use it instead.

library(shiny)
library(reactable)


ui <- fluidPage(
  reactableOutput("table")
)

server <- function(input, output, session) {
  output$table = renderReactable(reactable(mtcars))
}

shinyApp(ui, server)





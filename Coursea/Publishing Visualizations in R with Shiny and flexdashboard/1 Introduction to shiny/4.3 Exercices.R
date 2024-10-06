#Exercice 1
#Given this UI:

library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

# Fix the simple errors found in each of the three server functions below. First 
# try spotting the problem just by reading the code; then run the code to make
# sure you’ve fixed it.


server1 <- function(input, output) {
  output$greeting <- renderText(paste0("Hello ", input$name))
}


shinyApp(ui, server1)

#################

server2 <- function(input, output) {
  greeting <- reactive(paste0("Hello ", input$name))
  output$greeting <- renderText(greeting())
}

shinyApp(ui, server2)


#############

server3 <- function(input, output) {
  output$greeting <- renderText(paste0("Hello ", input$name))
}

shinyApp(ui, server3)



#Exercice 2
#Draw the reactive graph for the following server functions:

server1 <- function(input, output, session) {
  c <- reactive(input$a + input$b)
  e <- reactive(c() + input$d)
  output$f <- renderText(e())
}


a+b>c
c+d>e>f
    




server2 <- function(input, output, session) {
  x <- reactive(input$x1 + input$x2 + input$x3)
  y <- reactive(input$y1 + input$y2)
  output$z <- renderText(x() / y())
}


x1+x2+x3>x
y1+y2>y
x/y>z


server3 <- function(input, output, session) {
  d <- reactive(c() ^ input$d)
  a <- reactive(input$a * 10)
  c <- reactive(b() / input$c) 
  b <- reactive(a() + input$b)
}

a*10>a>b
b+a>b>c
b/c>c
c**d>d


#Exercice 3
#Why this code fail?
#Why are range() and var() bad names for reactive?

var <- reactive(df[[input$var]])
range <- reactive(range(var(), na.rm = TRUE))


#Because var and range are two functions in R 


?fluidPage



#Exercise 1 of 1.8 https://mastering-shiny.org/basic-app.html


library(shiny)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")  
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name)
  })
}

shinyApp(ui, server)

#Exercise 2

library(shiny)

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  "then x times 5 is",
   textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * 5
  })
}

shinyApp(ui, server)

#Exercise 3

library(shiny)

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "and y is", min = 1, max = 50, value = 30),
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    input$x * input$y
  })
}

shinyApp(ui, server)


#Exercise 4


library(shiny)

ui <- fluidPage(
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)

server <- function(input, output, session) {
  prod = reactive({input$x*input$y})
  
  output$product <- renderText({ 
    prod()
  })
  
  output$product_plus5 <- renderText({ 
    prod() + 5
  })
  
  output$product_plus10 <- renderText({ 
    prod() + 10
  })
}

shinyApp(ui, server)


#Exercise 5

library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summmary <- renderPrint({
    summary(dataset())
  })
  output$table <- renderTable({
    dataset()
  }, res = 96)
}

shinyApp(ui, server)

#Exercise 5 bis

library(shiny)
library(ggplot2)

ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput('summary'),
  #Reactively select x and y in function of user's selected database
  uiOutput('x_ui'),
  uiOutput('y_ui'),
  plotOutput('plot')
)

server <- function(input, output, session) {
  
  #Reactive variable for chosen dataset
  dataset = reactive({
    get(input$dataset, "package:ggplot2")
  })
  
  #datast summary
  output$summary = renderPrint({
    summary(dataset())
  })
  
  #Observe dataset changes to update x and y choices
  observeEvent(input$dataset, {
               data = dataset()
               cols = names(data)
               updateSelectInput(session, 'x', choices = cols)
               updateSelectInput(session, 'y', choices = cols)
  })             
  #x     
  output$x_ui = renderUI({
    selectInput("x", "X", choices = names(dataset()))
  })
  
  #y
  output$y_ui = renderUI({
    selectInput("y", "Y" ,choices =names(dataset()))
  })
  
  #Plot data
  output$plot = renderPlot({
    data = dataset()
    x_var = input$x
    y_var = input$y
    ggplot(data, aes_string(x = x_var, y = y_var)) +
      geom_point() +
      labs(title = paste("Plot of", input$x, "vs", input$y), x = input$x, y = input$y)
   }, res = 96)
}
  


shinyApp(ui, server)






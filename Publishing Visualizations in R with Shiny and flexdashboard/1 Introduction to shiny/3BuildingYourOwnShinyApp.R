library(shiny)



ui = fluidPage(
  titlePanel('My App'),
  textInput(inputId="my_text", label="enter some text"),
  textOutput(outputId='print_text')
)



server = function(input, output){
  output$print_text = renderText(input$my_text)
}

shinyApp(ui=ui, server=server)




View(wp)
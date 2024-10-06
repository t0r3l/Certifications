library(shiny)
library(tidyverse)
library(plotly)
library(DT)

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))

dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))

dat<-drop_na(dat)

#####Make your app

ui <- navbarPage(
  title= "My Application",
  #Page I
  tabPanel("Page 1",
           sidebarLayout(
             sidebarPanel(
               sliderInput(inputId = "slider",
                           label = "Select Five Point Ideology (1=Very liberal, 5=Very conservative)",
                           min=1,
                           max=5,
                           value=3)
               ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Tab1", plotOutput("plot_I1")),
                   tabPanel("Tab2", plotOutput("plot_I2"))
                            )
                 )
             )
  ),
  
  #Page II
  tabPanel("Page 2",
           sidebarLayout(
             sidebarPanel(
               checkboxGroupInput(
                 inputId = "select_gender",
                 label = "Select Gender",
                 choiceNames = c("Man", "Woman"),
                 choiceValues = c(1, 2)
               )
             ),
             mainPanel(plotlyOutput("plot_II"))
             )
           ),
  
  #Page III
  tabPanel("Page 3",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "select_region", 
                             label = "Select Region",
                             c(1:4)
                             )
               ),
               mainPanel = (
                 dataTableOutput("table")
               )
    )
  )
)

server<-function(input,output){
  #Page I
  dat_I = reactive(filter(dat, ideo5 == input$slider))
  ##Tab 1
  output$plot_I1 = renderPlot(
     ggplot(dat_I(), aes(x = pid7)) +
             geom_bar() +
       xlab("7 Point Party ID, 1=Very D, 7=Very R")
   )
  ##Tab 2
  output$plot_I2 = renderPlot(
    ggplot(dat_I(), aes(x = CC18_308a)) +
      geom_bar() +
      xlab("Trump Support")
    )
  
  #Page II
  dat_per_gender= reactive({
    filter(dat, gender == input$select_gender)
  })
  output$plot_II = renderPlotly({
   if (is.null(input$select_gender) == TRUE) {
      plot = ggplot() +
               xlab("educ") +
               ylab("pid7")
    }else{
     plot = ggplot(dat_per_gender(), aes(x = educ, y = pid7)) +
              geom_jitter() +
              geom_smooth(method = "lm")
    }
   #ggplotly converts ggplot objects in plotly objects
   ggplotly(plot)
   })
  
  
   #Page III
   dat_per_region = reactive({filter(dat, region == input$select_region)})
   output$table = renderDataTable({
     dat_per_region()
   })
  
    }
  
  #Hint: when you make the data table on page 3, you may need to adjust the
  #height argument in the dataTableOutput function. Try a value of height=500
  

shinyApp(ui,server)
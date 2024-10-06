library(shiny)
library(tidyverse)

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5"))



ui<- fluidPage(
  
  sidebarLayout(
      sliderInput("ideology", 
                  "Select Five Point Ideology (1=Very liberal, 5=Very conservative)", 
                  min = 1, 
                  max = 5, 
                  value = 3,
                  width = "400px",
      ),
      mainPanel(
        plotOutput("ideology_vs_party"),
        width = "800",
      
    )
  )
)


server<-function(input,output){
  output$ideology_vs_party = renderPlot({
    ggplot( 
      filter(dat, ideo5  == input$ideology),
      aes(x = pid7)
    ) +
      xlab("7 Point Patty ID,=Very D, 7=Very R") +
      geom_bar() +
      theme(axis.title.x = element_text(size=15),
            axis.title.y = element_text(size=15))
  })
}

shinyApp(ui,server)



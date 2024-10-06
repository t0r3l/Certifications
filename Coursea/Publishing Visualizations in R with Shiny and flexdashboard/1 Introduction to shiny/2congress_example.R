#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#


library(shiny)
library(tidyverse)

setwd("C:/Users/morel/Documents/Library/CodingTime/GitHub/Certifications/Data Visualization & Dashboarding with R Specialization/Module1 Introduction to shiny")

dat = read_csv("2congress.csv")

#Select and rename columns, dwnom stands for DW nominate score: lower the score more the 
#is liberal, higher it is more he is conservative

dat = dat %>% select(c(Congress=congress, Ideology=dwnom1, Party=dem, year))
#changes 1 to democrats and 0 to republican
dat$Party = recode(dat$Party, '1'="Democrat", '0'="Republican")
#drop missing values
dat=drop_na(dat)

col(dat)
#Make a static figure for practice (not displayed as not in the server function)
#1 This plot shows density for all records of nominates
ggplot(dat,
       aes(x=Ideology, color=Party, fill=Party))+
       #alpha is for transparency
       geom_density(alpha=.5)+
       #lim for intervals of nominate score
       xlim(-1.5,1.5)+
       xlab("Ideology - Nominate Score") + 
       ylab("Density")+
       #color inside
       scale_fill_manual(values=c("blue","red")) + 
       #color outside
       scale_color_manual(values=c("blue", "red"))
       
#2 this plot allows to grasp distribution over the congress along time
ggplot(dat,
       aes(x=Ideology, color=Party, fill=Party))+
  #alpha is for transparency
  geom_density(alpha=.5)+
  #lim for intervals of nominate score
  xlim(-1.5,1.5)+
  xlab("Ideology - Nominate Score") + 
  ylab("Density")+
  #color inside
  scale_fill_manual(values=c("blue","red")) + 
  #color outside
  scale_color_manual(values=c("blue", "red")) +
  facet_wrap(~Congress)



#3 Interactive version of the plot allows to see how overlaping between parties
#ideologies progressively disepeared within time
#Interractivity also has the adventage to aloow user to directly jump
#to it's wanted visualisation

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Ideology and congress"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("my_cong",
                        "Congress:",
                        min = 93,
                        max = 114,
                        value = 93)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("congress_distplot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$congress_distplot = renderPlot({
    ggplot(
      #filter will select Congress index based on the ui input
      filter(dat, Congress==input$my_cong),
      aes(x=Ideology, color=Party, fill=Party)) +
      #alpha is for transparency
      geom_density(alpha=.5)+
      #lim for intervals of nominate score
      xlim(-1.5,1.5)+
      xlab("Ideology - Nominate Score") + 
      ylab("Density")+
      #color inside
      scale_fill_manual(values=c("blue","red")) + 
      #color outside
      scale_color_manual(values=c("blue", "red"))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

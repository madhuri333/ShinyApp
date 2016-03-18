#=======================================================================================================
# Best Car for your Trip : Developing Data Products Course Project (ui.R forApp)
# Purpose: Help user choose cost-effective car for their trip based on their budget and requirement
#=======================================================================================================

library(shiny)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
        title = "Car Options for you",
        tabPanel("Car List",
                sidebarLayout(
                        sidebarPanel(
                                helpText("Please let us know about your trip budget and car preference:"),
                                numericInput("dist", "Approx Travel Distance:", 200, min = 1, max = 1500 ),
                                numericInput('price', 'Gasoline Price in the area (in USD):', 2.09, min = 1, max = 5, step=0.01),
                                radioButtons("units", label = h3("Units measured in"),
                                             choices = list("Miles and Gallons" = 1, "Kilometers and Litres" = 2), selected = 1),
                                
                                # radioButtons("price_unit", label = h3("Gasoline Price"),
                                #      choices = list("Per Gallon" = 1, "Per Litre" = 2), selected = 1),
                                numericInput("budget", "Your Gasoline Budget:", 50, min=1, max=1000),
                                checkboxGroupInput("no_cyl", "Number of cylinders:", c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),
                                sliderInput("hp", "Horsepower", min=52, max=335, value=c(52,335), step=10),
                                checkboxGroupInput("trans", "Transmission:", c("Automatic"=0, "Manual"=1), selected = c(0,1))
                        ),
                        mainPanel(
                               dataTableOutput("options")
                        )
                )
        ),

        tabPanel("About us",
                 mainPanel(
                         includeMarkdown("about_us.md")
                )
        ),
        
        tabPanel("Help",
                 mainPanel(
                         includeMarkdown("help.md")
                 )
        )

))


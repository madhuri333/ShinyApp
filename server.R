#=======================================================================================================
# Best Car for your Trip : Developing Data Products Course Project (server.R for App)
# Purpose: Help user choose cost-effective car for their trip based on their budget and requirement
#=======================================================================================================


library(datasets)
library(dplyr)
library(shiny)

# Define server logic required to run the app and display viable options to user
shinyServer(function(input, output) {
        
        output$options <- renderDataTable({
                
                hp_val <- seq(from = input$hp[1], to = input$hp[2], by = 1)
                if(input$units==1){
                        carData <- transmute(mtcars, Car = rownames(mtcars), Miles_Per_Gallon = mpg, 
                                             Gasoline_Cost = input$dist/mpg*input$price,
                                             No_of_Cylinders = cyl, Horsepower = hp, 
                                             Transmission = am)
                }
                else{
                        carData <- transmute(mtcars, Car = rownames(mtcars), Km_Per_Litre = ((mpg*1.61)/3.785), 
                                             Gasoline_Cost = input$dist/((mpg*1.61)/3.785)*input$price,
                                             No_of_Cylinders = cyl, Horsepower = hp, 
                                             Transmission = am)
                }
                carData <- filter(carData, Gasoline_Cost <= input$budget, No_of_Cylinders %in% input$no_cyl, 
                                  Horsepower %in% hp_val, Transmission %in% input$trans)
                carData <- mutate(carData, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
                carData <- arrange(carData, Gasoline_Cost)
                carData
                
        }, options = list(lengthMenu = c(10, 20, 30), pageLength = 10))
        
})

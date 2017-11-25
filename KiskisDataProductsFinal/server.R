#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(shiny)
library(stats)
data("airquality")
shinyServer(function(input, output) {
    a = 117.74857
    b = 83.80175/8.45360
    g = 1/8.45360
    model1 <- lm(Ozone ~ Temp, data = airquality)
    model2 <- nls(Ozone ~ alpha/(1+exp(beta - gamma*Temp)), data = airquality, 
                  start = c(alpha = a, beta = b, gamma = g))
    
    model1pred <- reactive({
        tempInput <- input$sliderTemp
        predict(model1, newdata = data.frame(Temp = tempInput))
    })
    
    model2pred <- reactive({
        tempInput <- input$sliderTemp
        predict(model2, newdata =
                    data.frame(
                        Temp = tempInput
                    ))
    })
    
    
    
    output$plot1 <- renderPlot({
        tempInput <- input$sliderTemp
        
        plot(
            airquality$Temp,
            airquality$Ozone,
            xlab = "Air Ambient Temperature",
            ylab = "Ozone level",
            bty = "n",
            pch = 16,
            xlim = c(58, 105),
            ylim = c(0, 175)
        )
        if (input$showModel1) {
            abline(model1, col = "red", lwd = 2)
        }
        if (input$showModel2) {
            model2lines <- predict(model2, newdata = data.frame(
                Temp = 58:105
            ))
            lines(58:105,
                  model2lines,
                  col = "blue",
                  lwd = 2)
        }
        
        legend(
            "topright",
            c("Linear Model Prediction", "Logistic Model Prediction"),
            pch = 16,
            col = c("red", "blue"),
            bty = "n",
            cex = 1.2
        )
        points(
            tempInput,
            model1pred(),
            col = "red",
            pch = 16,
            cex = 2
        )
        points(
            tempInput,
            model2pred(),
            col = "blue",
            pch = 16,
            cex = 2
        )
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Predicting Ozone Pollution level from Air Temperature"),
    sidebarLayout(
        sidebarPanel(
            p("This page uses the R standard airquality data to 
              build two prediction models for the level of Ozone in the
              atmosphere based on the air temperature.  The first model is a simple
              linear model.  The second model is a logistic model (S-shaped curve) 
              that is computed using a nonlinear least-squares technique.") ,
            p("Choose a temperature to see the level of ozone predicted by each model"),
            sliderInput("sliderTemp", "What temperature is it?", 58, 105, value = 72),
            checkboxInput("showModel1", "Show/Hide Linear Model", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Logistic (S-curve) Model", value = TRUE)
        ),

        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Ozone Level from Linear Model:"),
            h3(textOutput("pred1")),
            h3("Predicted Ozone Level from Logistic (S-curve) Model:"),
            h3(textOutput("pred2"))
        )
    )
))

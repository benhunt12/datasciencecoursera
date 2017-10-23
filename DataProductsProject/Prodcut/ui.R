#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("BMI"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("weight", "Weight", "150"),
      textInput("hFeet", "Height: Feet", "5"),
      textInput("hIn", "Height: Inches", "10"),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("BMI"),
      textOutput("type")
    )
  )
))

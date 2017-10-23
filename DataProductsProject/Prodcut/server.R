#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
  
  calc_BMI <- reactive({
    totHeight <- (as.numeric(input$hFeet) * 12) + as.numeric(input$hIn)
    totWeight <- as.numeric(input$weight)
    BMI <- round(totWeight / (totHeight^2) * 703, 2)
  })
  
  
  BMI_type <- reactive({
    BMI <- calc_BMI()
    if (BMI < 18.5){
      type <- "Underweight"
    }
    else if(BMI >= 18.5 & BMI <= 24.9){
      type <- "Healthy weight"
    }
    else if(BMI > 24.9 & BMI <= 29.9){
      type <- "Overweight"
    }
    else{
      type <- "Obese"
    }
  })
  
  output$BMI <- renderText({
    calc_BMI()
  })
  
  output$type <- renderText({
    BMI_type()
  })
  
  
})

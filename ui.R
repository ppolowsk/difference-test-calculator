library(shiny)

# 
shinyUI(fluidPage(
  
  #  title
  titlePanel("Difference Test Calculator"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "No. of Participants:",
                  min=0, max=100, value=30),
      
      sliderInput("x", "No. correct:",
                  min=0, max=100, value=15),
      
      selectInput("test", "Type of Test", c("Triangle"=1/3, "Paired/Duo-trio"=1/2)),
      
      checkboxInput("sim", "Test for Similarity?"),
      
      conditionalPanel(
        condition = "input.sim == true",
        sliderInput("pd", "Proportion of Distinguishers",
                    min=0, max=100, post=" %", value=50)),
      helpText("Adapted from the Excel sheet described in Sensory Evaluation Techniques, Fifth Edition (2016) by Civille & Carr")
      
     
      
      
      

    
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      conditionalPanel(
        condition = "input.sim == false",
      plotOutput("nullplot"),
      hr(),
      h4("Difference Test Output"),
      strong(textOutput("pvalue")),
      p(textOutput("explan")),
      hr()
      ),
      conditionalPanel(
        condition = "input.sim == true",
        plotOutput("nullplotsim"),
        hr(),
        h4("Similarity Test Output"),
        strong(textOutput("pvaluesim")),
        strong(textOutput("power")),
        p(textOutput("explansim")),
        hr()
      )
      #p("And a quick reminder as to what alpha and beta signify..."),
      #img(src="reminder.png")
  
    )
  )
))
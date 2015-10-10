shinyUI(pageWithSidebar(
  headerPanel("  Iris Species Prediction from Flower Measurements "),

  sidebarPanel(
    h4('Enter Prediction Inputs in cm'),
    numericInput('id1', 'Sepal.Length', 0, min = 0, max = 10, step = 1),
    numericInput('id2', 'Sepal.Width', 0, min = 0, max = 10, step = 1),
    numericInput('id3', 'Petal.Length', 0, min = 0, max = 10, step = 1),
    numericInput('id4', 'Petal.Width', 0, min = 0, max = 10, step = 1),
    radioButtons("alg", label = h3("Prediction Algorithm"),
                 choices = list("Random Forest" = 1, "Regression Tree" = 2), 
                 selected = 1),
    br(),
    h4('Press Go! to predict'),
    actionButton("goButton", "Go!")

  ),
  mainPanel(
    h3('Submitted Inputs and Prediction Results '),
    h4('Algorithm'),
    verbatimTextOutput("alg"),
    h4('Predictors'),
    tableOutput("df"),
    h4('Prediction'),
    verbatimTextOutput("oprediction")
    
    
  )
))
library(shiny)
library(randomForest)
library(rpart)
library(caret)

data(iris)

set.seed(1234)
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain,]
## modFitrf <<- train(Species ~ ., method="rf", data=training)
modFitrf <<- randomForest(Species ~ . , data=training, method="rf")
## modFitrpart <<- train(Species ~ ., method="rpart", data=training)
modFitrpart <<- rpart(Species ~ . , data=training, method ="class")

result <- function(alg, id1, id2, id3, id4) {
  Sepal.Length <- id1
  Sepal.Width <- id2
  Petal.Length <- id3
  Petal.Width <- id4
  
  df <- data.frame(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
  if (alg == 1) {
    result <- as.character(predict(modFitrf, newdata=df))
  }
  else {
    r1 <- predict(modFitrpart, newdata=df)
    result <- colnames(r1)[match(max(r1),r1)]
  }
  return(result)
}

createData <- function(id1, id2, id3, id4) {
  Sepal.Length <- id1
  Sepal.Width <- id2
  Petal.Length <- id3
  Petal.Width <- id4
  
  df <- data.frame(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
  return(df)
}


algName <- function(alg) {
  if (alg == 1)  return("Random Forest")
  else return("Recursive Partitioning and Regression Tree")
}



shinyServer(
  
  function(input, output) {
    
    output$alg <- renderPrint(algName({input$alg}))
                         
    output$df <- renderTable(createData({input$id1},{input$id2},{input$id3},{input$id4}))
    
    output$oprediction <- renderPrint({
      if (input$goButton == 0)  "You have not pressed the Go button."
      else {
          isolate(result(input$alg, input$id1, input$id2, input$id3, input$id4))        
      }
    })
  }
)
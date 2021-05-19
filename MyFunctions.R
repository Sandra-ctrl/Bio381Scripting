# All functions must be declared at the start

#################
# FUNCTION: get_data
# read in the .csv file
# input: .csv file
# output: dataframe
#---------------------------------
get_data <- function(file_name=NULL) {
  if(is.null(file_name)) {
    data_frame <- data.frame(ID=101:110,
                             varA=runif(10),
                             varB=runif(10))
  } else {
    data_frame <- read.table(file = file_name,
                             header = TRUE,
                             sep = ",",
                             comment.char = "#")
  }
  return(data_frame)
}

get_data()
#################
# FUNCTION: calculate_stuff
# fit an ordinary lease squares regression
# input: x and y vector of numerics of same length
# output: entire summary of regression model
#---------------------------------
calculate_stuff <- function(x_var=runif(10),
                            y_var=runif(10)) {
  data_frame <- data.frame(x_var,y_var)
  reg_model <- lm(y_var~x_var,data = data_frame)
  return(summary(reg_model))
}

# calculate_stuff()

#################
# FUNCTION: summarize_output
# pull some elements from the model summary list
# input: list from the summary call of linear model (lm)
# output: vector of regression residuals
#---------------------------------
summarize_output <- function(z=NULL) {
  if(is.null(z)) {
    z <- summary(lm(runif(10)~runif(10)))
  }
  return(z$residuals)
}

#################
# FUNCTION: graph_results
# graph dtata and fitted OLS line
# input: x and y vectors of numeric. must be same length
# output: creates graph
#---------------------------------
library(ggplot2)
graph_results <- function(x_var=runif(10),y_var=runif(10)) {
  data_frame <- data.frame(x_var,y_var)
  # pl <- ggplot2::qplot(data=data_frame,
  #                      x=x_var,
  #                      y=y_var,
  #                      geom=c("smooth","point"))
  pl <- ggplot2::ggplot(data_frame)+ aes(x=x_var,y=y_var) +
    geom_point() +
    stat_smooth(method="lm")
  print(pl)
  # message("Regression graph created")
  }
graph_results()                      
  

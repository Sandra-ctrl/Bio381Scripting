# sample program to illustrate structured programming with functions.
# 5 April 2021
#-----------------------------------
# Preliminaries
library(ggplot2)
set.seed(99)      
source("MyFunctions.R")

#-------------------------------
#Global variables
antFile <- "antcountydata.csv"
xCol <- 7 #latitude center of each county
yCol <- 5 # number of ant species recorded
#------------------------------

# Program body
# construct the data frame
temp_1 <- get_data(file_name = antFile)
x <- temp_1[,xCol] # extract predictor
y <- temp_1[,yCol] # extract response

# fit the regression model
temp_2 <- calculate_stuff(x_var = x,y_var = y)

#extract the residuals
temp_3 <- summarize_output(temp_2)

graph_results(x_var = x,y_var = y)

print(temp_3) #print residuals
print(temp_2) #print model summary


# Pseudocode
# Get data
# calculate stuff
# summarize output
# graph results

# code will eventually look like this

# get_data()
# calculate_stuff()
# summarize_output()
# graph_results()



# Code Snippets 

# Getting input -----------------------------------------------------------

my_function <- function(x=5) {
  z <- 5 + runif(1)
  return(z)
}
my_function()

# try using a bar
####################################

####################################

# now try using m_sec
# get data  -------------------------------------


# calculate stuff -------------------------------------

# try m_head for set up of a new script
# -----------------------------------------------------------
# tells what this new script is about
# 12 Apr 2021
# Sandra Nnadi
#------------------------------------------------------------
#

# try out cool new function snippet
# -----------------------------------------------------------
# FUNCTION trial_funct
# description: one line explanation here
# inputs: just x=5 for now
# outputs: real number
#############################################################
trial_funct <- function(x=5){
  
  # function body
  
  return("checking...trial_funct")
  
  } # end of trial_funct
  #----------------------------------------------------------
trial_funct()


# load libraries -------------------------------------

library(ggplot2)

# source files -------------------------------------










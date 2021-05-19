# -----------------------------------------------------------
# Basic anatomy and use of a for loop
# 03 May 2021
# Sandra Nnadi
#------------------------------------------------------------
# Anatomy of a for loop

# for(var in seq) { start of a loop
# body of for loop
# } end of loop
# var is a counter variable that holds the current value of the counter in the loop. 
# it is a number that increments by a value of one each time it goes through the loop
# seq is a sequence, an integer vector (or vector of character strings) that defines the starting and ending values of the loop

# suggest using i,j,k for var (counter)

# first create a vector to explain what you should not do

my_dogs <- c("chow","atika","malamute","husky","samoyed")

for(i in my_dogs) {
  print(i)
}

# the var should be able to take values of a numerical sequence not character sequence

# set it up the right way

for(i in 1:length(my_dogs)) {
  cat("i=",i, "my_dogs[i]=", my_dogs[i], "\n")
}

# go a sequence from 1 to 5
# the character strings in green will have the same value each time we print, it will be identical
# the variables in white are going to change each time it runs through the loop

# potential hazard suppose the vector is empty
my_bad_dogs <- NULL

for(i in 1:length(my_bad_dogs)) {
  cat("i=",i, "my_bad_dogs[i]=", my_bad_dogs[i], "\n")
}

# safer way to code var on the for loop is to use seq_along  

for(i in seq_along(my_dogs)) {
  cat("i=",i, "my_dogs[i]=", my_dogs[i], "\n")
}

# i= 1 my_dogs[i]= chow 
# i= 2 my_dogs[i]= atika 
# i= 3 my_dogs[i]= malamute 
# i= 4 my_dogs[i]= husky 
# i= 5 my_dogs[i]= samoyed

for(i in seq_along(my_bad_dogs)) {
  cat("i=",i, "my_bad_dogs[i]=", my_bad_dogs[i], "\n")
}

# nothing happens which is the correct response

# could also define vector length from a constant

zz <- 5
for(i in seq_len(zz)) {
  cat("i=",i, "my_dogs[i]=", my_dogs[i], "\n")
}

# seq_len means make a sequence from 1 to 5

# tips for writing a fo loop

# Tip 1: do NOT change object dimensions inside a loop
# avoid these functions cbind, rbind, c, list because it slows the process down

my_dat <- runif(1)
for(i in 2:10) {
  temp <-runif(1)
  my_dat <- c(my_dat,temp) # do NOT do this, it will slow down the process especially with big data
  cat("loop number=", i, "vector element", my_dat[i], "\n")
}

print(my_dat)
  

# Tip 2: do NOT do things in a loop if you do not need to

for(i in 1:length(my_dogs)) {
  my_dogs[i] <- toupper(my_dogs[i])
  cat("i=",i, "my_dogs[i]=", my_dogs[i], "\n")
}
  
# the letter of the character were converted to upper case but it was not necessary to do it inside the loop

# always do the step outside of the loop
z <- c("dog","cat","pig")
toupper(z)


# Tip 3: do NOT use a loop if you can vectorize

my_dat <- seq(1:10)
for(i in seq_along(my_dat)) {
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number=", i, "vector element", my_dat[i], "\n")
}

# no loop needed here
z <- 1:10
z <- z + z^2
print(z)
  

# Tip 4: understand the distinction between the counter variable i, and the vector element z[i]

z <- c(10,2,4)
for(i in seq_along(z)) {
  cat("i=",i,"z[i]=",z[i],"\n")
}

# what is the value of i at the end of the loop
print(i)

# what is the value of z at the end of the loop
print(z)


# Tip 5: use NEXT to skip certain elements in the loop

z <-1:20
# suppose we want to work only with odd-numbered elements

for(i in seq_along(z)) {
  if(i%% 2==0) next
  print(i)
}

# %% is the remainder of a division. take the element i and divide by 2 and look if the reminder is equal to zero, if it it equal to zero we will say next to skip the next line of code which is to print the value of i

# its like subsetting a vector

# another method is to subset which is probably faster

z <- 1:20
z_sub <- z[z%% 2!=0] # constrast with logical expression in loop. if the reminder does not equal zero keep it and add to the element z_sub
length(z)
length(z_sub)
 for(i in seq_along(z_sub)) {
   cat("i=",i,"z_sub[i]=",z_sub[i],"\n")
 }


# Tip 6: use break to set up a conditional to break out of a loop early
# create a simple random walk population model function

# -----------------------------------------------------------
# FUNCTION ran_walk
# description: stochastic random walk
# inputs: times=number of time steps
#       n1= initial population size(=n[1])
#       lambda= finite rate of increase. a multiplier used to multiply population size by each time step. lambda of 1.1 means population increase 10% each timestep,lambda of .98 decreases 2% each timestep. a lambda of 1 is a growth rate of zero
#     noise_sd= standar deviation of a normal distribution with mean 0
# outputs: vector n with population sizes > 0 until extinction, then NA values
#############################################################
ran_walk <- function(x=5){
  
  # function body
  
  return("checking...ran_walk")
  
  } # end of ran_walk
  #----------------------------------------------------------


# homework 10
#1 use a function to calculate the number of zeros in a numeric vector

# -----------------------------------------------------------
# FUNCTION my_loop
# description: calculate the number of zeros in a numeric vector
# inputs: numeric vector
# outputs: the number of elements equal to zero
#############################################################

vec <- c(rep(0:7,5))

my_loop <- function(data=vec) {
  counter <- 0
 for(i in (vec)) {
  if(i==0){
    counter = counter + 1
  }}   
    return(counter)
} # end of function

print(my_loop())
# [1] 5

#2 use subsetting to rewrite the function as a single line of code

vec2 <- c(rep(0:7,5))
my_set <- length(vec2[vec2==0])
print(my_set)
 
# [1] 5

#3 write a function that takes as input two integers representing the number of rows and columns in a matrix

# -----------------------------------------------------------
# FUNCTION my_mat
# description: description
# inputs: two integers representing the number of rows and column in a matrix
# outputs: a matrix in which each element is the product of the row number and the column number
#############################################################

  
mat <- function(row=4,col=5){
  m <- matrix(data=NA,nrow = row,ncol = col)
    for(i in 1:nrow(m)){
      for(j in 1:ncol(m)){
        m[i,j] <- i*j
      }
    }
    return(m)
  }
mat()  

#       [,1] [,2] [,3] [,4] [,5]
#[1,]    1    2    3    4    5
#[2,]    2    4    6    8   10
#[3,]    3    6    9   12   15
#[4,]    4    8   12   16   20


# -----------------------------------------------------------
# FUNCTION read_data
# description: generate data set for analysis
# inputs: fake data set (I do not have real data)
# outputs: 3 column data frame of observed data (ID, x, y)
#############################################################
read_data <- function(z=NULL){
  if(is.null(z)){
    x_obs <-1:25
    y_obs <- x_obs + 10*rnorm(25)
    df <- data.frame(ID=seq_along(x_obs),
                     x_obs,
                     y_obs)}
  
  return(df)
  
} # end of read_data
# read_data()

# -----------------------------------------------------------
# FUNCTION get_metric
# description: calculate metric for randomization test
# inputs: 2 column data frame for regression
# outputs: regression slope
#############################################################
get_metric <- function(z=NULL){
  if(is.null(z)){
    x_obs <-1:25
    y_obs <- x_obs + 10*rnorm(25)
    z <- data.frame(ID=seq_along(x_obs),
                    x_obs,
                    y_obs)}
  . <-lm(z[,3]~z[,2])
  . <- summary(.)
  . <- .$coefficients[2,1]
  slope <- .
  
  return(slope)
  
} # end of get_metric
#----------------------------------------------------------
# get_metric()


# -----------------------------------------------------------
# FUNCTION shuffle_data
# description: randomize data for regression analysis
# inputs: 3 column data frame (ID,xvar,yvar)
# outputs:  column data frame (ID,xvar,yvar)
#############################################################
shuffle_data <- function(z=NULL){
  if(is.null(z)){
    x_obs <-1:25
    y_obs <- x_obs + 10*rnorm(25)
    z <- data.frame(ID=seq_along(x_obs),
                    x_obs,
                    y_obs)}
  z[,3] <- sample(z[,3])
  
  
    return(z)
  
} # end of shuffle_data
#----------------------------------------------------------
# shuffle_data()


# -----------------------------------------------------------
# FUNCTION get_pval
# description: calculate p value from simulation
# inputs: list of observed metric and vector of simulated metrics
# outputs: lower and upper tail probability value
#############################################################
get_pval <- function(z=NULL){
  if(is.null(z)){
    z <- list(rnorm(1),rnorm(1000))}
  p_lower <- mean(z[[2]]<=z[[1]])
  p_upper <- mean(z[[2]]>=z[[1]])
  
  return(c(pL=p_lower,pU=p_upper))
  
} # end of get_pval
#----------------------------------------------------------
# get_pval()


# -----------------------------------------------------------
# FUNCTION plot_test
# description: create a ggplot of histogram of simulated values
# inputs: list of observed metric and vector simulated metrics
# outputs: saved ggplot graph
#############################################################
library(ggplot2)
plot_test <- function(z=NULL){
  if(is.null(z)){
    z <- list(rnorm(1),rnorm(1000))}
  df <- data.frame(ID=seq_along(z[[2]]), sim_x=z[[2]])
  pl <- ggplot(data=df, mapping=aes(x=sim_x))
  pl + geom_histogram(mapping = aes(fill=I("goldenrod"), color=I("black"))) + 
    geom_vline(aes(xintercept=z[[1]],col="blue"))
  
  
} # end of plot_test
#----------------------------------------------------------
# plot_test()

set.seed(100)
n_sim <- 1000 # number of simulated data sets
x_sim <- rep(NA,n_sim) # set up vector for simulated slopes
df <- read_data() # get fake data
x_obs <- get_metric(df) # get slope of observed data

for (i in seq_len(n_sim)){
  x_sim[i] <- get_metric(shuffle_data(df))
} # run simulation
slopes <- list(x_obs,x_sim) # make list of slopes
get_pval(slopes) # get upper and lower tails
plot_test(slopes) # plot graph of slopes

# pL pU 
# 1  0 

my_reg <- lm(x_obs~y_obs, data=df)
summary(my_reg)

Call:
  lm(formula = x_obs ~ y_obs, data = df)

Residuals:
  Min      1Q  Median      3Q     Max 
-8.3682 -3.8218  0.7136  2.1542 10.5560 

Coefficients:
  Estimate Std. Error t value
(Intercept)  5.67120    1.61728   3.507
y_obs        0.52045    0.09183   5.667
Pr(>|t|)    
(Intercept)   0.0019 ** 
  y_obs       9.05e-06 ***
  ---
  Signif. codes:  
  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.856 on 23 degrees of freedom
Multiple R-squared:  0.5827,	Adjusted R-squared:  0.5646 
F-statistic: 32.12 on 1 and 23 DF,  p-value: 9.051e-06


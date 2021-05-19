# Functions
# 28 March 2021
# Sandra Nnadi
#---------------------------------
library(ggplot2)

sum(3,2) # prefix function
3 + 2 # an operator known as an infix function
`+`(3,2) # the operator is an infix function

y <- 3
print(y)
`<-`(yy,3) # another infix function
print(yy)

# to see the contents of a function you can print it
print(read.table)
sd # prints content of a function
sd(c(3,2)) # calls functions with parameters
sd() # call the function with its default values for the parameters

###############################
# FUNCTION h_weinberg
# calculates Hardy-Weinberg equilibrium values
# input: an allele frequency p(0,1)
# output: p and the frequencies of the 3 genotypes AA,AB and BB
#------------------------------
h_weinberg <- function(p=runif(1)) {
  q <- 1-p
  f_AA <-p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA,AB=f_AB,BB=f_BB),digits = 3)
  return(vec_out)
}
h_weinberg() # try with default
h_weinberg(p=0.5) # pass value to the input parameter
print(p)
pp <- 0.6
h_weinberg(p=pp)
print(pp)
p <- 0.7
h_weinberg(p=p)

# write functions with multiple return values
###########################
# FUNCTION h_weinberg2
# calculates Hardy-Weinberg equilibrium values
# input: an allele frequency p(0,1)
# output: p and the frequencies of the 3 genotypes AA,AB and BB
#------------------------------
h_weinberg2 <- function(p=runif(1)) {
  if (p > 1.0| p <0.0){
    return("Function failure:p must be >=0 and <= 1.0")
  } # end of if statement
  q <- 1-p
  f_AA <-p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA,AB=f_AB,BB=f_BB),digits = 3)
  return(vec_out)
} # end of h_weinberg function
############################

h_weinberg2() # run with default
h_weinberg2(1.1) # it gives message
z <- h_weinberg2(1.10)
print(z) # contains error message

# details of user defined functions
###########################
# FUNCTION h_weinberg3
# calculates Hardy-Weinberg equilibrium values
# input: an allele frequency p(0,1)
# output: p and the frequencies of the 3 genotypes AA,AB and BB
#------------------------------
h_weinberg3 <- function(p=runif(1)) {
  if (p > 1.0| p <0.0){
    stop("Function failure:p must be >=0 and <= 1.0")
  } # end of if statement
  q <- 1-p
  f_AA <-p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA,AB=f_AB,BB=f_BB),digits = 3)
  return(vec_out)
} # end of h_weinberg function
############################
 # use the stop function to track error
zz <- h_weinberg3(1.1)
print(zz)


# explore scoping and local variables
my_func <- function(a=3,b=4){
  z <- a+b
  return(z)
}
my_func()

my_func_bad <- function(a=3){
  z <- a+b
  return(z)
}
my_func_bad()
b <- 100
my_func_bad() # it runs because we have a variable b in the global environment

# its fine to create variables locally
my_func_ok <- function(a=3){
  bb <- 100
  z <- a+bb
  return(z)
}
my_func_ok()
print(bb) # an error is seen because bb is found in the local and does not exist in the global environment


##############################

# FUNTION fit_linear
# fits a simple linear regression line
# inputs: numeric vector of predictor(x) and response(y)
# outputs: slope and p-value

#-----------------------------
fit_linear <- function(x=runif(20),y=runif(20)) {
  my_model <- lm(y~x)
  my_out <- c(slope=summary(my_model)$coefficients[2,1],
              pval=summary(my_model)$coefficients[2,4])
  # plot(x=x,y=y) # quick and dirty plot to check output
  z <- ggplot2::qplot(x=x,y=y)
  plot(z)
  return(my_out)
}
##############################
fit_linear()

##############################

# FUNTION fit_linear2
# fits a simple linear regression line
# inputs: numeric vector of predictor(x) and response(y)
# outputs: slope and p-value

#-----------------------------
fit_linear2 <- function(p=NULL) {
  if(is.null(p)){
    p <- list(x=runif(20),y=runif(20))
  
  } # end of input NULL case
  my_model <- lm(p$y~p$x)
  my_out <- c(slope=summary(my_model)$coefficients[2,1],
              pval=summary(my_model)$coefficients[2,4])
  # plot(x=x,y=y) # quick and dirty plot to check output
  z <- ggplot2::qplot(x=p$x,y=p$y)
  plot(z)
  return(my_out)
}
##############################
fit_linear2()
my_pars <- list(x=1:10,y=runif(10))
fit_linear2(my_pars)

z <- c(runif(99),NA)
mean(z) # doesn't work if NA is present
mean(z,na.rm = TRUE) # change default value
mean(z,na.rm = TRUE,trim = 0.05) # trim off 5% of the tails at each end of the data)
my_pars <- list(x=z,na.rm=TRUE,trim=0.05)
do.call(mean,my_pars) # works for a function and a list of parameters

# -----------------------------------------------------------
# Randomization tests
# 05 May 2021
# Sandra Nnadi
#------------------------------------------------------------
# statistical p is a probability of obtaining the observed results (or something more extreme) if the null hypothesis were true p(data/H0)
# null hypothesis is the hypothesis of "no effect". variation is caused by measured error or other unspecified (and less important) sources of variation


# 2 advantages of randomization tests

# relaxes assumptions of standard parametric tests (normality, balanced sample sizes, common variance)
# gives a more intuitive understanding of statistical probability


# steps in randomization test----------------------------------------------

#1. define a metric X as a single number to represent pattern that we are interested in. what are we trying to quantify e.g difference in means of two groups which would be a single number, multiple treatments (ANOVA) would be an F ratio or among treatment sum of squares

#2. calculate X(observed) the metric for the emperical (observed) data that we start with. is this observed value large or unusual under the null hypothesis

#3. randomize or reshuffle the data to uncouple the association between the observed data and their assignment to treatment groups. the randomization only affects the pattern of treatment effects in the data. other aspects such as sample sizes are kept constant in the randomization

#4. for this single randomization, calculate X(simulated) if the null hypothesis is true then X(obs) should be similar to X(sim). if the null hypothesis is false then X(obs) is very different from X(sim)

#5. repeat steps 3 & 4 many times typically 1000 times. this will let us visualize as a histogram the distribution of X(sim); distribution of X values when the null hypothesis is true

#6. estimate the tail probability of the observed metric (or something more extreme) given the null distribution p(X(obs)|H0)


library(ggplot2)
library(TeachingDemos)

set.seed(100)
char2seed("espresso withdrawal")
options(digits=10) # optional
char2seed("espresso withdrawal", set = FALSE)

# create treatment groups
trt_group <- c(rep("Control",4),rep("Treatment",5))
print(trt_group)

# create response variable
z <- c(runif(4) + 1, runif(5) + 10)
print(z)

# combine vectors into dataframe
df <- data.frame(trt=trt_group,res=z)
print(df)

# look at the means in the two groups
obs <- tapply(df$res,df$trt,mean)
print(obs)

# create a simulated data set
# set up a new data frame
df_sim <- df
df_sim$res <- sample(df_sim$res)
print(df_sim)

# look at the means in the two groups of randomized data
sim <- tapply(df_sim$res,df_sim$trt,mean)
print(sim)


# -----------------------------------------------------------
# FUNCTION read_data
# description: read in or generate datat set for analysis
# inputs: file name (or nothing as in demo)
# outputs: 3 column data frame of observed data (ID, x, y)
#############################################################
read_data <- function(z=NULL){
  if(is.null(z)){
    x_obs <-1:20
    y_obs <- x_obs + 10*rnorm(20)
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
    x_obs <-1:20
    y_obs <- x_obs + 10*rnorm(20)
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
    x_obs <-1:20
    y_obs <- x_obs + 10*rnorm(20)
    z <- data.frame(ID=seq_along(x_obs),
                    x_obs,
                    y_obs)}
  z[,3] <- sample(z[,3])

  
  # function body
  
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
# FUNCTION plot_ran_test
# description: create a ggplot of histogram of simulated values
# inputs: list of observed metric and vector simulated metrics
# outputs: saved ggplot graph
#############################################################
library(ggplot2)
  plot_ran_test <- function(z=NULL){
  if(is.null(z)){
    z <- list(rnorm(1),rnorm(1000))}
  df <- data.frame(ID=seq_along(z[[2]]), sim_x=z[[2]])
  pl <- ggplot(data=df, mapping=aes(x=sim_x))
  pl + geom_histogram(mapping = aes(fill=I("goldenrod"), color=I("black"))) + 
    geom_vline(aes(xintercept=z[[1]],col="blue"))
  
  
    } # end of plot_ran_test
  #----------------------------------------------------------
# plot_ran_test()
  
  
n_sim <- 1000 # number of simulated data sets
x_sim <- rep(NA,n_sim) # set up vector for simulated slopes
df <- read_data() # get fake data
x_obs <- get_metric(df) # get slope of observed data

for (i in seq_len(n_sim)){
  x_sim[i] <- get_metric(shuffle_data(df))
} # run simulation
slopes <- list(x_obs,x_sim)
get_pval(slopes)
plot_ran_test(slopes)

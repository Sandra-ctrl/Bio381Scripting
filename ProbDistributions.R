# Probability distributions
# 19 Mar 2021
# Sandra Nnadi

library(ggplot2)
library(MASS)

# Poisson
# Discrete X >= 0 (integer)
# Random events ("hits") occur at a constant rate (in a fixed time period or sampling area)
#  Poisson has only a single parameter which is lambda = average rate of event

# "d" function for probability density
hits <- 0:10
my_vec <- dpois(x=hits,lambda = 1)
qplot(x=hits,
      y=my_vec,
      geom = "col",
      color=I("black"), fill=I("goldenrod"))

hits <- 0:10
my_vec <- dpois(x=hits,lambda = 2)
qplot(x=hits,
      y=my_vec,
      geom = "col",
      color=I("black"), fill=I("goldenrod"))

hits <- 0:15
my_vec <- dpois(x=hits,lambda = 6)
qplot(x=hits,
      y=my_vec,
      geom = "col",
      color=I("black"), fill=I("goldenrod"))

hits <- 0:10
my_vec <- dpois(x=hits,lambda = 0.2)
qplot(x=hits,
      y=my_vec,
      geom = "col",
      color=I("black"), fill=I("goldenrod"))

sum(my_vec)
dpois(x=0,lambda = 2.2)
# if the event is occurring at a rate of lambda value of 2.2, the chances of getting no successes or no hits over the sampling interval is about 11%

# "p" function 
# generates cumulative probability density
# the p function takes each of the element and adds it to the next one
# we get a curve that must alwyas go up and peak out at 1.0.

hits <- 0:10
my_vec <- ppois(q=hits,lambda = 2)
qplot(x=hits,
      y=my_vec,
      geom = "col",
      color=I("black"), fill=I("goldenrod"))

# what is the prob. that a single trial will yield a value of less than or equals to one <= 1

ppois(q=1,lambda = 2)
# we could answer this using dpois
p_0 <- dpois(x=0,lambda = 2)
p_0
p_1 <- dpois(x=1,lambda = 2)
p_1
p_0 + p_1

# "q" function is the inverse of the p function
# what is the number of hits corresponding to 50% of the probability mass in a poisson distribution with lambda=2.5

qpois(p=0.5,lambda = 2.5)
qplot(x=0:10,
      y=dpois(x=0:10, lambda = 2.5),
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))
ppois(q=2,lambda = 2.5)

# "r" function generates random variates for the parameters of a distribution

ran_pois <- rpois(n=1000,lambda=2.5)
qplot(x=ran_pois,
      color=I("black"),
      fill=I("goldenrod"))

# for real or stimulated data , we can use quantile function
quantile(x=ran_pois,probs = c(0.025,0.975))

# binomial
# p = probability of a dichotomous outcome e.g guilty or innocent
# size= number of trials
# x = possible outcomes
# outcome x is bounded between and number of trials

# use "d" function
hits <- 0:10
my_vec <- dbinom(x=hits,size = 10, prob = 0.8)
qplot(x=0:10,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))

my_coins <- rbinom(n=50,size=100,prob=0.6)
qplot(x=my_coins,
      color=I("black"),
      fill=I("goldenrod"))

# negative binomials: number of failures
# expected before reaching a number of successes
# in a set of binomial trials, measure of waiting times
# alternatively, can specify mu= mean and size= dispersion parameter (smaller values are more dispersed)
# negative binomial is similar to the poisson but more heterogenous

neg_bin <- rnbinom(n=1000,size=10,mu=5)
qplot(neg_bin,color=I("black"),fill=I("goldenrod"))

neg_bin <- rnbinom(n=1000,size=0.1,mu=5)
qplot(neg_bin,color=I("black"),fill=I("goldenrod"))

neg_bin <- rnbinom(n=1000,size=100,mu=5)
qplot(neg_bin,color=I("black"),fill=I("goldenrod"))

# uniform
# parameters for minimum and maximum

qplot(x=runif(n=100,min=0,max=5),color=I("black"),fill=I("goldenrod"))

qplot(x=runif(n=10000,min=0,max=5),color=I("black"),fill=I("goldenrod"))

# normal, gaussian
my_norm <- rnorm(n=100,mean = 100,sd=2)
qplot(x=my_norm, color=I("black"),fill=I("goldenrod"))

summary(my_norm)
 
# problem if the mean is small but must be greater than zero

my_norm <- rnorm(n=100,mean = 1,sd=2)
qplot(x=my_norm, color=I("black"),fill=I("goldenrod"))
summary(my_norm)
no_zeros <- my_norm[my_norm>0]
qplot(x=no_zeros, color=I("black"),fill=I("goldenrod"))


# gamma distribution
# continuous, positive, bounded only at zero
# shape, scale

my_gamma <- rgamma(n=100,shape = 1,scale=10)
qplot(x=my_gamma, color=I("black"),fill=I("goldenrod"))

my_gamma <- rgamma(n=100,shape = 100,scale=10)
qplot(x=my_gamma, color=I("black"),fill=I("goldenrod"))

# mean=shape*scale
# variance=shape*scale^2

# beta distribution
# continuous but bounded between 0 and 1
# shape 1 and shape 2
# beta can be treated as the distribution of probability values for estimating a binomial process
# successes/ # trials
# successes/(# successes + # failures)
# shape 1= number of successes +1
# shape 2 = number of failures +1

# when there's no data
my_beta <- rbeta(n=1000,shape1 = 1,shape2 = 1)
qplot(x=my_beta, color=I("black"),fill=I("goldenrod"))

# suppose 7 heads and 3 tails
my_beta <- rbeta(n=1000,shape1 = 8,shape2 = 4)
qplot(x=my_beta, color=I("black"),fill=I("goldenrod"))

# suppose 70 heads and 30 tails
my_beta <- rbeta(n=1000,shape1 = 71,shape2 = 31)
qplot(x=my_beta, color=I("black"),fill=I("goldenrod"))

# small datasets is much noiser
# toss a coin once and get heads
my_beta <- rbeta(n=1000,shape1 = 2,shape2 = 1)
qplot(x=my_beta, color=I("black"),fill=I("goldenrod"))

# parameters less than 1 give a bimodal distribution with beta

my_beta <- rbeta(n=1000,shape1 = 0.1,shape2 = 0.1)
qplot(x=my_beta, color=I("black"),fill=I("goldenrod"))


# Maximum Likelihood estimation
# p(data|hypothesis) how probable are the data if the null hypothesis is true
# p(data|parameters) parameters for a statistical distribution. how well do the data fit given those parameters for the distribution.
# p(parameters|data) for a given set of data what is the prob that a certain set of parameters will be there.
# so we maximize the probability- Maximum likelihood estimators of parameters

data <- c(0,0,0,0,0,0,1,1,1,2)
z <- fitdistr(data,"poisson")
print(z)
sim_data <- rpois(n=10,lambda = z$estimate["lambda"])
head(sim_data)

# 1. select a statistical distribution that is appropriate for the data.
# 2. use fitdistr() to find likelihood estimates of the distribution parameters
# use those parameters to visualize the probability density function ("d" family) and/or simulate additional data to use for other things
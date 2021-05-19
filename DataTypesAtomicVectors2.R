# Data types and atomic vectors
# 3/10/2021
# Sandra Nnadi

# create atomic vector (avoid this)
z <- vector(mode = "numeric", length = 0)
print(z)
# add elements to it
z <- c(z,5)
head(z)

# this dynamic sizing is very slow
# right way is to predefine the vector length
# create a vector of 100 zeros
z <- rep(0,100)
head(z)

# better way is to start with NAs
z <- rep(NA,100)
typeof(z)
z[1] <- "washington"
head(z)
typeof(z)

# efficiently create a large vector with names
my_vector <- runif(100)
my_names <- paste("species",
                  seq(1:length(my_vector)),
                  sep = "")
head(my_names)
names(my_vector) <- my_names
head(my_vector)

# using the rep
rep(0.5,6)
rep(x=0.5,times=6) # a better way give input names
rep(times=6,x=0.5) # order not important if names specified
my_vec <- c(1,2,3)
rep(x=my_vec,times=2)
rep(x=my_vec,each=2)
rep(x=my_vec,times=my_vec)
rep(my_vec,each=my_vec) #we dont use this

# using seq
seq(from=2,to=4)
2:4 # very common in R programming
seq(from=2,to=4,by=0.5)
seq(from=2,to=4,length=7)
x <- seq(from=2,to=4,length=7)
my_vec <- seq(1:length(x))
my_vec
seq_along(x)
seq_len(5)

# random numbers and sampling
runif(5)
runif(n=3,min = 100,max = 103)

rnorm(6)
rnorm(n=6,mean= 100, sd=30)

## Explore distributions by sampling and plotting
library(ggplot2) # always do at start of script
z <- runif(1000)
qplot(z)
m.hist(z)

# how to use the sample function to draw values out

long_vec <- seq_len(10)
long_vec
sample(long_vec) # with no other parameters, this just reorders the data
sample(long_vec,size = 3) # specify a number, sampling without replacement
sample(long_vec,size = 16, replace = TRUE) # sampling with replacement

my_weights <- c(rep(20,5),rep(100,5)) # a set of non zero positive weights which can be integers or real value
my_weights
sample(x=long_vec,replace = TRUE,prob = my_weights)
sample(x=long_vec,replace = FALSE,prob = my_weights)
sample(x=long_vec,replace = TRUE,prob = long_vec)


# how to subset an atomic vector

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
# how to pull out particular elements-pick them up on the basis of their position
# positive index values
z[c(2,3)]
z[c(2,2,3,3)]

# negative index values to exclude elements
z[-c(2,3)]

# create a vector of logical elements to select based on values

z < 3
z[z<3]

tester <- z < 3
print(tester)
z[tester]

# also have which function
which(z<3)

# use length to get relative positions relative to start and end of vector
# select everything but last two elements
z[-(length(z):(length(z)-1))]

# subset using named vector elements
names(z) <- letters[1:5]
z[c("b","c")]

# relational operators in R
# < less than
# > greater than
# <= less than or equal to
# >= greater than or equal to
# == equal to

# Logical operators in R
# ! means not
# & means and (vector)
# | means or (vector)
# xor(vec_a,vec_b) one or the other but not both
# && means and (only for the first element)
# || means an or (only for the first element)

x <- 1:5
y <- c(1:3,7,7)

x == 2
x != 2
x == 7
x == 1
y == 7
x == 1 & y == 7
x == 1 | y == 7
x == 3 | y == 3
xor(x == 3, y == 3)
x == 3 && y == 3

# subscripting with missing values 

set.seed(90)
z <- runif(10)
print(z)

z < 0.5 # create a logical value
z[z<0.5]
which(z < 0.5)
z[which(z < 0.5)]

# which behaves differently if there are NAs
zD <- c(z,NA,NA) # contaminate it
zD[zD < 0.5]
# NA values carried along
zD[which(zD < 0.5)] # NA values are dropped

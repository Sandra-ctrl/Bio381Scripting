# Matrices, Lists, Data frames
# 13 March 2021
# Sandra Nnadi
#-----------------------------------
# Preliminaries 
library(ggplot2)

# matrix is an atomic vector wrapped up in a 2 dimensional structure
m <- matrix(data = 1:12,nrow = 4,ncol = 3)
print(m)

m <- matrix(data = 1:12,nrow = 4)
print(m)

# fill one row at a time in order
m <- matrix(data =1:12,nrow = 4,byrow =TRUE) 
print(m)

# use function dim to see dimensions
dim(m)

# matrix dimensions can be changed (must be correct size)
dim(m) <- c(6,2) # six rows and two columns
print(m)
dim(m) <- c(4,3)

# get row and column numbers separately
nrow(m)
ncol(m)

# note that length of matrix is referring to atomic vector
length(m)

# add names
rownames(m) <- c("a","b","c","d")
print(m)
colnames(m) <-LETTERS[1:ncol(m)]
print(m)
rownames(m) <-letters[nrow(m):1]
print(m)

# specify single element
# print row 3, column 3
print(m[2,3])

#subset an entire row or column by leaving other dimension blank
# print row 2, showing all columns
print(m[2,])
# print column 3 showing all the rows
print(m[,3])

# print everything
print(m)
print(m[,])
print(m[])

rownames(m) <- paste("Species", LETTERS[1:nrow(m)],sep = "")
colnames(m) <- paste("Site",1:ncol(m),sep = "")
print(m)

dimnames(m) <- list(paste("Species", LETTERS[1:nrow(m)],sep = ""),paste("Site",1:ncol(m),sep = ""))
print(m)

# transpose a matrix with t() where the rows become the column and the column becomes the rows
m_transpose <- t(m)
print(m_transpose)

# add a row to a matrix with rbind()
m_transpose <- rbind(m_transpose,c(10,20,30,40))
print(m_transpose)

# fix label
rownames(m_transpose)
rownames(m_transpose)[4] <- "myfix"
print(m_transpose)

# access individual rows and columns by names
m_transpose["myfix","SpeciesA"]
# add columns to matrix with cbind
SpeciesE <- c(13,2,0,1)
m_transpose <- cbind(m_transpose,SpeciesE)
print(m_transpose)

# easy to convert back to an atomic vector
my_vec <- as.vector(m_transpose)
print(my_vec)


# lists are like an atomic vector
# the key difference is that it can hold objects of different types

my_list <- list(1:10, matrix(1:8,nrow =4,byrow =TRUE),letters[1:3],pi)
str(my_list)
print(my_list)

# using single brackets does not give the contents, it just gives the list items
my_list[4]
# if a list has 10 elements it is like a train with ten cars
# contents of the 5th car must be shown by a double bracket [[5]]
# [c[4,5,6]] creates a little train with cars 4, 5 and 6

# use double brackets then carry out the operations
my_list[[4]]-3

# once double bracket is called, individual elements can be assessed in the usual way
my_list[[2]]
my_list[[2]][4,1]

# name list items when they are created

my_list2 <- list(tester=FALSE,little_m=matrix(1:9,nrow=3))

# once we have a list that has names the named elements can be accessed with the dollar sign prefix
my_list2$little_m[2,3]
my_list2$little_m
my_list2$little_m[2,]
my_list2$little_m[2]

# the unlist function puts everything into a single atomic vector
unrolled <- unlist(my_list2)
print(unrolled)
# the common use of the list is in running a linear model or statistical model because the summary of the model is in the form of a list
# output from  a linear model is a list with info we need
y_var <- runif(10)
x_var <- runif(10)
my_model <- lm(y_var~x_var) # lm is linear model, y variable is a linear function indicated by the tilde of the x variable
qplot(x=x_var,y=y_var)

# look at output from model
print(my_model)
summary(my_model)
str(summary(my_model))

# pull out what we need
summary(my_model)$coefficients
# we get a table which is a matrix of values in it
str(summary(my_model)$coefficients)
stats <- summary(my_model)$coefficients
stats["x_var","Pr(>|t|)"]
stats[2,4]

# lets get our number using unlist
u <- unlist(summary(my_model))
my_pval <- u$coefficients8

# Data frame is a specialized kind of list. 
# it is a list of equal- lengthed atomic vectors
# in a matrix all of the elements are of the same data type

var_a <- 1:12 # an integer
var_b <- rep(c("Con","LowN","HighN"),each=4) # a character string
var_c <- runif(12) # a double
d_frame <- data.frame(var_a,var_b,var_c)
str(d_frame)
print(d_frame)

# add another row with rbind 
# make sure it is added as a list with each named item corresponding to a column
new_data <- list(var_a=13,var_b="HighN",var_c=0.6687)
d_frame <- rbind(d_frame,new_data)
str(d_frame)
tail(d_frame)

# adding a column is simpler
var_d <- runif(13)
d_frame <- cbind(d_frame,var_d)
str(d_frame)

# more concise and elegant addition of a column
d_frame$var_e <- 13:1
str(d_frame)
head(d_frame)

d_frame$var_f <- c(rnorm(12),NA)
tail(d_frame)

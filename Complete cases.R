# Complete cases
# 16 March 2021
# Sandra Nnadi

# complete case function allows us to clean out a vector or matrix so it does not have any missing elements in it

# create an atomic vectoe with missing values
z <- c(10,20,NA,NA,50)
complete.cases(z) # gives a boolean vector
z[complete.cases(z)] # sweeps out the NA values
which(!complete.cases(z)) # shows position of the missing values

# sweeping out rows with missing values in a matrix
m <- matrix(1:20,nrow = 5)
m
m[1,1] <- NA
m[5,4] <- NA
m

# eliminate rows with any missing values
m[complete.cases(m),] # will remove the entire 1st and 2nd row of m

m[complete.cases(m[,c(1,2)]) ,] # give me the rows that do not have missing values in first and second column
m[complete.cases(m[,c(2,3)]) ,] # this would have no drops cause there is no missing values
m[complete.cases(m[,c(3,4)]) ,] # will drop row 5
m[complete.cases(m[,c(1,4)]) ,] # drops rows 1 and rows 5

# subsetting matrices and data frames

m <- matrix(data=1:12,nrow = 3)
dimnames(m) <- list(paste("Species",
                          LETTERS[1:nrow(m)],sep = ""),
                    paste("Site", 1:ncol(m),sep=""))
print(m)

# subset based on elements
m[1:2,3:4]
m[c("SpeciesA","SpeciesB"),c("Site1","Site2")]

m[1:2,]
m[,3:4]

# use logicals for more complex subsetting
colSums(m) > 15
m[,colSums(m) > 15]

# select all rows for which row total is 22
m[rowSums(m)==22,]

# select for NOT relation
m[!rowSums(m)==22,]

# choose all rows for which the numbers for Site 1 < 3 
# AND choose all columns for which the numbers of species A < 5

m[,"Site1"] < 3
m[m[,"Site1"]<3,]

# set up logical for columns
m["SpeciesA",]<5
m[,m["SpeciesA",]<5]

# combine both
m[m[,"Site1"]<3 ,m["SpeciesA",]<5]

# take caution when you subscript a matrix so you dont accidentally convert it to a vector

z <- m[1,]
print(z)
str(z)

# now its treated as a vector
# avoid it by adding the drop option
z2 <- m[1,,drop=FALSE]
print(z2)
str(z2)
# ensure you mention the dimension in a matrix

# Data Curation
# Metadata is the information about the data, where it was collected, how it was collected, what the units are that it was collected in
#
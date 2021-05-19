# Data structure comparisons and data curation
# 16 March 2021
# Sandra Nnadi

# distinctions between lists and matrices

# create a matrix and data frame with same structure

z_mat <- matrix(data = 1:30,ncol = 3,byrow =TRUE)
z_dframe <- as.data.frame(z_mat)
str(z_mat) # atomic vector in 2 dimensions
str(z_dframe) # list with 3 integer vectors

head(z_dframe) # note the automatic variable naming
head(z_mat)
colnames(z_mat) <- c("V1","V2","V3")

# element referencing is the same in both
z_mat[3,3]
z_dframe[3,3]

# so is row referencing
z_mat[3,]
z_dframe[3,]

# column numbers are also the same
z_mat[,3]
z_dframe[,3]

# one difference when calling by name
z_mat[,"V3"]
z_dframe[,"V3"]
z_dframe$V3

# what happens if we reference only one dimension
z_mat[3] # gives third element
z_dframe[3] # selects the entire third column

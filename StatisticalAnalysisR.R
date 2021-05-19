# Statistical analysis in R
# 23 March 2021
# sandra Nnadi
#---------------------------------
library(tidyverse)

# dataframe construction for regression analysis
n <- 50 # number of observation (rows)
var_A <- runif(n) # random uniform (independent variable)
var_B <- runif(n) # random uniform (dependent variable)
var_C <- 5.5 + var_A*10 # a noisy linear relationship with var_A

ID <- 1:n

reg_data <- data.frame(ID,var_A,var_B,var_C)
head(reg_data)
str(reg_data)

# regression analysis in R
reg_model <- lm(var_B~var_A, data=reg_data)
print(reg_model)
str(reg_model)
head(reg_model$residuals) # contains residuals

# summary has the elements we need
summary(reg_model)

z <- unlist(summary(reg_model))

reg_stats <- list(intercept=z$coefficients1,
                  slope=z$coefficients2,
                  intercept_p=z$coefficients7,
                  slope_p=z$coefficients8, r2=z$r.squared)
print(reg_stats)
reg_stats$r2
reg_stats[[5]]
reg_stats[5] # dont use this, it is just a list item

# setting up a basic regression plot
reg_plot <- ggplot(reg_data)+
  aes(x=var_A,y=var_B)+
  geom_point()+
  stat_smooth(method = lm,se=0.99) # default se=0.95
print(reg_plot)
ggsave(filename = "RegressionPlot.pdf",
       plot = reg_plot,
       device = "pdf")


# Analysis of Variance
# data frame construction for ANOVA

n_group <- 3 # number of treatment groups
n_name <- c("Control","Treat1","Treat2") # names of groups
n_size <- c(12,17,9) # always have 10 or more replicates for sample size in each of the independent treatment
# analysis works best when you have equal number of observations inside the treatment groups
n_mean <- c(40,41,60) # mean responses
n_sd <- c(5,5,5) # standard deviation of each group

ID <- 1:sum(n_size) # creates unique ID

res_var <- c(rnorm(n=n_size[1],mean=n_mean[1],sd=n_sd[1]),
             rnorm(n=n_size[2],mean=n_mean[2],sd=n_sd[2]),
             rnorm(n=n_size[3],mean=n_mean[3],sd=n_sd[3]))

trt_group <- rep(n_name,n_size)
ano_data <- data.frame(ID,trt_group,res_var)
head(ano_data)

# analysis of variance in R
ano_model <- aov(res_var~trt_group,data = ano_data)
print(ano_model)
summary(ano_model)
z <- summary(ano_model)
print(z)
flat_out <- unlist(z)
ano_stats <- list(f_ratio <- unlist(z)[7],
                  f_pval <- unlist(z)[9])
print(ano_stats)

# basic ggplot of anova data
ano_plot <- ggplot(ano_data)+
  aes(x=trt_group,y=res_var)+
  geom_boxplot()
print(ano_plot)
ggsave(filename = "ANOVAPlot.pdf",
       plot = ano_plot,
       device = "pdf")

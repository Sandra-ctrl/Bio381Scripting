# All functions must be declared at the start

#################
# FUNCTION: BB_data
# read in blueberry data
# input: Mean, variance and size of groups
# output: dataframe

BB_data <- function(bb_size=c(17,15,16), bb_mean=c(22,45,32), bb_sd=c(5,5,5)) {
  
  bb_name <- c("Control","CommInoc","LocInoc")
  
  BerryMass <- c(rnorm(n=bb_size[1],mean = bb_mean[1],sd=bb_sd[1]),
                 rnorm(n=bb_size[2],mean = bb_mean[2],sd=bb_sd[2]),
                 rnorm(n=bb_size[3],mean = bb_mean[3],sd=bb_sd[3]))
  
  Treatment <- rep(bb_name,bb_size) 
  
  ID <- 1:sum(bb_size)
  
  ano_data <- data.frame(ID,Treatment,BerryMass)
  
  return(ano_data)
  
}
BB_data()
head(BB_data)
tail(BB_data)

#################
# FUNCTION: BB_Analyze
# Analyze blueberry data
# input: dataframe of vectors
# output: ANOVA data statistics
my_data <- BB_data()
BB_analyze <- function(ano_data=my_data) {
  
  ano_model <- aov(BerryMass~Treatment,data = ano_data)
  
  return(summary(ano_model))
         
}


BB_analyze()

#################
# FUNCTION: BB_Graph
# plots blueberry data
# input: ANOVA data
# output: boxplot

library(ggplot2)
my_analysis <- BB_analyze()
BB_graph <- function(ano_data=my_data)  {
  ano_plot <- ggplot(ano_data)+
    aes(x=Treatment,y=BerryMass,fill=Treatment)+
    geom_boxplot()+
    labs(title = "Effect of Inoculation on Berry Mass")+
    theme_minimal()
  return(ano_plot)
  
}

BB_graph()

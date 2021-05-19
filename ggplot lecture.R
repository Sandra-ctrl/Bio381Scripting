# -----------------------------------------------------------
# Basics of ggplot grammar and graphics
# 16 May 2021
# Sandra Nnadi
#------------------------------------------------------------

# Components of a ggplot

#1. data should be in (in data frame)
#2. aesthetic mapping (variables are mapped to an aesthetic)
#3. what geom to use (geometric object to used to draw the layer; points, bars polygons, etc)
#4. stats (raw data and transforms it for something useful in a plot)
#5. position element ( adjust points for overplotting)
#6. facet function for producing multiple plots


# template for ggplot components -------------------------------------

# p1 <- ggplot(data=<DATA>,
#     mapping=aes(<MAPPING>)) + 
#     <GEOM_FUNCTION(mapping=aes(<MAPPING>),
#     stat=<STAT>,
#     position=<POSITION>) +
#     <COORDINATE_FUNCTION> #flip/invert the x and y axis  +
#     <FACET_FUNCTION>

# print(p1)
# ggsave(plot=p1,
#       filename="MyPlot",
#       width=5,
#     height=3,
#     units="inches",
#     device="pdf")

# Preliminaries ------------------------------------------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("doubling time")

d <- mpg # use built in data set on car performance
str(d)
table(d$fl)

# fast plotting with qplot that does not require the use of dataframe-------------------------------------------------------------

# basic histogram
qplot(x=d$hwy)
qplot(x=d$hwy, fill=I("darkmagenta"), color=I("black"))

# make your own custom histogram function
my_histo <- function(x_var,fil_col="goldenrod"){
  qplot(x=x_var,color=I("black"), fill=I(fil_col))}

my_histo(d$hwy)
my_histo(d$hwy,"thistle")

# basic density plot to show density profile of the data
qplot(x=d$hwy,geom = "density")

# basic scatter plot that fits a smooth curve that follows trendline of the data
qplot(x=d$displ,
      y=d$hwy,
      geom = c("smooth","point"))

# basic scatter plot with linear regression line to pass a straight line through it
qplot(x=d$displ,
      y=d$hwy,
      geom = c("smooth","point"),method="lm")

# basic boxplot if the x-axis variable is discrete and the y-axis variable is continuous (ANOVA model)
qplot(x=d$fl, y=d$cty, geom = "boxplot", fill=I("indianred"))
# horizontal line is the median of the data

# basic barplot ("long format")
qplot(x=d$fl, geom = "bar", fill=I("indianred"))



# looks at one variable to count the number of cases of fl that fall into the bar categories

# common mistake when you do not call the identity it will treat fill as a variable
qplot(x=d$fl, geom = "bar", fill="indianred")

# barplot with specified counts or means ("short format")
x_treatment= c("Control","Low","High")
y_response= c(12,2.5,22.9)
qplot(x=x_treatment, y=y_response, geom = "col", fill=I(c("grey20","grey50","grey70")))

# basic curves and functions

my_vec <- seq(1,100,by=0.1)
head(my_vec)
my_func <- function(x) sin(x) + 0.1*x
qplot(x=my_vec, y=sin(my_vec), geom = "line") # built in function

qplot(x=my_vec,y=dgamma(my_vec, shape = 5, scale = 3),
      geom = "line") # density functions for stats

qplot(x=my_vec,y=my_func(my_vec),
      geom = "line") # user defined function


# Themes and fonts ---------------------------------------------------------------

p1 <- ggplot(data = d,
             mapping=aes(x=displ,y=cty)) +
  geom_point()
print(p1) # basic graph
p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_base()
p1 + theme_void()
p1 + theme_economist()
p1 + theme_bw()
p1 + theme_grey() # default theme for ggplot

# Major theme modifications------------------------------------------

p1 + theme_classic(base_size = 40)
p1 + theme_classic(base_size = 9) # base size scales down the axis
p1 + theme_classic(base_family = "serif") # changes the font

# defaults are : theme_grey, base_size=16, base_family="Helvetica"

# default font families (Mac): Times, Arial, Monaco, COurier, Hekvetica, Serif, Sans.

# use the coordninate flip element to invert the enetire plot

p2 <- ggplot(data=d, mapping = aes(x=fl, fill=fl)) +
  geom_bar()
print(p2)

p2 + coord_flip()

# MInor theme modification------------------------------------------

p1 <- ggplot(data=d, mapping = aes(x=displ, y=cty)) +
  geom_point(size=7, shape=21,color="black", fill="steelBlue") + labs(title="my graph title here",
                                                                      subtitle = "an extended subtitle that will print below the main title",
                                                                      x="my X axis label", 
                                                                      y="my Y axis label") + 
  xlim(0,4) +
  ylim(0,20)
print(p1)

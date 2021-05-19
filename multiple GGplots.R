# -----------------------------------------------------------
# ggplot multiple plots and aesthetics
# 16 May 2021
# Sandra Nnadi
#------------------------------------------------------------
#

library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("crocus")
d <- mpg # use mpg data set

# multiple plots --------------------------------------------

# create a series of plots

g1 <- ggplot(data=d,
             mapping = aes(x=displ, y=cty)) +
  geom_point() +
  geom_smooth()
print(g1) # scatterplot with x and y continuous variable on the two axis

g2 <- ggplot(data=d,
             mapping = aes(x=fl, 
                           fill=I("tomato"), color=I("black"))) +
  geom_bar(stat="count") +
  theme(legend.position = "none")
print(g2) # count plot with discrete variable with counts on the y axis

g3 <- ggplot(data=d,
             mapping = aes(x=displ, 
                           fill=I("royalblue"), color=I("black"))) +
  geom_histogram()
print(g3) # histogram with continuos variable on the x axis and the counts

g4 <- ggplot(data=d,
             mapping = aes(x=fl, y=cty,
                           fill=fl)) +
  geom_boxplot() +
    theme(legend.position = "none")
print(g4) # boxplot with discrete variable on the x axis and conitinuos variable on the y and the summary of the boxplot to show the distribution


# use patchwork to combine plots
# place two plots horizontally

g1 + g2

# place 3 plots vertically
g1 + g2 +g3 +plot_layout(ncol = 1)

# change relative area of each plot
g1 + g2 + plot_layout(ncol = 1, heights = c(2,1))
g1 + g2 + plot_layout(ncol = 2, widths = c(1,2))

# add a spacer plot
g1 + plot_spacer() + g2

# use nested plots
g1 + {
  g2 + {
    g3 +
      g4 +
      plot_layout(ncol = 1)
  }
} +
  plot_layout(ncol = 1)

# - operator for subtrack element
g1 + g2 - g3 + plot_layout(ncol = 1)

# / and | for intuitive plot layouts
(g1 | g2 | g3)/g4

(g1 | g2) / (g3 | g4)

# add title and subtitle
g1 + g2 + plot_annotation("This is a title", caption = "made with patchwork")

# change the styling of patchwork annotations
g1 + g2 + plot_annotation(
  title = "This is a title",
  caption = "made with patchwork",
  theme = theme(plot.title = element_text(size = 16)))

# add tags to plots
g1 / (g2 | g3) +
  plot_annotation(tag_levels = "A")


# Swapping axes, orientation--------------------------------------------

g3a <- g3 + scale_x_reverse()
g3b <- g3 + scale_y_reverse()
g3c <- g3 + scale_x_reverse() + scale_y_reverse()

(g3 | g3a) /(g3b | g3c)


# coordinate flipping
(g3 + coord_flip() | g3a + coord_flip())/
  (g3b + coord_flip() | g3c + coord_flip())


# Aesthetic mapping ---------------------------------------------------------------

# mapping of discrete variable to point color
m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           color=class)) +
  geom_point(size=3)
print(m1)

# mapping of a discrete variable to point shape (<= 6 groups for it to work)
m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           shape=class)) +
  geom_point(size=3)
print(m1)

# mapping of a discrete variable to point size (not recommended)

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           size=class)) +
  geom_point()
print(m1) # using size for a discrete variable is not advised

# mapping a continuous variable to point size

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           size=hwy)) +
  geom_point()
print(m1) # for continuous variable you can map to size or color for a discrete variable you can map to color or shape.

# mapping a continuous variable to point color

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           color=hwy)) +
  geom_point(size=5)
print(m1) # we just mapped 3 continuous variable

# map two variables to different aesthetics at the same time

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           shape=class,
                           color=hwy)) +
  geom_point(size=5)
print(m1)

# use shape for a smaller number of categories

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           shape=drv,
                           color=fl)) +
  geom_point(size=5)
print(m1) # this uses 2 continuous variables and 2 discrete variables ( drive and fuel type)

# use all 3 (size, shape, color) to indicate 5 data attributes

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           shape=drv,
                           color=fl,
                           size=hwy)) +
  geom_point()
print(m1)

# mapping a variable to the same aesthetic in two different geom

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           color=drv)) +
  geom_point(size=2) +
  geom_smooth(method = "lm")
print(m1)


# facetingGreat for summarizing large and complex dataset------------------------------------------

# basic faceting with variables split by row, column or both

m1 <- ggplot(data = d,
             mapping = (aes(x=displ,
                           y=cty))) +
                           geom_point()
m1 + facet_grid(class~fl)

# change axes by letting some of them be free
m1 + facet_grid(class~fl, scales = "free_y")

# let both axes be free in scale
m1 + facet_grid(class~fl, scales = "free")

# facets also work with one way layout
m1 + facet_grid(.~class) # looking at the differences in the classes which comes out as a column

# one way layout with differing rows
m1 + facet_grid(class~.)

# use facet wrap when variables are not crossed
m1 + facet_grid(.~class)
m1 + facet_wrap(.~class)

# add a second grouping variable
m1 + facet_wrap(.~class + fl)

# include empty combos in facet_wrap
m1 + facet_wrap(.~class + fl, drop=FALSE)
 
# use facet with other aesthetic mappings within rows or columns

m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           color=drv)) +
  geom_point()
m1 + facet_grid(.~class)

# easy to switch to other geoms
m1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=cty,
                           color=drv)) +
  geom_smooth(se=FALSE, method="lm")
m1 + facet_grid(.~class)

# fitting boxplots with a continuous variable
m1 <- ggplot(data = d,
             mapping = (aes(x=displ,
                           y=cty))) +
  geom_boxplot()
m1 + facet_grid(.~class)

# add a group and fill mappings for subgroups
m1 <- ggplot(data = d,
             mapping = (aes(x=displ,
                           y=cty,
                           group=drv, fill=drv))) +
  geom_boxplot()
m1 + facet_grid(.~class)

# aesthetic mappings 2--------------------------------------------------------------

# standard plot with all data

p1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=hwy)) +
  geom_point() + geom_smooth()
print(p1)

# break out drive types (note what group affects)

p1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=hwy, group=drv)) +
  geom_point() + geom_smooth()
print(p1)

# break out drive types (not what color affects)
p1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=hwy,
                           color=drv)) +
  geom_point() + geom_smooth()
print(p1) # color affects points and lines. boxplots and confidence intervals are affected by fill

# break out drive types (not what fill affects)
p1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=hwy,
                           fill=drv)) +
  geom_point() + geom_smooth()
print(p1) # fill affects confidence interval

# color both the points and the confidence interval if we choose to 

p1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=hwy,
                           color=drv, fill=drv)) +
  geom_point() + geom_smooth()
print(p1)


# use aesthetic mappings to override defaults
# subset data to plot what is needed

p1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=hwy,
                           color=drv)) +
  geom_point(data=d[d$drv=="4",]) + geom_smooth()
print(p1)

# instead of subsetting, just map an aesthetic
p1 <- ggplot(data = d,
             mapping = aes(x=displ,
                           y=hwy)) +
  geom_point(mapping = aes(color=drv)) + geom_smooth()
print(p1)

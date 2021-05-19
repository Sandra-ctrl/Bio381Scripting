# Coding with dplyr -------------------------------------

library(dplyr)

# using a built in data set
data("starwars")
class(starwars)

# tibble: "modern take on dataframes"
glimpse(starwars)

# clean up our tibble
starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
anyNA(starwarsClean)

glimpse(starwars)

########## filter(): pick/subset observations by their values

# uses > >= < <= != ==
# logical operators & | !
# automatically excludes NAs
# selects based on rows

filter(starwarsClean, gender == "masculine", height < 180)

######## arrange():: reorder rows
arrange(starwarsClean, by=height) # Ascending
arrange(starwarsClean, by=desc(height)) 
arrange(starwarsClean, height, desc(mass)) # each additional column is used to break ties

################ select(): choosing variables/columns by their names
starwarsClean[,1:10]
select(starwarsClean, 1:10)
select(starwarsClean, name:species)
select(starwarsClean, -(films:starships))

# rearrange columns
select(starwarsClean, name, gender, species, everything())

# other helper functions; contains, ends_with, starts_with, matches (regular expression), num_range

############# mutate: creates new variables with functions of existing variables
mutate(starwarsClean, ratio= height/mass)
starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2)
select(starwars_lbs, 1:3, mass_lbs, everything())

# transmute to only have a separate data frame
transmute(starwarsClean, mass_lbs = mass*2.2, ratio = height/mass, name)

######## summarize
summarize(starwarsClean, meanHeight = mean(height))

summarize(starwarsClean, meanHeight = mean(height, na.rm=TRUE))
# need to specify na.rm-TRUE if data has NAs

# group_by
starwarsGenders <- group_by(starwarsClean, gender)
head(starwarsGenders)
summarize(starwarsGenders, meanHeight= mean(height), Number=n())


############ PIPING %>%
# used to emphasize a sequence of actions
# it passes an intermediate results onto the next function (output of one statement is the input into the next statement)
# dont pipe if you need to manipulate more than one object at a time or if you need intermediate variables
# formatting always have a space before the pipe and follow with a new line

starwarsClean %>%
  group_by(gender) %>%
  summarize(mean(height), number=n())

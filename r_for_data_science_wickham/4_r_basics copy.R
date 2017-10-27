# workflow from R for data science by Hadley Wickham ###################

# Coding Basics #######
# calculator #######
1/200 * 30

(59+73+2) / 3

sin(pi / 2)

# create objects ####
x <- 3*4

# <- RStudio keyboard shortcut, alt - #########

this_is_a_really_long_name <- 2.5

# another shortcut, cmd ↑ - in the console window, type the beginning of the command and then cmd up and it will show  you a history

# make a sequence of numbers
seq(1,10)

# surround with parenthesis in order to get it to print to screen
(y <- seq(1,10, length.out = 5))

# Practice ####
# Why does this code not work?
my_variable <- 10
my_varıable # because that thing isn't an i

# tweak the following commands so that they run correctly
library(tidyverse)

# ggplot(dota = mpg) + 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# fliter(mpg, cyl = 8)
filter(mpg, cyl == 8)
# filter(diamond, carat > 3)
filter(diamonds, carat > 3)

# Press Alt + Shift + K. What happens? How can you get to the same place using the menus? Keyboard shortcuts cheat sheet shows up; the help menu


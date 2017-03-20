# Tibbles
install.packages("tibble")
library(tidyverse)
# package ‘tidyverse’ was built under R version 3.3.2 - update R
# upgraded Lightning to 3.3.3

as_tibble(iris)

# create a tibble ####
tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)
# Error in tibble(x = 1:5, y = 1, z = x^2 + y) : object 'y' not found

tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)
tb

# this doesn't work for me


tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)
# tribble worked

tibble( # this isn't working
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

# print larger datasets ####
nycflights13::flights %>% 
  print(n = 10, width = Inf)

# view in RStudio
nycflights13::flights %>% 
  View()

# subsets ####
df <- tibble( # this doesn't work
  x = runif(5),
  y = rnorm(5)
)

x = runif(5)
y = rnorm(5)
df <- tibble(x,y) # also doesn't work
df <- data.frame(x,y)

# Extract by name
df$x
# same as 
df[["x"]]

df[[1]]
 # to use in a pipe, use .

df %>% .$x
df %>% .[["x"]]

# turn a tibble into a data frame
class(as.data.frame(tb))

# Exercises ####

# How can you tell if an object is a tibble? (Hint: try printing mtcars, which is a regular data frame). It says "a tibble"

# Compare and contrast the following operations on a data.frame and equivalent tibble. What is different? Why might the default data frame behaviours cause you frustration?
df <- data.frame(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]


# If you have the name of a variable stored in an object, e.g. var <- "mpg", how can you extract the reference variable from a tibble? 

# Practice referring to non-syntactic names in the following data frame by:
#   
#   Extracting the variable called 1.
# 
# Plotting a scatterplot of 1 vs 2.
# 
# Creating a new column called 3 which is 2 divided by 1.
# 
# Renaming the columns to one, two and three.
# 
# annoying <- tibble(
#   `1` = 1:10,
#   `2` = `1` * 2 + rnorm(length(`1`))
# )
# What does tibble::enframe() do? When might you use it?
# 
# What option controls how many additional column names are printed at the footer of a tibble?

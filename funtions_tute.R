# creating functions tutorial from http://nicercode.github.io/guides/functions/


# Basic syntax of a function ----------------------------------------------

sum.of.squares <- function(x,y) {
  x^2 + y^2
}

# This function has 2 arguments and returns the sum of square of these arguments
# Because this code has been run, the function now works:

sum.of.squares(3,4)

# returns [1] 25

# The workflow is:
# 1) Define the function
# 2) Load the function
# 3) Use the function

# load the dataset
data <- read.csv("data/seed_root_herbivores.csv")

# play with the data
mean(data$Height)
var(data$Height)
length(data$Height)

# because the standard error repeats the same variable, you want a function
sqrt(var(data$Height)/length(data$Height))
sqrt(var(data$Weight)/length(data$Weight))

# define the function
standard.error <- function(x) {
  sqrt(var(x)/length(x))
}
standard.error(data$Height)
standard.error(data$Weight)


# define variables within the function
standard.error <- function(x) {
  v <- var(x)
  n <- length(x)
  sqrt(v/n)
}

######################################################
x <- data$Height
n <- length(x)
(1/(n - 1))

# what is the difference between all of the x values and the mean?
m <- mean(x)
x - m

# square all of those differences
(x-m)^2

# compute the sum of squares
sum((x-m)^2)

# find the variance
var(x)

# clean up 
rm(n,x,m)

# define a function of all the pieces above
variance <- function(x){
  n <- length(x)
  m <- mean(x)
  (1/(n - 1)) * sum((x-m)^2)
}

# test it
variance(data$Height)
var(data$Height)

# make a function for skewness
skewness <- function(x) {
  n <- length(x)
  v <- var(x)
  m <- mean(x)
  third.moment <- (1/(n - 2)) * sum((x - m)^3)
  third.moment/(var(x)^(3/2))
}

skewness(data$Height)  # should be 0.301

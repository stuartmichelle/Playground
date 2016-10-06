
# In this script, we'll learn the basics of R!

# R as a calculator
################################################################################

# R can perform ALL mathematical operations
# +, -, *, /, ^, exp(), sqrt(), log(), log10(), abs(), and more
1+3
2*3
exp(3) # raise e to the 3
sqrt(49) # square root of 49
a <- sqrt(49)
b <- 3

a + b 


# R is logical
################################################################################

# R can perform ALL logical tests
# <, <=, >, >=, ==, !=, 
# ! = NOT, | = OR, & = AND, %in% = in

1 < 3 # True (Boolean)
2 > 1 & 3 < 4


# R uses objects 
################################################################################

# Create simple objects
################################

# Creating simple objects
# Create objects using the <- operator
# Objects can be numeric, integer, string, complex, logical, and more

a <- 1.342 # numeric
b <- 1 # integer
d <- "R course 2016" # string

# Create vectors
################################

# Creating numerical vectors
# You can create numeric vectors using c(), seq(), or the : operator
e <- c(1,2,3,4)
1:5 # just for integers
seq(from = 1, to = 5, by = 1)
seq(1, 5, 0.5)
seq(from = 1, to = 5, length.out = 4) # if you want to split it by a certain number of bins (split this evenly by 4 numbers)

# Creating character (string vectors)
# You can create character vectors using c() and paste()
char.vec <- c("isabel", "tabby", "abigail")

# Combining vectors
# You can combine vectors using c()
c(char.vec, e) # coerces numbers into strings
list(char.vec, e)


# What happens when you combine a string and character vector?




# Indexing vectors 
################################

# Indexing vectors
# Use []s to index a vector - put the element position in the bracked
num.vec <- seq(1, 2000, 3)

# what is the 49th number
num.vec[49]
num.vec[c(49, 103)] # get the 49th and 103rd element


# EXERCISE BREAK!
################################################################################

# Basic math
################################

# 1. What is the sum of 856 + 765?
856 + 765

# 2. What is 104 multiplied by 187
104 * 187

# 3. What is 1 divided by 12 + 47
1/(12+47)

#  Vectors
################################

# 4. Create a vector of 1 to 5, save it as object x
x <- 1:5

# 5. Create a vector of 12, 17, 9, 11, save it as object y
(y <- c(12, 17, 9, 11)) # putting parenthesis will also print this

# 6. Create a vector of both x and y together
z <- c(x, y)

# 7. Run g<-seq(11,333,3), what is the 68 position in this vector?
g <- seq(11, 333, 3)
g[68]

# 8. How do you call both the 68 position and 79 simultaneously?

g[c(68, 79)]





# In this script, we'll learn the basics of R!

# R as a calculator
################################################################################

# R can perform ALL mathematical operations
# +, -, *, /, ^, exp(), sqrt(), log(), log10(), abs(), and more
17 + 3
17 * 3
17 ^ 9
sqrt(17)
log(17)
abs(-17)


# R is logical
################################################################################

# R can perform ALL logical tests
# <, <=, >, >=, ==, !=, 
# ! = NOT, | = OR, & = AND, %in% = in
1 < 3
1 == 3
1 != 3
1 %in% c(2,3,4)
3 > 1 & 2^2 == 4
1 < 3 & 2^2 == 4

# R uses objects 
################################################################################

# Create simple objects
################################

# Creating simple objects
# Create objects using the <- operator
# Objects can be numeric, integer, string, complex, logical, and more
a <- 1
b <- 3
a + b 
a <- sqrt(10)
a^2
b <- "string data"

# Create vectors
################################

# Creating numerical vectors
# You can create numeric vectors using c(), seq(), or the : operator
num.vec1 <- c(1, 2, 3, 4, 5)
num.vec2 <- 1:5
num.vec3 <- seq(0, 10, 2)

# Creating character (string vectors)
# You can create character vectors using c() and paste()
char.vec1 <- c("Olaf", "Chris", "Ganzo")
char.vec2 <- paste("Day", 1:3)
char.vec3 <- paste("Day", 1:3, sep="-")

# Combining vectors
# You can combine vectors using c()
num.vec4 <- c(num.vec1, num.vec2)
char.vec4 <- c(char.vec1, char.vec2)

# What happens when you combine a string and character vector?
whoknows.vec <- c(num.vec1, char.vec1)

# Indexing vectors 
################################

# Indexing vectors
# Use []s to index a vector - put the element position in the bracked
char.vec4
char.vec4[2]
char.vec4[2:4]
char.vec4[c(2, 3, 4)]


# EXERCISE BREAK!
################################################################################

# Basic math
################################

# 1. What is the sum of 856 + 765?
856 + 765

# 2. What is 104 multiplied by 187
104 * 187

# 3. What is 1 divided by 12 + 47
1 / 12 + 47

#  Vectors
################################

# 4. Create a vector of 1 to 5, save it as object x
x <- 1:5

# 5. Create a vector of 12, 17, 9, 11, save it as object y
y <- c(12, 17, 9, 11)

# 6. Create a vector of both x and y together
x <- c(x, y)

# 7. Run g<-seq(11,333,3), what is the 68 position in this vector?
g <- seq(11,333,3)
g[68]

# 8. How do you call both the 68 position and 79 simultaneously?
g[c(68, 79)]


# WORKING WITH DATA
################################################################################



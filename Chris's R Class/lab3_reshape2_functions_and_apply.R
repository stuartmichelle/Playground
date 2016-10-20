
# In this script, we will learn to use the reshape2 package to transform data
# between wide- and long- formats. We will learn to use the apply family of functions
# to quickly and succinctly perform calculations and will learn to write custon functions.

# READ AND FORMAT DATA
################################################################################

# Packages
# library(Hmisc) # errbar()
library(plotrix) # std.error()
library(dplyr)
library(reshape2)

# Read data
data <- read.csv("Chris's R Class/brazilian_mahogany_tree_data.csv")

# Inspect data
View(data) # this is a wide data set - diameters in many columns for each year

# Format data
colnames(data) <- tolower(colnames(data)) # make column names lower case

# Fields in mahogany dataset
# SITE = location
# NOME = tree id
# XY = coordinates
# ILLUMINATION = illumination index (how much sun a tree gets)
# VINES = vine load index (how many vines are on the tree)
# DM = diameter of tree in cm
# INC = growth rate (increment) of tree between years in cm / yr
# FRT = number of fruit produced in a year

# THE APPLY() FUNCTION
################################################################################

# Let's use the apply() functions to calculate the average (+/- 1 SD) 
# growth rate per tree (rows) and per year (columns)

# Subset growth rate data

  # find the columns that have a growth increment, grep returns the index number
  gr.cols <- colnames(data)[grep("inc", colnames(data))]
gr.data <- subset(data, select = gr.cols)

# Calculate average growth rate per tree (rows) - format scientific notation off
tree.gr.avg <- round(as.numeric(format(apply(gr.data, 1, mean, na.rm = T), scientific = F)), 4)
boxplot(tree.gr.avg)

# Calculate average growth rate per year (columns)
year.gr.avg <- apply (gr.data, 2, mean, na.rm = T)
plot(year.gr.avg, type = "l")

# Calculate variability in growth rate per year (columns)
year.gr.sde <- apply (gr.data, 2, std.error, na.rm = T)

plot(1997:2009,year.gr.avg, type = "l", xlab = "year", ylab = "growth rate", bty = "n", las = 1)

Hmisc::errbar(x = 1997:2009, y = year.gr.avg, yplus = year.gr.avg+year.gr.sde, yminus = year.gr.avg - year.gr.sde, add = T)


# Let's use the apply() functions to calculate the total fruit production 
# per tree (rows) and per year (columns)

# Subset fruit data



# Calculate total fruit per year (columns)
# using apply() and also colSums() -- there is a rowSums() function too - colSums is the sum of each column, and row sums is the sum of each row (as if you dragged sum along the row)
colSums(gr.data, na.rm = T)
rowSums(gr.data, na.rm = T)


# RESHAPE2: TRANSFORM FROM WIDE-TO-LONG AND VICE VERSA
################################################################################

# If we want to look at diameter, growth rate, or fruit production over time,
# it would be helpful to transform the data from wide to long format

# I often refer to this tutorial when transforming between formats:
# http://seananderson.ca/2013/10/19/reshape.html

# Subset diameter data
  # create a vector of the already existing diameter column names
    dm.cols <- paste("dm0", 1:9, sep = "")
dm.data <- subset(data, select = c("site", "nome", dm.cols))
  
# Reshape diameter data (wide to long) - flip diameters into one column and the names of the columns will be a new column - this could be useful for anemone data
data1 <- melt(dm.data, id.vars = c("site", "nome"), variable.name = "year", value.name = "dm")

# Format year column - replace dm01 with actual year
data1$year <- as.numeric(gsub("dm", "20", data1$year))
str(data1)

# Plot diameters over time




# CUSTOM FUNCTIONS AND THE SAPPLY() FUNCTION
################################################################################

# Let's use some custom functions to quickly plot the change basal area over time

# function_name <- function(arg1, arg2, arg3){
# lines of code that use arguments
# return()
# }

# Basal area = the area of the tree at its diameter at breast height
# Area of a circle = pi * r ^ 2

# EXAMPLE FUNCTIONS

# Example function: multiply 3 numbers together
2*3*4
mult3num <- function(x, y, z){
  a <- x * y * z
  return(a)
}

mult3num(2,3,4)

# Example function: multiply 3 numbers together and add them together
multplus3num <- function(x,y,z){
  a <- x*y*z
  b <- x+y+z
  d <- c(a,b) # can't return (a,b)
  return(d)
}

multplus3num(2,3,4)
# FUNCTIONAL FUNCTIONS :) :) :)

# Diameter (cm) to basal area m2
dm2ba <- function(dm){
  ba <- pi * (dm / 2) ^ 2
  return(ba)
}

# for one value
dm2ba(100)

# for a table of values
dm2ba(data1$dm)

# Calculate sum basal area per year (lapply = list, sapply = vector)

years <- 2001:2009
ba_tots <- sapply(years, function(x) sum(dm2ba(data1$dm[data1$year == x]), na.rm = T))








# In this script, we will learn to use the reshape2 package to transform data
# between wide- and long- formats. We will learn to use the apply family of functions
# to quickly and succinctly perform calculations and will learn to write custon functions.

# READ AND FORMAT DATA
################################################################################

# Packages
library(Hmisc) # errbar()
library(plotrix) # std.error()
library(dplyr)
library(reshape2)

# Read data


# Inspect data


# Format data


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



# Calculate average growth rate per tree (rows)



# Calculate average growth rate per year (columns)



# Calculate variability in growth rate per year (columns)



# Let's use the apply() functions to calculate the total fruit production 
# per tree (rows) and per year (columns)

# Subset fruit data



# Calculate total fruit per year (columns)
# using apply() and also colSums() -- there is a rowSums() function too



# RESHAPE2: TRANSFORM FROM WIDE-TO-LONG AND VICE VERSA
################################################################################

# If we want to look at diameter, growth rate, or fruit production over time,
# it would be helpful to transform the data from wide to long format

# I often refer to this tutorial when transforming between formats:
# http://seananderson.ca/2013/10/19/reshape.html

# Subset diameter data


  
# Reshape diameter data (wide to long)



# Format year column



# Plot diameters over time




# CUSTOM FUNCTIONS AND THE SAPPLY() FUNCTION
################################################################################

# Let's use some custom functions to quickly plot the change basal area over time.
# Basal area = the area of the tree at its diameter at breast height
# Area of a circle = pi * r ^ 2

# EXAMPLE FUNCTIONS

# Example function: multiply 3 numbers together



# Example function: multiply 3 numbers together and add them together



# FUNCTIONAL FUNCTIONS :) :) :)

# Diameter (cm) to basal area m2



# Calculate sum basal area per year








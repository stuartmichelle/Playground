
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
data <- read.csv("brazilian_mahogany_tree_data.csv")

# Inspect data
head(data)
str(data)
colnames(data)

# Format data
colnames(data) <- tolower(colnames(data))

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
gr.cols <- colnames(data)[grep("inc", colnames(data))]
gr.data <- subset(data, select=c(gr.cols))

# Calculate average growth rate per tree (rows)
tree.gr.avg <- apply(gr.data, 1, mean, na.rm=T)
boxplot(tree.gr.avg, frame=F, las=1, ylab="Growth rate (cm / yr)")

# Calculate average growth rate per year (columns)
year.gr.avg <- apply(gr.data, 2, mean, na.rm=T)
plot(year.gr.avg, type="l", bty="n", las=1, 
     xlab="Year", ylab="Growth rate (cm / yr)")

# Calculate variability in growth rate per year (columns)
year.gr.sde <- apply(gr.data, 2, std.error, na.rm=T)
plot(1997:2009, year.gr.avg, type="l", bty="n", las=1, 
     xlab="Year", ylab="Growth rate (cm / yr)")
errbar(1997:2009, year.gr.avg, year.gr.avg+year.gr.sde, year.gr.avg-year.gr.sde, add=T)

# Let's use the apply() functions to calculate the total fruit production 
# per tree (rows) and per year (columns)

# Subset fruit data
frt.cols <- paste("frt0", 1:9, sep="")
frt.data <- subset(data, select=c(frt.cols))

# Calculate total fruit per year (columns)
# using apply() and also colSums() -- there is a rowSums() function too
year.frt.tot <- apply(frt.data, 2, sum, na.rm=T)
year.frt.tot <- colSums(frt.data, na.rm=T)
plot(1997:2009, year.frt.tot, type="l", bty="n", las=1, 
     xlab="Year", ylab="Total fruit")

# RESHAPE2: TRANSFORM FROM WIDE-TO-LONG AND VICE VERSA
################################################################################

# If we want to look at diameter, growth rate, or fruit production over time,
# it would be helpful to transform the data from wide to long format

# I often refer to this tutorial when transforming between formats:
# http://seananderson.ca/2013/10/19/reshape.html

# Subset diameter data
dm.cols <- paste("dm0", 1:9, sep="")
dm.data <- subset(data, select=c("site", "nome", dm.cols))
  
# Reshape diameter data (wide to long)
data1 <- melt(dm.data, id.vars=c("site", "nome"), variable.name="year", value.name="dm")
data1 <- arrange(data1, site, nome)
data1 <- subset(data1, !is.na(dm) & site=="MR")

# Format year column
data1$year <- as.numeric(gsub("dm", "20", data1$year))

# Plot diameters over time
trees <- sort(unique(data1$nome))
plot(1:10, 1:10, type="n", bty="n", las=1, 
     xlim=c(2000, 2010), ylim=c(0,150), xlab="Year", ylab="DBH (cm)")
for(i in 1:length(trees)){
  sdata <- subset(data1, nome==trees[i])
  lines(sdata$year, sdata$dm, lwd=0.4, col="grey60")
}

# CUSTOM FUNCTIONS AND THE SAPPLY() FUNCTION
################################################################################

# Let's use some custom functions to quickly plot the change basal area over time.
# Basal area = the area of the tree at its diameter at breast height
# Area of a circle = pi * r ^ 2

# EXAMPLE FUNCTIONS

# Example function: multiply 3 numbers together
3 * 4 * 5
mult3nums <- function(a, b, c){
  d <- a * b * c
  return(d)
}
mult3nums(3, 4, 5)

# Example function: multiply 3 numbers together and add them together
3 + 4 + 5
3 * 4 * 5
multplus3nums <- function(a, b, c){
  d <- a * b * c
  e <- a + b + c
  f <- c(d, e)
  return(f)
}
multplus3nums(3, 4, 5)


# FUNCTIONAL FUNCTIONS :) :) :)

# Diameter (cm) to basal area m2
dm2ba <- function(dm){
  ba_m2 <- pi * (dm / 100 / 2) ^ 2
  return(ba_m2)
}

# Calculate sum basal area per year
years <- 2001:2009
ba_tots <- sapply(years, function(x) sum(dm2ba(data1$dm[data1$year==x])))
plot(years, ba_tots, bty="n", las=1,
     xlim=c(2000,2010), ylim=c(55,70), xlab="Year", ylab="Total basal area (m2)")








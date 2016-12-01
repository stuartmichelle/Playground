# Section 8 - Double Loops
################################################################################

library(dplyr)
library(RColorBrewer)

# Read in Data
################################################################################

setwd("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop")
data<-read.csv('Mongolia Fish Data.csv')

#Format Dates
data$date<-as.Date(data$date,format = "%m/%d/%Y")


# How a Double Loop Works
################################################################################

#With just one loop

#With two



# A Bad Example of A Double Loop - Then How to Properly Do it
################################################################################

#### Your Goal: Make a Matrix of mean fish length by water body and by species

# Make a Vector of water bodies and species

# Make a matrix whose rows are species and whose columsn are water bodies

# Make a double loop to fill in every combination of spp and body

#### This works fast for small datasets, but with bigger one's it's very slow

#Make a "key" with the pairs of species and water body

#Can use a loop

#Or Just use dplyr


# A Good Example of A Double Loop
################################################################################

#### Your Goal: Plot A multipanel figure of timeseries of different species caught
#### at 4 water bodies

#Choose the species and water bodies
body<-c('Hovsgol','Uur','Eg')
spp<-c('taimen','spiny loach','Phoxinus','lenok','grayling-Arctic',
       'grayling-Hovsgol','grayling-unknown','burbot')

#Choose colors to represent the time series for each species


#A Vector of Y limits

#Make Loop: First Loop subsets by water bodya and makes a plot space
# Second loop fills in time series



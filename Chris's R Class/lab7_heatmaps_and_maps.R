# Section 7 - Heatmaps and Mapping
################################################################################

# Load All Packages
################################################################################
library(shape) # colorlegend()
library(colorRamps) # blue2red()
library(maps) # Basic Maps
library(mapdata) # More map data
library(ggmap) # Nicer Maps
library(ggplot2) # Nicer Plots with ggmap
library(RColorBrewer)


# READ DATA (Copied from Section 6)
################################################################################

# Clear workspace
rm(list = ls())

# Read temperature data
# setwd("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop")
load("Chris's R Class/interpolated_thermister_string_data.Rdata")

# Read date data
temp.dates.data <- read.csv("Chris's R Class/temperature_data_collection_dates.csv", as.is=T)

# Add simulated temperature data to temp.dates.data
temp.dates.data$temp_c <- 3 + 1:nrow(temp.dates.data) * 0.04 + rnorm(nrow(temp.dates.data), 0, 0.5)

# WORKING WITH DATE/TIME DATA
################################################################################

# Inspect structure of temp.dates.all
# This file is in R's date format
str(temp.dates.all)

# Inspect structure of temp.dates.data
# This file is characater (string) data and needs to be converted to R's date format
str(temp.dates.data)

# Try plotting temperate ~ date in the wrong format
plot(temp_c ~ date1, temp.dates.data)

# Convert character date/time data to R date/time data using strptime()
strptime(temp.dates.data$date1, format="%m/%d/%y")
strptime(temp.dates.data$date2, format="%B %d, %Y")
strptime(temp.dates.data$date3, format="%d-%b-%Y")
strptime(temp.dates.data$date4, format="%m/%d/%y %H:%M %p")

# Let's save temp.dates.data as a vector of dates
temp.dates.data <- strptime(temp.dates.data$date1, format="%m/%d/%y")

# Convert R date/time to character date/time using strftime()
strftime(temp.dates.data, "%A, %B %d, %Y")
strftime(temp.dates.data, "%j")

# There are a bunch of different date/time formats in R
# I'm not exactly sure when you use one versus the other
# but some functions can be picky (dplyr, for example, requires POSIXct)
# Date/time types that I know of: POSIXct, POSIXlt, Date
str(temp.dates.data)
as.POSIXct(temp.dates.data)
as.Date(temp.dates.data)


# PLOTTING A HEAT MAP - With Image
################################################################################

# Format data

# Plot matrix

# Add custom color bar

# Improve x-axis and y-axis labels

# Plot temperature legend

#### Can also use filled.contour for same figure

# Making Maps
################################################################################

#Maps Package for basic maps and for polygons


#### Using ggplot2 with maps

#Use ggplot() with geom_polygon


# Try plotting one state

# Plotting multiple states, Zoomed in Slightly, with Border Lines

#### Using ggmap



# Or Specify the center of the map


#Changing Scale

#Adding Points to A map

#Add a scale color based on fish length

#Scale Point size based on fish length

# Exercise - Create a Terrain Map of Pearch & Spiny Loach
# Make sure all points are present in your map and color code the points by species


# Bonus Challenge - Lots of points have similar or the same coordinate. Make a plot that 
# takes either the count or average length of any type of grayling caught in that location


# In this script, we will learn to write/use for loops and to use the dplyr package
# to powerfully and elegantly summarize/aggregate data. 


# GOOD DATA MANAGEMENT TIPS
# don't use spaces or special characters in column names but do include units of measurement
# Make new columns instead of using text colors or cell shading, use a notes column
# 
# use only lower case text
# One data table, one data sheet

# READ AND FORMAT DATA
################################################################################

# Packages
library(dplyr)

# Read data
data <- read.csv("Chris's R Class/mongolia_fish_data.csv")

# Inspect data
str(data)
head(data)
tail(data)
colnames(data)

# Format data
data <- subset(data, !is.na(tl_mm), select=c(sample_id, year, date, water_body, species_name, tl_mm, weight_g, sex, age_otolith))
colnames(data) <- c("fishid", "year", "date", "location", "species",
                    "length_mm", "weight_g", "sex", "age")

# Lower case species names
colnames(data) <- tolower(colnames(data)) #opposite would be toupper for upper case


# THE PROBLEM
################################################################################

# We want to know the average and maximum size of each fish species in our dataset.
# We will learn to perform these calculation using 2 different approaches.
#     (1) For loops
#     (2) The dplyr package

# Let's begin by choosing which species we want to analyze.

# How many length observations for each species?
table(data$species)
table(data$species, data$location)

# Build a vector of species to analyze - the species we are going to loop through
data$species <- tolower(data$species) # make them all lowercase

spp <- c("burbot", "grayling-arctic", "grayling-hovsgol", "lenok", "perch", "phoxinus", "roach", "taimen")


# FOR LOOPS
################################################################################

# EXAMPLE LOOPS

# Example loop: print 1:10
for(i in 1:10){
  print(i)
}

# Example loop: print sqrt(1:10)
for(i in 1:10){
  a <- sqrt(i)
  print(a)
}


# THE REAL LOOP

# Setup dataframe to record results
length.stats <- data.frame(species = spp, length_avg = NA, length_max = NA)

# Loop through species names and calculate average and maximum

  # Subset species data

  # Calculate average and maximum length

  # Record average and maximum length in dataframe



# Sort data frame by length_avg


# THE DPLYR PACKAGE
################################################################################

# Calculate average and maximum length by species using dplyr


# Calculate average and maximum length by species and sex using dplyr













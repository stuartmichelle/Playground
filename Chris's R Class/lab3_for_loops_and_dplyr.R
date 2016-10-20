
# In this script, we will learn to write/use for loops and to use the dplyr package
# to powerfully and elegantly summarize/aggregate data. 

# READ AND FORMAT DATA
################################################################################

# Packages
library(dplyr)

# Read data


# Inspect data



# Format data
# data <- subset(data, !is.na(tl_mm), select=c(sample_id, year, date, water_body, species_name, 
#                               tl_mm, weight_g, sex, age_otolith))
# colnames(data) <- c("fishid", "year", "date", "location", "species",
#                     "length_mm", "weight_g", "sex", "age")

# Lower case species names



# THE PROBLEM
################################################################################

# We want to know the average and maximum size of each fish species in our dataset.
# We will learn to perform these calculation using 2 different approaches.
#     (1) For loops
#     (2) The dplyr package

# Let's begin by choosing which species we want to analyze.

# How many length observations for each species?



# Build a vector of species to analyze



# FOR LOOPS
################################################################################

# EXAMPLE LOOPS

# Example loop: print 1:10


# Example loop: print sqrt(1:10)



# THE REAL LOOP

# Setup dataframe to record results


# Loop through species names and calculate average and maximum

  # Subset species data

  # Calculate average and maximum length

  # Record average and maximum length in dataframe



# Sort data frame by length_avg


# THE DPLYR PACKAGE
################################################################################

# Calculate average and maximum length by species using dplyr


# Calculate average and maximum length by species and sex using dplyr













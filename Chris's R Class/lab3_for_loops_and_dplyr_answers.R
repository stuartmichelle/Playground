
# In this script, we will learn to write/use for loops and to use the dplyr package
# to powerfully and elegantly summarize/aggregate data. 

# READ AND FORMAT DATA
################################################################################

# Packages
library(dplyr)

# Read data
data <- read.csv("mongolia_fish_data.csv")

# Inspect data
head(data)
str(data)
colnames(data)

# Format data
data <- subset(data, !is.na(tl_mm), select=c(sample_id, year, date, water_body, species_name, 
                              tl_mm, weight_g, sex, age_otolith))
colnames(data) <- c("fishid", "year", "date", "location", "species",
                    "length_mm", "weight_g", "sex", "age")

# Lower case species names
data$species <- tolower(data$species)


# THE PROBLEM
################################################################################

# We want to know the average and maximum size of each fish species in our dataset.
# We will learn to perform these calculation using 2 different approaches.
#     (1) For loops
#     (2) The dplyr package

# Let's begin by choosing which species we want to analyze.

# How many length observations for each species?
table(data$species)

# Build a vector of species to analyze
spp <- c("burbot", "grayling-arctic", "grayling-hovsgol", "lenok", "perch",
         "phoxinus", "roach", "spiny loach", "stone loach", "taimen")


# FOR LOOPS
################################################################################

# EXAMPLE LOOPS

# Example loop: print 1:10
for(i in 1:10){
  print(i)
}

# Example loop: print sqrt(1:10)
for(i in 1:10){
  print(sqrt(i))
}

# THE REAL LOOP

# Setup dataframe to record results
length.stats <- data.frame(species=spp, length_avg=NA, length_max=NA)

# Loop through species names and calculate average and maximum
for(i in 1:length(spp)){
  
  # Subset species data
  sdata <- subset(data, species==spp[i])
  
  # Calculate average and maximum length
  length_avg <- mean(sdata$length_mm)
  length_max <- max(sdata$length_mm)
  
  # Record average and maximum length in dataframe
  length.stats$length_avg[i] <- length_avg
  length.stats$length_max[i] <- length_max
  
}

# Sort data frame by length_avg
length.stats <- length.stats[with(length.stats, order(length_avg)), ]

# THE DPLYR PACKAGE
################################################################################

# Calculate average and maximum length by species using dplyr
length.stats1 <- as.data.frame(
  data %>%
    filter(species%in%spp) %>%
    group_by(species) %>%
    summarize(n=length(length_mm),
              length_avg=mean(length_mm),
              length_max=max(length_mm),
              length_min=min(length_mm)) %>%
    arrange(desc(length_max))
)

# Calculate average and maximum length by species and sex using dplyr
length.stats2 <- as.data.frame(
  data %>%
    filter(species%in%spp & sex%in%c("M", "F")) %>%
    group_by(species, sex) %>%
    summarize(n=length(length_mm),
              length_avg=mean(length_mm),
              length_max=max(length_mm),
              length_min=min(length_mm))
)


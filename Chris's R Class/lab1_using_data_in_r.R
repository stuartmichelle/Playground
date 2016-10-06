
# In this script, we'll learn to read, manipulate, and plot data!

# Read data
##########################################

# Read CSV file using read.csv()
data <- read.csv("mongolia_fish_data.csv")

# read.table skip= # of lines to skip - explore this more for qubit and plate reader outputs




# Inspect data
##########################################

# Inspect data
# str(), head(), tail(), nrow(), ncol(), colnames()
str(data)
head(data)
tail(data)
nrow(data)
ncol(data)
colnames(data)

# Reduce data to important columns 
# ID, year, water body, species, age, length, weight, sex, egg count
data1 <- subset(data, select = c(sample_id, year, water_body, species_name, age_otolith, tl_mm, weight_g, sex, egg_count))



# Inspect data again
# Inspect species names
str(data1)
unique(data1$species_name)

# Subset data with []'s and $'s
# Look at all the taiman
data2 <- data1[data1$species_name == "taimen", ]
data3 <- data1[data1$species_name == "taimen" & data1$tl_mm > 800 & !is.na(data1$tl_mm), ]



# Subset data with subset()
# Some common logic statements: 
# ==, !=, >=, <=, >, <, %in%, is.na(), !is.na(), &, |





# EXERCISE BREAK
##########################################

# Subset burbot data with both length and weight measurements
# using []s and $s and using subset()




# Subset a vector of egg counts for Hovsgol grayling (grayling-Hovsgol)
# Hint: You can use na.omit() to eliminate NA values




# Summarize data
##########################################

# Summary statistics
# sum(), mean(), median(), quantile(), summary(), boxplot()





# Add columns to data
##########################################

# Add total length in cm to data (tl_cm)




# Export data
##########################################

# Export cleaned data using write.csv()



# Plot data
##########################################

# Plot Hovsgol grayling length and weight


# On your own, try to make as pretty a plot as possible!
# Search online about the different arguments used in the plot function











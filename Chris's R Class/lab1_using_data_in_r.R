
# In this script, we'll learn to read, manipulate, and plot data!

# Read data
##########################################

# Read CSV file using read.csv()
data <- read.csv("Chris's R Class/mongolia_fish_data.csv")

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
data4 <- data1[data1$species_name == "taimen" & data1$tl_mm > 800, ]
data3 <- data1[data1$species_name == "taimen" & data1$tl_mm > 800 & !is.na(data1$tl_mm), ]

# Subset data with subset()
# Some common logic statements: 
# ==, !=, >=, <=, >, <, %in%, is.na(), !is.na(), &, |
data2 <- subset(data1, species_name == "taimen")
data3 <- subset(data1, species_name == "taimen" & tl_mm > 800) # can't loop, don't have to include the !is.na qualifier



# EXERCISE BREAK
##########################################

# Subset burbot data with both length and weight measurements
# using []s and $s and using subset()
burbot1 <- data1[data1$species_name == "burbot" & !is.na(data1$tl_mm) & !is.na(data1$weight_g), ]

burbot2 <- subset(data1, species_name == "burbot" & !is.na(tl_mm) & !is.na(weight_g))

burbot3 <- subset(data1, species_name == "burbot" & tl_mm & weight_g)



# Subset a vector of egg counts for Hovsgol grayling (grayling-Hovsgol)
# Hint: You can use na.omit() to eliminate NA values

grayling <- c(na.omit(subset(data1, species_name == "grayling-Hovsgol", egg_count)))  # this is the wrong answer, it makes a list instead of a vector

grayling <-c(na.omit(data1$egg_count[data1$species_name == "grayling-Hovsgol"]))

class(grayling) # should be integer

# Summarize data
##########################################

# Summary statistics
# sum(), mean(), median(), quantile(), summary(), boxplot()
sum(grayling)
mean(grayling)
median(grayling)
quantile(grayling)
summary(grayling)
boxplot(grayling)


# Add columns to data
##########################################

# Add total length in cm to data (tl_cm)

data1$tl_cm <- data1$tl_mm/10


# Export data
##########################################

# Export cleaned data using write.csv()
write.csv(data1, file = "mongolia_fish_data_cleaned.csv", row.names = F)


# Plot data
##########################################

# Plot Hovsgol grayling length and weight
plot(weight_g ~ tl_cm, data1)

# get just grayling
plot(weight_g ~ tl_cm, data1, subset = species_name == "grayling-Hovsgol")

# remove box
plot(weight_g ~ tl_cm, data1, subset = species_name == "grayling-Hovsgol", bty="n") 

# flip y axis labels into reading direction (las=1) and x labels to vertical(las=2)
plot(weight_g ~ tl_cm, data1, bty="n", las = 1, las = 2, subset = species_name == "grayling-Hovsgol") 


# plot(y ~ x, datasource)
# On your own, try to make as pretty a plot as possible!
# Search online about the different arguments used in the plot function


x-axis, y axis limits, labels, point color, size, shape, main title

# bty = n gets rid of the box around the outside of the plot
# las = 1 makes y axis labels horizontal
# las = 2 makes x axis labels vertical
# col = "dark blue" makes points dark blues
# pch = 8 makes the points star shaped

plot(weight_g ~ tl_cm, data1, bty="n", las = 1, las = 2, col = "dark blue", 
     subset = species_name == "grayling-Hovsgol", 
     main = "Hovsgol grayling weight by length",
     xlab = "length of fish (cm)", ylab = "weight of fish (g)", xlim = c(10,50), 
     ylim = c(0,500), pch = 8) 







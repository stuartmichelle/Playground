
# In this script, we'll learn to read, manipulate, and plot data!

# Read data
##########################################

# Read CSV file using read.csv()
data <- read.csv("mongolia_fish_data.csv")


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
colnames(data)
data <- subset(data, select=c(sample_id, year, water_body, species_name, 
                              age_otolith, tl_mm, weight_g, sex, egg_count))

# Inspect data again
# Inspect species names
str(data)
unique(data$species_name)
sort(unique(data$species_name))

# Subset data with []'s and $'s
data[data$species_name=="taimen",]
data[data$species_name=="taimen" & data$tl_mm>=500,]
data[data$species_name=="taimen" & data$tl_mm>=500 & !is.na(data$tl_mm),]
data[data$species_name=="taimen" & data$tl_mm>=500 & !is.na(data$tl_mm),6:7]
data$tl_mm[data$species_name=="taimen" & data$tl_mm>=500 & !is.na(data$tl_mm)]

# Subset data with subset()
# Some common logic statements: 
# ==, !=, >=, <=, >, <, %in%, is.na(), !is.na(), &, |
subset(data, year==2012)
subset(data, species_name=="taimen")
subset(data, species_name=="taimen" & tl_mm>=500)
subset(data, species_name=="taimen" & water_body%in%c("Eg", "Uur"))


# EXERCISE BREAK
##########################################

# Subset burbot data with both length and weight measurements
# using []s and $s and using subset()
subset(data, species_name=="burbot" & !is.na(tl_mm) & !is.na(weight_g))


# Subset a vector of egg counts for Hovsgol grayling (grayling-Hovsgol)
# Hint: You can use na.omit() to eliminate NA values
egg_counts <- c(na.omit(data$egg_count[data$species_name=="grayling-Hovsgol"]))


# Summarize data
##########################################

# Summary statistics
# sum(), mean(), median(), quantile(), summary(), boxplot()
sum(egg_counts)
mean(egg_counts)
median(egg_counts)
quantile(egg_counts, probs=0.75)
quantile(egg_counts, probs=c(0.05, 0.95))
quantile(egg_counts, probs=seq(0,1,0.25))
summary(egg_counts)
boxplot(egg_counts)


# Add columns to data
##########################################

# Add total length in cm to data (tl_cm)
data$tl_cm <- data$tl_mm / 10


# Export data
##########################################

# Export cleaned data using write.csv()
write.csv(data, "mongolia_fish_data_clean.csv", row.names=F)


# Plot data
##########################################

# Plot Hovsgol grayling length and weight
plot(weight_g ~ tl_cm, subset=species_name=="grayling-Hovsgol", data)

# On your own, try to make as pretty a plot as possible!
# Search online about the different arguments used in the plot function
plot(weight_g ~ tl_cm, subset=species_name=="grayling-Hovsgol", data,
     bty="n", las=1, xlim=c(0,50), ylim=c(0,600), col="grey60",
     xlab="Weight (g)", ylab="Total length (cm)")







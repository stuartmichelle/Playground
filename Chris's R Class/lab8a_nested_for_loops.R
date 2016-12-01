# Section 8 - Double Loops
################################################################################
install.packages("RColorBrewer")
library(dplyr)
library(RColorBrewer)

# Read in Data
################################################################################

# setwd("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop")
data<-read.csv("Chris's R Class/mongolia_fish_data.csv", as.is = T)

#Format Dates
data$date<-as.Date(data$date,format = "%m/%d/%Y")


# How a Double Loop Works
################################################################################

#With just one loop
for (i in 1:5){
  print(i)
}

#With two
for (i in 1:5){
  for(j in 1:5){
    print(c(i,j))
  }
}

# a better thing to do for a table
mat <- expand.grid(1:5, 1:5)
mat
# A Bad Example of A Double Loop - Then How to Properly Do it
################################################################################

#### Your Goal: Make a Matrix of mean fish length by water body and by species

# Make a Vector of water bodies and species - find unique species names and sort them alphabetically
spp <- sort(unique(data$species_name))[-1] #there is a blank so -1 is removing the first element
body <- sort(unique(data$water_body))[-1]

# Make a matrix whose rows are species and whose columsn are water bodies
  # Make an empty space to fill, fill w/ NAs, have to name the rows and columns in order for the subset to work
leng <- matrix(NA, nrow = length(body), ncol = length(spp))
row.names(leng) <- body
colnames(leng) <- spp

# Make a double loop to fill in every combination of spp and body
  # i refers to row ids "for all water bodies" and j refers to column ids "for all speices"
for (i in 1:length(body)){
  for(j in 1:length(spp)){
    # t turns column into vector, c might do the same thing, Chris says we don't even need it because mean takes the mean of all values in df, and since we want the mean of everything, it is ok that it is in df format.
    X <- t(subset(data, species_name == spp[j] & water_body == body[i], select = tl_mm))
    leng[i,j] <- mean(X, na.rm = T)
    
  }
}

#### This works fast for small datasets, but with bigger one's it's very slow

#Make a "key" with the pairs of species and water body, needs 2 vectors
# expand.grid(vector1_name = vector you made above, vector_2_name = other vector you made above)
# expand.grid makes all of the unique combinations between 2 vectors
key <- expand.grid(species = spp, wbody = body)

# sort the dataframe using order - using reshape2 package, arrange is "easier"
key <- key[order(key$species, key$wbody), ]

#Can use a loop - go through each row of the key
for (i in 1:nrow(key)){
  A <- t(subset(data, species_name == key$species[i] & water_body == key$wbody[i], select = tl_mm))
  key$tl.bar[i] <- mean(A, na.rm = T)
}
key <- na.omit(key) # gets rid of all NaN rows
#Or Just use dplyr


# A Good Example of A Double Loop
################################################################################

#### Your Goal: Plot A multipanel figure of timeseries of different species caught
#### at 4 water bodies

#Choose the species and water bodies
body<-c('Hovsgol','Uur','Eg')
spp<-c('taimen','spiny loach','Phoxinus','lenok','grayling-Arctic', 'grayling-Hovsgol','grayling-unknown','burbot')

#Choose colors to represent the time series for each species
cols <- brewer.pal(8, "Set1")

#A Vector of Y limits - because different water bodys had different fishing efforts
ylims <- c(750, 200, 100)

#Make Loop: First Loop subsets by water bodya and makes a plot space
# Second loop fills in time series
# because we only have 3, going to use layout to make 2 on top and 1 centered on teh bottom

# we want a figure to look like
# 1 1 2 2
# 0 3 3 4
# Where 1, 2, and 3 are figures and 4 is a legend, 0 creates a blank space
layout (matrix(c(1,1,2,2,0,3,3,4), nrow = 2, byrow = T))

# make a data frame date, species name, and number of fish caught, subset that for each species, aggregating the datas
# first loop is going to make a water body, 2nd loop is going to take out each speices and plot them
for (i in 1:3){
  A <- as.data.frame(
    data %>%
      filter(water_body == body[i] & !is.na(date)) %>%
      group_by(date, species_name) %>%
      summarize(n = length(tl_mm)) #aggregating function of how many fish were caught in general
  )
}

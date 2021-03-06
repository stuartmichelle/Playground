#################################################################
# R Course - Week 5 - Intermediate Plotting
#################################################################

# 1) Par Functions
# 2) Multi-panel Plots
# 3) RColorBrewer
# 4) Random Number Generation
# 5) Trendlines
# 6) Confidence Intervals

#################################################################
#################################################################

install.packages("RColorBrewer", "GISTools")


y
#################################################################
# 1) Par Functions
#################################################################

#### Margins mar() - Default c(5.1, 4.1, 4.1, 2.1)####
plot(1:10, 1:10)
par(mar = c(4,3,3,1))
plot(1:10, 1:10)
#### Plot Size pin() -  #### plot inches width, height
par(pin = c(3,5))
plot(1:10, 1:10)
#### Axis Labels mgp() - Default c(3,1,0)#### how close the axis title is, how close the tick label is, how close the actual tick mark is
#reset plot paramter and plot space

#First value changes axis labels
dev.off()
plot(1:10, 1:10)

par(mgp = c(2, 1, 0))
plot(1:10, 1:10)

#Second tick labels
par(mgp = c(2, 0.5, 0))
plot(1:10, 1:10)

#Third tick marks
par(mgp = c(2, 0.5, 1))
plot(1:10, 1:10)

#### Outer Margin oma() - Default c(2,2,2,2) - tight multipanel figure, gives room for a y axis label
par(oma=c(4,4,4,4))
plot(1:10, 1:10)

#### Reset par by dev.off() ####
dev.off()

#################################################################
# 2) Multi-Panel Plots
#################################################################

#### mfrow() - Number of rows & cols. in plots ####, mfcol does the same by columns
par(mfrow = c(2,2))
plot(1:10, 1:10)
plot(1:10, 1:10)
plot(1:10, 1:10)
plot(1:10, 1:10)

#### Problem: Create a 2x2 plot of Length-Weight Relationship
#### for 4 species. 
dev.off()
# Start with code for single plot
data <- read.csv("Chris's R Class/mongolia_fish_data.csv")

#one species
lenok <- subset(data, species_name == "lenok", select= c(tl_mm, weight_g))

plot(lenok[ , 1], lenok[ , 2])
plot(lenok$tl_mm, lenok$weight_g)

#Make list of species names for subset and plots
summary(data$species_name)
spp <- c("lenok", "burbot", "grayling-Hovsgol", "Phoxinus")
titles <- c("Lenok", "Burbot", "Grayling-Hovsgol", "Phoxinus")

#Create loop of plots
# test i <- 1
par(mfrow = c(2,2), mar = c(3,4,2,1))
par(mfrow = c(2,2))
for (i in 1:4){
  X <- subset(data, species_name == spp[i], select = c(tl_mm, weight_g))
  plot(X$tl_mm, X$weight_g, main = titles[i])
}

# change ylim by 10%
par(mfrow = c(2,2), mar = c(3,4,2,1))
for (i in 1:4){
  X <- subset(data, species_name == spp[i], select = c(tl_mm, weight_g))
  plot(X$tl_mm, X$weight_g, main = titles[i], ylim = c(0, max(X[,2], na.rm = T)))
}

#### layout() - Organization of plot #### matrix input - multipanel figure where all panels are not the same size - plot a grid over your layout and then assign numbers to each box of the grid, plot will fill the space for the numbers assigned - heights = c(0.7, 0.3) the top will get 70% of the space and the bottom row will get 30% ### LAYOUT REPLACES THE PAR(MFROW()) code from above

dev.off()

# make matrix

#all in one column
matrix(1:10)

# in 2 rows filled in by column
matrix(1:10, nrow = 2)

# in 2 rows filled in by row
matrix(1:10, nrow = 2, byrow = T)

# sample layout of plots
matrix(1:4, nrow = 2, byrow = T)

#  OUTPUT
# [,1] [,2]
# [1,]    1    2
# [2,]    3    4

layout(mat = matrix(1:4, nrow = 2, byrow = T))
for (i in 1:4){
  X <- subset(data, species_name == spp[i], select = c(tl_mm, weight_g))
  plot(X$tl_mm, X$weight_g, main = titles[i], ylim = c(0, max(X[,2], na.rm = T)))
}

# if dev.off() isn't working, graphics.off() might help

#### Exercise 1 - Create a plot with length-weight scatter plots for Lenok and Burbot on the bottom and a wide length histogram of both species together above
spp1 <- c("lenok", "burbot")
titles1 <- c("Lenok", "Burbot")

layout(mat = matrix(c(1, 1, 2, 3), nrow = 2, byrow = T))

  Y <- subset(data, species_name == "lenok", select = c(species_name, tl_mm))
  hist(Y$tl_mm, col = rgb(1,0,0,0.5), main = "freq of Lenok and Burbot lengths")
  Z <- subset(data, species_name == "burbot", select = c(species_name, tl_mm))
  hist(Z$tl_mm, add = T, col = rgb(0,1,0,0.5))

  X <- subset(data, species_name == "lenok", select = c(tl_mm, weight_g))
  plot(X$tl_mm, X$weight_g, main = "Lenok", ylim = c(0, max(X[,2], na.rm = T)), col = rgb(1,0,0,0.5))
 
  W <- subset(data, species_name == "burbot", select = c(tl_mm, weight_g))
  plot(X$tl_mm, X$weight_g, main = "Burbot", ylim = c(0, max(X[,2], na.rm = T)), col = rgb(0,1,0,0.5))




#################################################################
# 3) rColorBrewer
#################################################################
# check out the website
library(RColorBrewer)
# View all potential Color Palettes
dev.off()
display.brewer.all()

# Select a Color Palette
reds <- brewer.pal(n = 5, "YlOrRd")
display.brewer.pal(n = 9, "YlOrRd")
reds <- brewer.pal(n = 5, "Reds")
display.brewer.pal(n = 5, "Reds")

# Interpolate a Color Palette - smooth
redsnext <- colorRampPalette(brewer.pal(n = 5, name = "Reds"))(100)
plot(1:20, 1:20, pch = 16, cex=30, col = redsnext) # make the 100 above a 20 for this one
plot(1:100, rep(1,100), pch = 15, cex = 50, col = redsnext)
#################################################################
# 4) Random Numbers - Useful for making up data to test things
#################################################################

#### Many types of probability distributions to generate numbers ####

# Uniform (any number between A and B)

# Normal (has a mean and variance)


# Binomial (Either-OR)

# Randomly sample from set of numbers

#################################################################
# 5) Trendlines & Linear Models with lm()
#################################################################

#### Linear Fits ( Y = ax + b )####

#Generate fake data with noise

#Fit a linear model to fake data

#Plot Regression LIne

# Alternatively with just abline()

#### Polynomial Fits ( Y = ax^2 + bx + c) ####

#Make some fake data with noise (Nothing in our data is quadratic)

#Fit quadratic Model

#Plot Fitted model

#Alternatively

####Excersize 2: Fit an exponential model to Lenok Length Weight Data
#### Use an exponential model.
#### Hint: Log transform data and use a linear model (a*X^b == log(a)+b*log(X))

#################################################################
# 6) Confidence Intervals
#################################################################

#### Calculating ####

#Using confint() - Works on a lm object

#Using predict() - Also on a lm

#### Plotting ####

#Using solid lines w/ confint()

#Using filled shape w/polygon(),seq(), and confint()

#### Excersize 3: Plot a 2x2 plot of 4 species using a for loop.
#### Add a exponential regression line with color-coded confidence intervals
#### use colorBrewer to choose nice colors




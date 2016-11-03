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

#### Plot Size pin() -  #### plot inches width, height
par(pin = c(3,5))

#### Axis Labels mgp() - Default c(3,1,0)####
#reset plot paramter and plot space
dev.off()


#First value changes axis labels

#Second tick labels

#Third tick marks


#### Outer Margin oma() - Default c(2,2,2,2)


#### Reset par by dev.off() ####

#################################################################
# 2) Multi-Panel Plots
#################################################################

#### mfrow() - Number of rows & cols. in plots ####

#### Problem: Create a 2x2 plot of Length-Weight Relationship
#### for 4 species. 

# Start with code for single plot

#Make list of species names for subset and plots

#Create loop of plots


#### layout() - Organization of plot ####


#### Exercise 1 - Create a plot with length-weight scatter plots for Lenok and Burbot
#### on the bottom and a wide length histogram of both species together above

#################################################################
# 3) rColorBrewer
#################################################################

# View all potential Color Palettes

# Select a Color Palette

# Interpolate a Color Palette

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




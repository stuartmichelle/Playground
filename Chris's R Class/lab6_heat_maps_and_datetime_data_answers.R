
# install.packages("shape")
# install.packages("colorRamps")

# READ DATA
################################################################################

# Clear workspace
rm(list = ls())

# Packages
library(shape) # colorlegend()
library(colorRamps) # blue2red()

# Read temperature data
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


# PLOTTING A HEAT MAP
################################################################################

# Format data
# this line reverses the data???
b <- t(apply(temp.data, 2, rev))

min.date <- min(temp.dates.all)
max.date <- max(temp.dates.all)
min.date.data <- min(temp.dates.data)
max.date.data <- max(temp.dates.data)

# Plot matrix
image(x=temp.dates.all, y=0:50, z=b, bty="n", 
      xlab="Date", ylab="Depth (m)")

# Add custom color bar
breaks <- 0:15
colors <- blue2red(length(breaks)-1)
image(x=temp.dates.all, y=0:50, z=b, bty="n", 
      xlab="Date", ylab="Depth (m)", col=colors)

# Improve x-axis and y-axis labels
image(x=temp.dates.all, y=0:50, z=b, bty="n", xaxt="n", yaxt="n",
      xlab="Date", ylab="Depth (m)", col=colors)
axis.Date(1, at=seq(min.date, max.date, by="1 mon"), cex.axis=0.85)
axis(side=2, at=seq(0, 50, 5), labels=rev(seq(0, 50, 5)), las=1, cex.axis=0.9)

# Plot temperature legend
colorlegend(col=colors, zlim=c(min(breaks), max(breaks)), 
            zlevels=length(breaks), dz=1, main="Temp (°C)", main.cex=0.8, cex=0.7)




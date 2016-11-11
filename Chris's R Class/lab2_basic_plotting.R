################################################################
# Week 2 - Plotting in R
# Goals - 1) Construct and format basic scatter plots in R
#         2) Append plots with shapes and text
#         3) Export plots to desired file type
#         4) Explore the basics of other plot types



# Read and Subset Mongolia Fish Data from Week 1
################################################################

#make new data frame with only the lengths,weights, and age of Lenok
data <- read.csv("Chris's R Class/mongolia_fish_data.csv")

data.lenok <- subset(data, species_name == "lenok", select = c(tl_mm, weight_g))

colnames(data.lenok) <- c("length", "weight")

# Make a scatter plot
################################################################

#make a basic default scatter plot of length and weight

plot(x = data.lenok$length, y = data.lenok$weight)

##edit the "type" argument (p = points, l = lines, b = both, and n = null)

plot(x = data.lenok$length, y = data.lenok$weight, type = "p")

#Formating a scatter plot
################################################################

#Editing axis text and main title
#################

#x labels
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length")

#y labels
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight")

#main title
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight")

#Editing axis limits
#################

#x axis limits
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700))

#y axis limits
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000))

#Editing point parameters
#################
#point type - here is a list of the character types, cex shrinks or expands point by factor - pch
plot(1:25, rep(1,25), pch = 1:25)


# cex makes the dots a bit smaller or larger
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5)

#point color
#by default color id's
plot(1:8, rep(1,8), col = 1:8, pch = 16)

plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = 2)

#by named colors - google r colors select the pdf, packages for customizing colors
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")

#by rgb function
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = rgb(red = 1, green = 0, blue = 0.5))

#by hexidecimal id
rgb(red = 1, green = 0, blue = 0.5)

plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "#FF0080")


#point size - cex


#Appending Plot
###############################################################

#Polygons
####################

#polygon function - Needs coordinates of corners
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "pink")

# make x coordinates of polygon
poly.x <- c(250, 250, 450, 450)
# make y coordinates of polygon
poly.y <- c(0, 2000, 2000, 0)

# draw the polygon
polygon(x = poly.x, y = poly.y)


#rectangle function - Also needs corners but not in vector
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")

rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000)

#Add color and transparency with 'alpha'
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")

# alpha adds transparency
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
# solid rectangle
# rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = "coral")

#Lines
######################

#abline (y=ax+b) - makes horizontal, vertical or slanted lines
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))

# add a horizontal line at 0, can enter your formula for regression line
abline(h = 0)


#lines - needs vectors for x and y
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))

# do the same thing as abline
lines(x = 1:700, y = rep(1,700))

#curve - need a function in terms of x and a start and end, add = T to add to your existing plot
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))

curve(expr = 0 * x, from = 0, to = 700, add = T)


#Formatting Lines
########################

#line width - lwd = some number
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2)

#line type - lty = number 1 to 8 or 6?
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2)


#line color
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2, col = "grey50")


#Adding Text
##########################

#Text function - Text within plot
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "Lenok Length vs. Weight", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2, col = "grey50")
text(x = 350, y = 1800, label = "Legal Size")

#Mtext Function - Text outside of plot
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2, col = "grey50")
text(x = 350, y = 1800, label = "Legal Size")
mtext("Lenok Length vs. Weight", side = 3, line = 0.5) # side 3 points to top, line = how far off the top

# Chris's personal preferences
# bty = "n" suppresses box around plot
# las = direction of axis labels (vertical, horizontal)

#Custom Axes
################################################################################

#Use yaxt or xaxt to NOT plot axis ticks 
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3", yaxt = "n", bty = "n", las = "1")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2, col = "grey50")
text(x = 350, y = 1800, label = "Legal Size")
mtext("Lenok Length vs. Weight", side = 3, line = 0.5)

#Use "axis" function to make your own ticks
plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3", yaxt = "n", bty = "n", las = "1")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2, col = "grey50")
text(x = 350, y = 1800, label = "Legal Size")
mtext("Lenok Length vs. Weight", side = 3, line = 0.5)
axis(side = 2, at = seq(0,2000,100), labels = F)

#Only label some ticks - 2 Overlapping Axes
axis(side = 2, at = seq(0,2000,500), labels = T) # to make a bold tick


#Export Plot - 2 ways
###########################################################################

#In R Studio click on the export button above the figure and save in desired size and format

#Within a script - Open with  (png, jpeg, bmp, tiff ) close with dev.off()

plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3", yaxt = "n", bty = "n", las = "1")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2, col = "grey50")
text(x = 350, y = 1800, label = "Legal Size")
mtext("Lenok Length vs. Weight", side = 3, line = 0.5)

#Use "axis" function to make your own ticks
png(filename = "Chris's R Class/Lenok_Length_Weight.png", width = 1000, height = 750, units = "px")

c

dev.off()
#################################################################################
#Exercise 1:
#Add another species length and weight using the points() function. Format the points so they can be distinguished from lenok and add a made-up legal size box to it. Save it as a jpeg when you're done.



#BONUS CHALLENGE: Try to add a right-side axis for the other species using "par(new=T)" then plot() then axis()
#so that both take up the same height


#Answer 


#Bonus


#Adding a Legend
#################################################################################

##Remove Legal Size Text and Make a Legend with names, colors, and shapes
data.grayling <- subset(data, species_name == "grayling-Hovsgol", select = c(tl_mm, weight_g))
colnames(data.grayling) <- c("length", "weight")

plot(x = data.lenok$length, y = data.lenok$weight, type = "p", xlab = "Length", ylab = "Weight", main = "", xlim = c(0,700), ylim = c(0, 2000), pch = 16, cex = 0.5, col = "red3", yaxt = "n", bty = "n", las = "1")
rect(xleft = 250, ybottom = 0, xright = 450, ytop = 2000, col = rgb(1, 0, 0.1, alpha = 0.25))
abline(h = 0, lwd = 2, lty = 2, col = "grey50")
text(x = 350, y = 1800, label = "Legal Size")
mtext("Length vs. Weight", side = 3, line = 0.5)
axis(side = 2, at = seq(0,2000,100), labels = F)
axis(side = 2, at = seq(0,2000,500), labels = T)

points(data.grayling$length, data.grayling$weight, pch = 16, col = "green4", cex = 0.5)

# add legend
legend("topleft", legend = c("Lenok", "Grayling"), fill = c("red3", "green4"), cex = 0.75, bty = "n")



#################################################################################
#Other Plot Types
#################################################################################

#Histograms - Frequency Distributions
##############################

#Plotting a histogram
brk <- seq(0,700,50)
hist(data.lenok$length, breaks = brk, ylim = c(0,200))
hist(data.grayling$length, breaks = brk, add = T)


#saving hist() as an object for frequencies
X <- hist(data.lenok$length, breaks = brk, ylim = c(0,200), plot = F)
str(X)

#Boxplots - Box-and-Whisker - See data distribution
################################

#Single vector
boxplot(data.lenok$length)

#Multiple uneven vectors (when you don't have a matrix)
boxplot(list(data.grayling$length, data.lenok$length))

#Barplots - Single Values across categories
################################
#One group
lenok.means <- colMeans(data.lenok, na.rm = T)
barplot(lenok.means)

#Two groups stacked
grayling.means <- colMeans(data.grayling, na.rm = T)

# t = transpose (groups them properly), cbind to make a matrix 
barplot(t(cbind(lenok.means, grayling.means)))

#OR side by side

barplot(t(cbind(lenok.means, grayling.means)), beside = T, names = c("Length (mm)", "Weight (g)"))

#Adding a legend
barplot(t(cbind(lenok.means, grayling.means)), beside = T, names = c("Length (mm)", "Weight (g)"), legend.text = c("Lenok", "Grayling"))


#Excersize 2 
#Plot a histogram of the weight distribution of 3 species so that all can be seen.
#Add a legend that shows what the colors mean. Format the axes.
#BONUS CHALLENGE: add vertical, colorcoded, non-solid lines showing the mean and median for each species
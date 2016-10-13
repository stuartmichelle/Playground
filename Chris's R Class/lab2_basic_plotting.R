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

data.lenok <- subset(data, species_name == "lenok", select = c("tl_mm", "weight_g"))

# Make a scatter plot
################################################################

#make a basic default scatter plot of length and weight


##edit the "type" argument (points, lines, both, and null)

#Formating a scatter plot
################################################################

#Editing axis text and main title
#################

#x labels

#y labels

#main title

#Editing axis limits
#################

#x axis limits

#y axis limits

#Editing point parameters
#################

#point type


#point color

#by default color id's

#by named colors

#by rgb function

#by hexidecimal id

#point size


#Appending Plot
###############################################################

#Polygons
####################

#polygon function - Needs coordinates of corners


#rectangle function - Also needs corners but not in vector


#Add color and transparency with 'alpha'

#Lines
######################

#abline (y=ax+b) - makes horizontal, vertical or slanted lines


#lines - needs vectors for x and y


#curve - need a function in terms of x and a start and end


#Formatting Lines
########################

#line width


#line type


#line color


#Adding Text
##########################

#Text function - Text within plot


#Mtext Function - Text outside of plot

#Custom Axes
####################################################################################

#Use yaxt or xaxt to not plot axis ticks 


#Use "axis" function to make your own ticks


#Only label some ticks - 2 Overlapping Axes


#Export Plot - 2 ways
###########################################################################

#In R Studio click on the export button above the figure and save in desired size and format

#Within a script - Open with  (png, jpeg, bmp, tiff ) close with dev.off()


####################################################################################################################
####################################################################################################################

#Exercise 1:
#Add another species length and weight using the points() function. Format the points so they can be distinguished
#from lenok and add a made-up legal size box to it. Save it as a jpeg when you're done.

#BONUS CHALLENGE: Try to add a right-side axis for the other species using "par(new=T)" then plot() then axis()
#so that both take up the same height


#Answer 


#Bonus


#Adding a Legend
####################################################################################

##Remove Legal Size Text and Make a Legend with names, colors, and shapes

#################################################################################################
#Other Plot Types
##################################################################################################

#Histograms - Frequency Distributions
##############################

#Plotting a histogram

#saving hist() as an object for frequencies


#Boxplots - Box-and-Whisker - See data distribution
################################

#Single vector

#Multiple uneven vectors

#Barplots - Single Values across categories
################################

#One group

#Two groups

#OR

#Adding a legend

#Excersize 2 
#Plot a histogram of the weight distribution of 3 species so that all can be seen.
#Add a legend that shows what the colors mean. Format the axes.
#BONUS CHALLENGE: add vertical, colorcoded, non-solid lines showing the mean and median for each species
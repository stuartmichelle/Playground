install.packages("tidyverse")

library(tidyverse)

# load the mpg data frame ##########################
mpg <- ggplot2::mpg

# plot the data displ (engine size) & hwy (highway mileage) to see if hwy is dependent on displ ####################################
ggplot(data = mpg) + # create an empty graph on which to add layers
  geom_point(mapping = aes(x= displ, y = hwy)) # geom_point adds a layer of points, creating a scatterplot #mapping is always paired with aes(x,y), ggplot looks for the x & y in the data= variable.

####################### graphing template ####################
ggplot(data = <DATA>) +
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>)) #where mappings is your x & y variables

# Exercises ########################
ggplot(data = mpg) # what do you see? Blank plot window
nrow(mtcars) # how many rows?  32
?mpg # what does the drv variable describe? front, rear, or 4 wheel drive
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=cyl, y=hwy)) # make a scatterplot of hwy vs cyl
ggplot(data = mpg) +
  geom_point(mapping = aes(x=drv, y=class)) # not useful because the info is all over the place

# Add aesthetics (colors and shapes) ###############

# Color ##############
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, color = class)) # add color based on class of vehicle; scaling is how ggplot decides which color to assign.

# Size #############
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size = class)) # base the size of the point on class of vehicle, we get a warning that this is not advised

# Alpha - transparency ###############
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha = class))

# Shape #############
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape = class)) # SUVs disappear because shape can only handle 6 shapes at a time and we have 7 classes of cars.

# Manually set aesthetics #############
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy), color = "blue")

# Manual shapes ##############
# R has 25 built in shapes that are identified by numbers. There are some seeming duplicates: for example, 0, 15, and 22 are all squares. The difference comes from the interaction of the colour and fill aesthetics. The hollow shapes (0–14) have a border determined by colour; the solid shapes (15–18) are filled with colour; the filled shapes (21–24) have a border of colour and are filled with fill

# Exercises ##############
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha = class, color = class, shape = class))
# what happens if you map the same variable to multiple aesthetics?  They are all applied

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, color = class), stroke = 1, shape = 21)
# what does stroke do?  Sets the border width on shapes (can act as a size for shapes)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, color = displ < 5))
# what happens if you map to a value instead of a variable name?  True false by color.

# Facets - subplots ################
# facet-wrap - make 2 rows of subplots, broken up by one variable ##########
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2) # each plot is by class

# facet-grid - make a set subplots, broken up by two variables ##########
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) # one axis is subplots is drv and the other is cyl

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl) # subplots by column 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ .) # subplots by row

# Exercises ############################
# what happens if you faced a continuous variable? It makes a separate plot for each value
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty) # each plot is by class





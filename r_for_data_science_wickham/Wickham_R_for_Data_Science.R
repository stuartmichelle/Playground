# install.packages("tidyverse")

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
# what do the empty cells mean and how do they relate to this plot? Empty cells are where data is missing for a non-continuous variable.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# What plots does the following code make? What does . do? . allows you plot via row or column

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# Take the first faceted plot in this section:
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# What are the advantages to using faceting instead of the colour aesthetic? It makes the data very obvious by class
  # What are the disadvantages? It is more difficult to compare between classes
  # How might the balance change if you had a larger dataset? It might make it easier to compare between classes
  
# Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of the individual panels? Why doesn’t facet_grid() have nrow and ncol variables? nrow and ncol set the number of rows and columns for your plots. Facet grid doesn't have those because it makes an even distribution.
  ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    facet_wrap(c("cyl", "drv"), labeller = "label_both")
  ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    facet_wrap(~class, scales = "free")
  ggplot(economics_long, aes(date, value)) +
    geom_line() +
    facet_wrap(~variable, scales = "free_y", nrow = 2, strip.position = "bottom") +
    theme(strip.background = element_blank(), strip.placement = "outside")
  
  # When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?  Easier to look at? IDK
  
# Geometric Objects #####
  ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy))
  # linetype #####
  ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
# multiple geoms, one plot ######
  ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    geom_smooth(mapping = aes(x = displ, y = hwy))
# global mapping - apply data to all plots ####
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth()
  
# local mapping - overwrite global for this geom only  ####
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color = class)) + 
    geom_smooth()
  
  # show just one type of data on one of the plots compared to all data on another
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color = class)) + 
    geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) # se displays confidence interval
# Exercises ####
  # What geom would you use to draw a line chart?geom_line/ A boxplot?geom_boxplot/ A histogram?geom_histogram/An area chart?geom_area
  huron <- data.frame(year = 1875:1972, level = as.vector(LakeHuron))
ggplot(huron, aes(year)) +
  geom_ribbon(aes(ymin=0, ymax=level))+
  geom_area(aes(y = level))

# run this code in your head, how will it look - it won't have the grey confidence intervals around the line
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
  
# what does show.legend=FALSE do? removes the legend
# will these 2 plots look different? NO
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# recreate the R code necessary to make these graphs
# 1
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth(se=FALSE)
# 2
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv), se = FALSE)
# 3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
# 4
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE)
# 5
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), se = FALSE)
# 6 - the points have large white borders, not sure how to do it.
ggplot(mpg, aes(displ, hwy)) +
  geom_point(shape = 21, colour = "white", fill = drv, stroke = 3)

# Statistical transformations #####
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
# geom_bar uses stat count to count how much data is in each of the categories and build a bar chart, stat count wll do the same thing
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
# the above bar chart is generated by counting rows, but you might want a bar chart with y values that are present in the data set
demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = a, y = b), stat = "identity")
# chart based on proportion or percent
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# stat summary ####
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
    )
# Exercises ####
# What is the default geom associated with stat_summary()? How could you rewrite the previous plot to use that geom function instead of the stat function? geom_histogram
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = cut))

# What does geom_col() do? How is it different to geom_bar()? geom_bar is count of data and geom_col is height of data 

# Most geoms and stats come in pairs that are almost always used in concert. Read through the documentation and make a list of all the pairs. What do they have in common?

# What variables does stat_smooth() compute? What parameters control its behaviour? standard error, method

# In our proportion bar chart, we need to set group = 1. Why? In other words what is the problem with these two graphs?

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..)) # fair is 100% of fair, have to say they are all a proportion of the same group
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
# position adjustments ######
# a bar chart with colored outline
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
# a bar chart with colored bars
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# fill the bar with another variable
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# place objects where they fall in the context of the graph = identity (less useful for bars and more useful for points)
# transparent to see the overlaps
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
# clear to see the overlaps
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

# fill to compare proportions across groups
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
# dodge to place overlapping objects beside each other for easier comparison among individuals
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# overplotting - where more than one point overlaps each other because multiple values are identical (more than one car has a 2)
# jitter adds random noise to each point to spread them out a little
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + 
  geom_jitter(mapping = aes(x = displ, y = hwy))

# Exercises ########
# improve this plot
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

# parameters that control the amount of jitter - width & height
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter(width = 0.25)

# default position for geom_boxplot - identity or dodge?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_boxplot()

# Coordinate systems ##############


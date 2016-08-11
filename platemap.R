# a script for platemaps

# read in platemap csv
platemap <- read.csv("~/Desktop/platemap.csv")

# draw the plate
library(ggplot)
ggplot(data = platemap, aes(x=Column, y = Row)) + geom_point(size=10) + labs(title = "Extraction E0151-E0246 platemap")

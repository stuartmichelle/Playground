# a script for platemaps

# make a list of columns and rows
plate <- data.frame( Row = rep(LETTERS[1:8], 12), Col = unlist(lapply(1:12, rep, 8)))

# import lab ids for the plate
suppressMessages(library(dplyr))
labor <- src_mysql(dbname = "Laboratory", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306, create = F)

extract <- data.frame(labor %>% tbl("extraction") %>% filter(date == '2014-05-30'))

plate1 <- merge(plate, extract[1:96,1])

# read in platemap csv
platemap <- read.csv("~/Desktop/platemap.csv")

# draw the plate

ggplot2::ggplot(data = platemap, aes(x=Column, y = Row)) + geom_point(size=10) +  labs(title = "Extraction E0151-E0246 platemap")


# # show empty wells - not working
# ggplot(data=platemap, aes(x=Column, y=Row)) + geom_point(data=expand.grid(seq(1, 12), seq(1, 8)), aes(x=Var1, y=Var2), color="grey90", fill="white", shape=21, size=6) + geom_point(size=10) + coord_fixed(ratio=(13/12)/(9/8), xlim = c(0.5, 12.5), ylim=c(0.5, 8.5)) + labs(title="Extraction E0151-E0246 platemap")
# # Error: Discrete value supplied to continuous scale

# Flip the axes

ggplot2::ggplot(data = platemap, aes(x=Column, y = Row)) + geom_point(size=10) + 
scale_y_reverse(breaks=seq(1, 8)) + 
  scale_x_continuous(breaks=seq(1, 12)) +
  labs(title = "Extraction E0151-E0246 platemap")

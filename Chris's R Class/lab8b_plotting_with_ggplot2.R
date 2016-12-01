# Section 8 - Part 2 - ggplot2
################################################################################

# 1) Scatter Plots
# 2) Barplots
# 3) Boxplots
# 4) Histograms

library(ggplot2)
library(reshape2)
library(dplyr)
library(RColorBrewer)

# Read in Data
################################################################################

setwd("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop")
data<-read.csv('Mongolia Fish Data.csv')
data$date<-as.Date(data$date,format = "%m/%d/%Y")
data$year<-format(data$date,'%Y')


# Format Data for Different Plot Types
################################################################################

# Scatter plots
lenok<-na.omit(subset(data,species_name=='lenok' ,select=c(tl_mm,weight_g)))
burbot<-na.omit(subset(data,species_name=='burbot',select=c(tl_mm,weight_g)))
spp.df<-na.omit(subset(data,species_name %in% c('lenok','burbot'),select=c(species_name,tl_mm,weight_g)))

# Barplots - Mean lengths of spp over time

spp<-c('taimen','spiny loach','Phoxinus','lenok','grayling-Arctic',
       'grayling-Hovsgol','grayling-unknown','burbot')

tl.yr<-as.data.frame(
  data %>%
    filter(species_name %in% spp & !is.na(year)& year>2006) %>%
    group_by(year,species_name) %>%
    summarize(tl.bar=mean(tl_mm,na.rm=T)) %>%
    arrange(year,species_name))
tl.2013<-subset(tl.yr,year==2013)

# Box Plots & Histograms - List of lengths broken up by species
leng.lst<-list()
for(i in 1:length(spp)){
  leng.lst[[i]]<-subset(data,species_name==spp[i],select=tl_mm)$tl_mm
  names(leng.lst)[i]<-spp[i]
}
leng.df<-na.omit(melt(leng.lst))
colnames(leng.df)<-c('tl_mm','species')
leng.df2<-subset(leng.df,species %in% c('lenok','burbot'))

# 1) Scatter Plots & Basics
################################################################################

# Start with Simple Points

# Change Point Color

# Remove background Color - Draw blank background, grid lines, and redraw axes

# Change Limits

# Change Axis Labels

# Change Plot Margin

# Adjust Axis Labels

# Change Axis Ticks

# Add Another Series

# Adding A Legend - Data needs to be in another format
# You need a dataframe with the different series as a column of factors

# 2) Bar Plots
################################################################################

#With a single Series

#Rotate Axis Labels

#With multiple series - Stacked

# Multiple Series - Besides

# Change Colors

### Can also do barplots with raw unsummarized data

#For Counts
tl.yr2<-na.omit(subset(data,
                       species_name %in% spp & year>2006 & water_body %in% c('Eg', 'Uur', 'Hovsgol')
                       ,select=c(species_name,year,water_body,tl_mm)))


#For Means


### Can Make Multi-Panel Plots

### Multi-Panel matrix plot

# 3) Box Plots
################################################################################

# Make a boxplot

# Fill a boxplot

### Violin Plots are another way to represent the same information
### The wider sections have more points

#Can also add points

# 4) Histograms
################################################################################



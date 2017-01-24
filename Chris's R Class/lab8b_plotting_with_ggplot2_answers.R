# Section 8 - Part 2 - ggplot2
################################################################################

# 1) Scatter Plots
# 2) Barplots
# 3) Boxplots
# 4) Histograms
install.packages("ggplot2")

library(ggplot2)
library(reshape2)
library(dplyr)
library(RColorBrewer)

# Read in Data
################################################################################

# setwd("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop")
# data<-read.csv('Mongolia Fish Data.csv')
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

# Start with Simple Points - plots points with default settings 
ggplot(lenok,aes(x=tl_mm,y=weight_g))+
  geom_point()

# Change Point Color
ggplot(lenok,aes(x=tl_mm,y=weight_g))+
  geom_point(color='red3')

# Remove background Color - Draw blank background, grid lines, and redraw axes
G<-ggplot(lenok,aes(x=tl_mm,y=weight_g))+
  geom_point(color='red3')+
  theme_bw()+
  theme(
    plot.background = element_blank()
    ,panel.grid.major = element_blank()
    ,panel.grid.minor = element_blank()
    ,panel.border = element_blank()
  ) +
  theme(axis.line.x = element_line(color = 'black',size=0.5),
        axis.line.y = element_line(color = 'black',size=0.5))

# Change Limits
G+ylim(0,2000)+
  xlim(0,700)

# Change Axis Labels
G+ylim(0,2000)+
  xlim(0,700)+
  labs(x='Length (mm)',y='Weight (g)',title='Lenght vs Weight')

# Change Plot Margin
G+ylim(0,2000)+
  xlim(0,700)+
  labs(x='Length (mm)',y='Weight (g)',title='Lenght vs Weight')+
  
# Adjust Axis Labels
G+ylim(0,2000)+
  xlim(0,700)+
  labs(x='Length (mm)',y='Weight (g)',title='Lenght vs Weight')+
  theme(plot.margin=unit(c(2,2,2,1),'cm'),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20))

# Change Axis Ticks
G+labs(x='Length (mm)',y='Weight (g)',title='Lenght vs Weight')+
  theme(plot.margin=unit(c(2,2,2,1),'cm'),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20))+
  scale_x_continuous(limit=c(0,750),breaks=seq(0,750,250))

# Add Another Series
G+labs(x='Length (mm)',y='Weight (g)',title='Lenght vs Weight')+
  theme(plot.margin=unit(c(2,4,2,1),'cm'),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20))+
  scale_x_continuous(limit=c(0,900),breaks=seq(0,1000,250))+
  geom_point(data=burbot)

# Adding A Legend - Data needs to be in another format
# You need a dataframe with the different series as a column of factors
ggplot(spp.df,aes(x=tl_mm,y=weight_g,col=species_name))+
  geom_point()+
  scale_color_manual(values=c('red3','black'),name='Species')

# 2) Bar Plots
################################################################################

#With a single Series
ggplot(tl.2013,aes(x=species_name,y=tl.bar))+
  geom_bar(stat='identity')

#Rotate Axis Labels
ggplot(tl.2013,aes(x=species_name,y=tl.bar))+
  geom_bar(stat='identity')+
  theme(axis.text.x=element_text(angle=30, size=15, vjust=0.5))

#With multiple series - Stacked
ggplot(tl.yr,aes(x=species_name,y=tl.bar,fill=year))+
  geom_bar(stat='identity')

# Multiple Series - Besides
ggplot(tl.yr,aes(x=species_name,y=tl.bar,fill=year))+
  geom_bar(stat='identity',position='dodge')

# Change Colors
ggplot(tl.yr,aes(x=species_name,y=tl.bar,fill=year))+
  geom_bar(stat='identity',position='dodge')+
  scale_fill_manual(values=brewer.pal(5,'Set1'))

### Can also do barplots with raw unsummarized data

#For Counts
tl.yr2<-na.omit(subset(data,
                       species_name %in% spp & year>2006 & water_body %in% c('Eg', 'Uur', 'Hovsgol')
                       ,select=c(species_name,year,water_body,tl_mm)))
ggplot(tl.yr2,aes(x=species_name,fill=year))+
  geom_bar(stat='count',position='dodge')

#For Means

ggplot(tl.yr2,aes(x=species_name,y=tl_mm,fill=year))+
  geom_bar(stat='summary',fun.y='mean',position='dodge')

### Can Make Multi-Panel Plots
ggplot(tl.yr2,aes(x=species_name,y=tl_mm))+
  geom_bar(stat='summary',fun.y='mean',position='dodge')+
  facet_wrap(~year,nrow=2)

### Multi-Panel matrix plot
ggplot(tl.yr2,aes(x=species_name,y=tl_mm))+
  geom_bar(stat='summary',fun.y='mean',position='dodge')+
  facet_grid(water_body~year)+
  theme(axis.text.x=element_text(angle=30, size=10, vjust=0.5))

# 3) Box Plots
################################################################################

# Make a boxplot
ggplot(leng.df,aes(x=species,y=tl_mm))+
  geom_boxplot()

# Fill a boxplot
ggplot(leng.df,aes(x=species,y=tl_mm))+
  geom_boxplot(fill='seagreen')

### Violin Plots are another way to represent the same information
### The wider sections have more points
ggplot(leng.df,aes(x=species,y=tl_mm))+
  geom_violin(fill='seagreen')

#Can also add points
ggplot(leng.df,aes(x=species,y=tl_mm))+
  geom_jitter(width = 0.2,color='grey20')+
  geom_violin(fill='seagreen',alpha=0.9)

# 4) Histograms
################################################################################


ggplot(leng.df2,aes(tl_mm,fill=species))+
  geom_histogram(binwidth = 50,color='black',alpha=0.6,position='identity')

# Section 7 - Heatmaps and Mapping
################################################################################
# install.packages("ggmap")

# Load All Packages
################################################################################
library(shape) # colorlegend()
library(colorRamps) # blue2red()
library(maps) # Basic Maps
library(mapdata) # More map data
library(ggmap) # Nicer Maps
library(ggplot2) # Nicer Plots with ggmap
library(RColorBrewer)


# READ DATA (Copied from Section 6)
################################################################################

# Clear workspace
rm(list = ls())

# Read temperature data
setwd("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop")
load("interpolated_thermister_string_data.Rdata")

# Read date data
temp.dates.data <- read.csv("temperature_data_collection_dates.csv", as.is=T)

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


# PLOTTING A HEAT MAP - With Image
################################################################################

# Format data
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

# Improve x-axis and y-axis labels - suppress drawing of axis with xaxt/yaxt
image(x=temp.dates.all, y=0:50, z=b, bty="n", xaxt="n", yaxt="n",
      xlab="Date", ylab="Depth (m)", col=colors)
# draw axis back in 
# specify dates on x axis - plot dates
axis.Date(1, at=seq(min.date, max.date, by="1 mon"), cex.axis=0.85)
axis(side=2, at=seq(0, 50, 5), labels=rev(seq(0, 50, 5)), las=1, cex.axis=0.9)

# Plot temperature legend - why you made breaks before
colorlegend(col=colors, zlim=c(min(breaks), max(breaks)), posx=c(0.93,.95), zlevels=length(breaks), dz=1, main="Temp (˚C)", main.cex=0.8, cex=0.7)

#### Can also use filled.contour for same figure

filled.contour(x=temp.dates.all, y=0:50, z=b, bty="n", xaxt="n", yaxt="n", xlab="Date", ylab="Depth (m)", color.palette=blue2red, nlevels = 15)


filled.contour(x=temp.dates.all, y=0:50, z=b, bty="n", xaxt="n", yaxt="n", key.title = title(main= 'Temp (?C)',cex.main=.9,line=1), xlab="Date", ylab="Depth (m)", col=colors,nlevels=14)

dev.off()
graphics.off()

# Making Maps
################################################################################

#Maps Package for basic maps and for polygons
map(database = "world")
map('world')
map('world', c("Canada", "USA"))
map('world', "Philippines")
map('worldHires')
map('worldHires', xlim = c(-77, -75), ylim = c(35,39))
map('worldHires', xlim = c(-90, -70), ylim = c(30,50))
map('usa')
map('state')
map('state','New.Jersey')
map('county','New.Jersey')
map('state',region=c('New.Jersey','New.York','Pennsylvania','Delaware'))
map('state',region=c('New.Jersey','New.York','Pennsylvania','Delaware'), xlim=c(-76,-70),ylim=c(37,42))

mp<-map('state',region=c('New.Jersey','New.York','Pennsylvania','Delaware'),plot=F,fill=T)


#### Using ggplot2 with maps

#Use ggplot() with geom_polygon
usa <- map_data("usa")
ggplot()+geom_polygon(data=usa, aes(x=long,y=lat,group=group))+coord_fixed(1.3)
# coord_fixed used for the projection of the map (aspect ratio of the points)

# Try plotting one state
NJ<-map_data(map = 'state',region='new.jersey')
ggplot()+geom_polygon(data=NJ, aes(x=long,y=lat,group=group))+
  coord_fixed(1.3)

# Plotting multiple states, Zoomed in Slightly, with Border Lines
MidAtl<-map_data(map = 'state',region=c('new.jersey','delaware','pennsylvania','maryland','New.York','Connecticut'))
ggplot() + geom_polygon(data=MidAtl, aes(x=long,y=lat,group=group),fill='grey50',color='black') + coord_fixed(xlim=c(-76,-73),ylim=c(38,41),ratio=1.3)

ggplot() + geom_polygon(data=MidAtl, aes(x=long,y=lat,group=group, fill = group),color='red') + coord_fixed(1.3)

#### Using ggmap #######################################

data2 <- read.csv("Chris's R Class/mongolia_fish_data.csv")
taimen <- subset(data2,species_name=='taimen'& !is.na(long_dd) & !is.na(tl_mm), select = c(long_dd,lat_dd,tl_mm))

colnames(taimen) <- c("lon","lat","tl")

# f is the buffer to extend the area, use a fraction
box <- make_bbox(lon=taimen$lon,lat=taimen$lat, f=0.15)

#let's make the buffer bigger
box <- make_bbox(lon=taimen$lon,lat=taimen$lat, f=0.3)

# uses online source to pull map
# map type is satellite, terrain, road, overlay, larger number zoom is closer (15 is close, 20 is too close, 2 is too far)
# river.map <- get_map(location = box, maptype = 'satellite', source = 'google', zoom = 15)
river.map <- get_map(location = box, maptype = 'satellite', source = 'google')
eg <- get_map(location = box, maptype = 'satellite', source = 'google')

ggmap(river.map)
ggmap(eg)

save(eg, file = 'eg.map.rdata')

# Or Specify the center of the map - find the center by taking the mean of the lat and lon
cent <- c(mean(taimen$lon), mean(taimen$lat))
# river.map <- get_map(location = cent, maptype = 'satellite', source = 'google', zoom = 11)
# river.map <- get_map(location = cent, maptype = 'satellite', source = 'google')
ggmap(river.map)

#Changing Scale
ggmap(river.map)+
  scale_x_continuous(limits=c(101.75,102),expand=c(0,0)) + scale_y_continuous(limits=c(50.2,50.5),expand=c(0,0))

#Adding Points to A map
ggmap(river.map)+
  scale_x_continuous(limits=c(101.75,102),expand=c(0,0))+
  scale_y_continuous(limits=c(50.2,50.5),expand=c(0,0))+
  geom_point(data=taimen,color='red3',size=2)

ggmap(river.map)+
  geom_point(data=taimen)

#Add a scale color based on fish length
ggmap(river.map)+
  scale_x_continuous(limits=c(101.75,102),expand=c(0,0))+
  scale_y_continuous(limits=c(50.2,50.5),expand=c(0,0))+
  geom_point(data=taimen,aes(color=tl),size=3)+
  scale_color_gradientn(colours=brewer.pal(4,'Reds'))

ggmap(river.map) + geom_point(data=taimen, aes(color=tl, size = 3)) + scale_color_gradientn(colours = brewer.pal(5, "Spectral")) 

#Scale Point size based on fish length
ggmap(river.map)+
  scale_x_continuous(limits=c(101.75,102),expand=c(0,0))+
  scale_y_continuous(limits=c(50.2,50.5),expand=c(0,0))+
  geom_point(data=taimen,aes(size=tl),col='grey50')+
  geom_point(data=taimen,shape=1,aes(size=tl),colour='black')

ggmap(river.map)+
  scale_x_continuous(limits=c(101.75,102),expand=c(0,0))+
  scale_y_continuous(limits=c(50.2,50.5),expand=c(0,0))+
  geom_point(data=taimen,aes(size=tl),col='white')+
  geom_point(data=taimen,shape=1,aes(size=tl),colour='black')


##################################################################################
# Exercise - Create a Terrain Map of Pearch & Spiny Loach
# Make sure all points are present in your map and color code the points by species
fish<-subset(data2,species_name %in% c('perch','spiny loach') & !is.na(long_dd),select=c(species_name,long_dd,lat_dd,tl_mm))
colnames(fish)<-c('spp','lon','lat','tl')
cent<-c(mean(fish$lon),mean(fish$lat))
map<-get_map(location=cent,maptype='terrain',source='google',zoom=8)
ggmap(map)+
  geom_point(data=fish,aes(col=spp),size=3)


# Bonus Challenge - Lots of points have similar or the same coordinate. Make a plot that 
# takes either the count or average length of any type of grayling caught in that location
grayling<-subset(data2,species_name %in% c('grayling-Arctic', 'grayling-Hovsgol', 'grayling-unknown') &
                   !is.na(long_dd)&!is.na(tl_mm)&long_dd<=101 & long_dd>=100 & lat_dd<=52 & lat_dd>=50,
                 select=c(species_name,long_dd,lat_dd,tl_mm))
colnames(grayling)<-c('spp','lon','lat','tl')
grayling$lon<-round(grayling$lon,3)
grayling$lat<-round(grayling$lat,3)
lats<-seq(50,52,0.001)
lons<-seq(100,101,0.001)
coords<-unique(grayling[,2:3])
coord.count<-function(coords,data){
  matches<-data$tl[which(data$lon==coords[1] & data$lat==coords[2])]
  return(length(matches))
}
coord.mean<-function(coords,data){
  matches<-data$tl[which(data$lon==coords[1] & data$lat==coords[2])]
  return(mean(matches,na.rm=T))
}
counts<-apply(coords,1,coord.count,data=grayling)
means<-apply(coords,1,coord.mean,data=grayling)
coords.df<-cbind(coords,counts,means)


gray.map<-get_map(location = c(mean(grayling$lon),mean(grayling$lat)),maptype = 'satellite',source='google',zoom=8)
ggmap(gray.map)+
  geom_point(data=coords.df[,1:2],aes(size=counts))
ggmap(gray.map)+
  geom_point(data=coords.df[,1:2],aes(size=means))

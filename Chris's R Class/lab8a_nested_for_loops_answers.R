# Section 8 - Double Loops
################################################################################

library(dplyr)
library(RColorBrewer)

# Read in Data
################################################################################

setwd("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop")
data<-read.csv('Mongolia Fish Data.csv')

#Format Dates
data$date<-as.Date(data$date,format = "%m/%d/%Y")


# How a Double Loop Works
################################################################################

#With just one loop
for( i in 1:5){
  print(i)
}

#With two
for( i in 1:5){
  for(j in 1:5){
    print(c(i,j))
  }
}

mat<-expand.grid(1:5,1:5)
mat<-mat[order(mat$Var1,mat$Var2),]

# A Bad Example of A Double Loop - Then How to Properly Do it
################################################################################

#### Your Goal: Make a Matrix of mean fish length by water body and by species

# Make a Vector of water bodies and species
body<-sort(unique(data$water_body))[-1]
spp<-sort(unique(data$species_name))[-1]

# Make a matrix whose rows are species and whose columsn are water bodies
leng<-matrix(NA,nrow=length(spp),ncol=length(body))
row.names(leng)<-spp
colnames(leng)<-body

# Make a double loop to fill in every combination of spp and body
for(i in 1:length(spp)){
  for(j in 1:length(body)){
    X<-t(subset(data,species_name==spp[i] & water_body==body[j],select=tl_mm))
    leng[i,j]<-mean(X,na.rm=T)    
  }
}
View(leng)

#### This works fast for small datasets, but with bigger one's it's very slow

#Make a "key" with the pairs of species and water body
key<-expand.grid(spp=spp,body=body)
key<-key[order(key$spp,key$body),]

#Can use a loop
for(i in 1:nrow(key)){
  X<-t(subset(data,species_name==key$spp[i] & water_body==key$body[i],select=tl_mm))
  key$tl.bar[i]<-mean(X,na.rm=T)
}
View(key)
na.omit(key)

#Or Just use dplyr

spp.body<-as.data.frame(
  data %>%
    group_by(species_name,water_body)%>%
    summarize(tl.bar=mean(tl_mm,na.rm=T)) %>%
    arrange(species_name,water_body))
na.omit(spp.body)

# A Good Example of A Double Loop
################################################################################

#### Your Goal: Plot A multipanel figure of timeseries of different species caught
#### at 4 water bodies

#Choose the species and water bodies
body<-c('Hovsgol','Uur','Eg')
spp<-c('taimen','spiny loach','Phoxinus','lenok','grayling-Arctic',
       'grayling-Hovsgol','grayling-unknown','burbot')

#Choose colors to represent the time series for each species

cols<-brewer.pal(8,'Set1')

#A Vector of Y limits
ylims<-c(750,200,100,100)

#Make Loop: First Loop subsets by water bodya and makes a plot space
# Second loop fills in time series
layout(matrix(c(1,1,2,2,0,3,3,4),nrow=2,byrow=T))
par(mar=c(2,4,3,1))
for(i in 1:length(body)){
  X<-as.data.frame(
    data %>%
      filter(water_body==body[i] & !is.na(date)) %>%
      group_by(date,species_name) %>%
      summarize(n=length(tl_mm)) 
      )
  plot(0,0,xlim=range(X$date,na.rm=T),ylim=range(0,ylims[i]),type='n',
       xlab='Date',ylab='Cumulative Sampling',main=body[i],xaxt='n')
  axis(1,at=seq(min(X$date),max(X$date),365),labels=seq(min(X$date),max(X$date),365))
  for(j in 1:length(spp)){
    Z<-subset(X,species_name==spp[j])
    Z$cumul<-cumsum(Z$n)
    lines(Z$date,Z$cumul,lwd=2,lty=1,col=cols[j])
    lines(Z$date,Z$cumul,lwd=2,lty=1,col=cols[j])
  }
}
plot(0,0,xaxt='n',yaxt='n',type='n',bty='n',xlab='',ylab='')
legend(-2,1,legend=spp,fill=cols,xpd=T,cex=1)


#################################################################
# R Course - Week 5 - Intermediate Plotting
#################################################################

# 1) Par Functions
# 2) Multi-panel Plots
# 3) RColorBrewer
# 4) Random Number Generation
# 5) Trendlines
# 6) Confidence Intervals

#################################################################
#################################################################

#################################################################
# 1) Par Functions
#################################################################

#### Margins mar() - Default c(5.1, 4.1, 4.1, 2.1)####
plot(1:10,1:10)
par(mar=c(6,6,3,1))
plot(1:10,1:10)

#### Plot Size pin() -  ####
par(pin=c(3,5))
plot(1:10,1:10)

#### Axis Labels mgp() - Default c(3,1,0)####

#First value changes axis labels
par(mgp=c(2,1,0))
plot(1:10,1:10)
#Second tick labels
par(mgp=c(2,0.5,0))
plot(1:10,1:10)
#Third tick marks
par(mgp=c(2,0.5,0.1))
plot(1:10,1:10)

#### Outer Margin oma() - Default c(2,2,2,2)
plot(1:10,1:10)
par(oma=c(0,0,0,0))
plot(1:10,1:10)

#### Reset par by dev.off() ####
dev.off()

#################################################################
# 2) Multi-Panel Plots
#################################################################

#### mfrow() - Number of rows & cols. in plots ####
par(mfrow=c(1,2))
par(mar=c(5,5,3,2))
plot(1:10,1:10)
plot(1:10,1:10)

#### Problem: Create a 2x2 plot of Length-Weight Relationship
#### for 4 species. 

# Start with code for single plot
par(mfrow=c(1,1))
data<-read.csv("C://Users/Joseph/Documents/Classes Fall 2016/R Workshop/Mongolia Fish Data.csv")
lenok<-subset(data,species_name=='lenok',select=c(tl_mm,weight_g))
plot(lenok[,1],lenok[,2])

#Make list of species names for subset and plots
spp<-c('lenok','burbot','grayling-Hovsgol','Phoxinus')
title.names<-c('Lenok','Burbot','Hovsgol Grayling', 'Phoxinus')

#Create loop of plots
par(mfrow=c(2,2))
par(mar=c(4,4,2,1))
for(i in 1:4){
  X<-subset(data,species_name==spp[i],select=c(tl_mm,weight_g))
  plot(X[,1],X[,2],main=title.names[i],xlab='Length',ylab='Weight',
       ylim=c(0,1.1*max(X[,2],na.rm=T)),xlim=c(0,1.1*max(X[,1],na.rm=T)))
}

#### layout() - Organization of plot ####
par(mfrow=c(1,1))
layout(matrix(c(1,1,2,3),ncol=2,byrow=T))
for(i in 1:3){
  X<-subset(data,species_name==spp[i],select=c(tl_mm,weight_g))
  plot(X[,1],X[,2],main=title.names[i],xlab='Length',ylab='Weight',
       ylim=c(0,1.1*max(X[,2],na.rm=T)),xlim=c(0,1.1*max(X[,1],na.rm=T)))
}

#### Exercise 1 - Create a plot with length-weight scatter plots for Lenok and Burbot
#### on the bottom and a wide length histogram of both species together above
lenok<-subset(data,species_name=='lenok',select=c(tl_mm,weight_g))
burbot<-subset(data,species_name=='burbot',select=c(tl_mm,weight_g))

brks<-seq(0,1000,50)

layout(matrix(c(1,1,1,1,1,1,1,1,2,2,3,3,2,2,3,3),ncol=4,byrow=T))
hist(lenok[,1],breaks=brks,main="Length Frequencey - Lenok & Burbot",xlab='Length (mm)',col=rgb(1,0,0,0.5))
hist(burbot[,1],breaks=brks,add=T,col=rgb(0,0,1,0.5))

plot(lenok[,1],lenok[,2],pch=16,col='red3',main='Lenok',xlab='Length (mm)',ylab='Weight (g)')
plot(burbot[,1],burbot[,2],pch=16,col='blue3',main='Burbot',xlab='Length (mm)',ylab='Weight (g)')

#################################################################
# 3) rColorBrewer
#################################################################

par(mfrow=c(1,1))

library(RColorBrewer)
# View all potential Color Palettes
display.brewer.all()

# Select a Color Palette
display.brewer.pal(n = 9,name = 'Reds') 

# Interpolate a Color Palette
reds<-colorRampPalette(brewer.pal(9,'Reds'))(100)

plot(1:100,1:100,pch=20,cex=30,col=reds)

#################################################################
# 4) Random Numbers - Useful for making up data to test things
#################################################################

#### Many types of probability distributions to generate numbers ####

# Uniform (any number between A and B)
X1<-runif(1000,min = 0,max = 1000)
hist(X1)

# Normal (has a mean and variance)
X2<-rnorm(1000,mean = 10,2)
hist(X2)

# Binomial (Either-OR)
X3<-rbinom(1000,size = 1,prob = 0.5)
hist(X3)

# Randomly sample from set of numbers
X4<-sample(X2,500,replace = F)
hist(X2)
hist(X4,add=T,col='grey')

#################################################################
# 5) Trendlines & Linear Models with lm()
#################################################################

#### Linear Fits ( Y = ax + b )####

#Generate fake data with noise
X<-runif(150,0,500)
slope<-1.5
int<-50
noise<-rnorm(150,0,50)
Y<-(X*slope + int)+noise

#Fit a linear model to fake data
plot(X,Y)

model<-lm(formula = Y~X)
summary(model)
coef(model)
coefs<-coef(model)

#Plot Regression LIne
abline(a=coefs[1],b=coefs[2])

# Alternatively with just abline()
plot(X,Y)
abline(model)

#### Polynomial Fits ( Y = ax^2 + bx + c) ####

#Make some fake data with noise (Nothing in our data is quadratic)
a<-2
b<--3
c<-50

noise2<-rnorm(100,0,100)
X2<-sort(runif(100,0,50))
Y2<-(a*X2^2 + b*X2 + c)+noise2

plot(X2,Y2)

#Fit quadratic Model
model2<-lm(formula = Y2 ~ I(X2^2)+I(X2))
summary(model2)
coefs2<-coef(model2)

#Plot Fitted model
curve(coefs2[1]+coefs2[3]*x+coefs2[2]*x^2,from = 0,to = 500,add=T)

#Alternatively
model2.b<-lm(formula = Y2 ~ poly(X2,2))
Y.fit<-predict(model2.b,data.frame(x=X2),interval='confidence',level=0.95)
plot(X2,Y2)
lines(X2,Y.fit[,1])

####Excersize 2: Fit an exponential model to Lenok Length Weight Data
#### Use an exponential model.
#### Hint: Log transform data and use a linear model (a*X^b == log(a)+b*log(X))
lenok<-subset(data, species_name=='lenok',select=c(tl_mm,weight_g))
plot(lenok[,1],lenok[,2])
lenok2<-log(lenok)
lenok.model<-lm(lenok2$weight_g~lenok2$tl_mm)
lenok.coef<-coef(lenok.model)
curve(exp(lenok.coef[1])*x^lenok.coef[2],from=0,to=800,add=T,lwd=2)

#################################################################
# 6) Confidence Intervals
#################################################################

#### Calculating ####

#Using confint() - Works on a lm object
confint(model)
model.ci<-confint(model)

#Using predict() - Also on a lm
model.fit<-predict(model,data.frame(x=X),interval='confidence',level=0.95)

#### Plotting ####

#Using solid lines w/ confint()
plot(X,Y)
curve(coefs[1]+coefs[2]*x,0,700,add=T)
curve(model.ci[1,1]+model.ci[2,1]*x,0,700,lty=2,add=T)
curve(model.ci[1,2]+model.ci[2,2]*x,0,700,lty=2,add=T)

#Using filled shape w/polygon(),seq(), and confint()
plot(X,Y)
x.seq.a<-seq(0,700,1)
y.fit.a<-model.ci[1,1]+model.ci[2,1]*x.seq.a
x.seq.b<-seq(700,0,-1)
y.fit.b<-model.ci[1,2]+model.ci[2,2]*x.seq.b
x.seq<-c(x.seq.a,x.seq.b)
y.fit<-c(y.fit.a,y.fit.b)
polygon(x.seq,y.fit,border = F,col=rgb(1,0,0,0.5))

#### Excersize 3: Plot a 2x2 plot of 4 species using a for loop.
#### Add a exponential regression line with color-coded confidence intervals
#### use colorBrewer to choose nice colors
library(GISTools)
colours<-brewer.pal(4,'Set1')
colours2<-add.alpha(colours,alpha = 0.5)

par(mfrow=c(2,2))
par(mar=c(2,4,3,1))
for(i in 1:4){
  X<-subset(data,species_name==spp[i],select=c(tl_mm,weight_g))
  plot(X[,1],X[,2],main=title.names[i],xlab='Length',ylab='Weight',
       ylim=c(0,1.1*max(X[,2],na.rm=T)),xlim=c(0,1.1*max(X[,1],na.rm=T)))
  model<-lm(log(X$weight_g)~log(X$tl_mm))
  coefs<-coef(model)
  curve(exp(coefs[1])*x^coefs[2],from=0,to=1000,add=T,lwd=2,lty=2)
  ci<-confint(model)
  x.seq.a<-0:1000
  x.seq.b<-1000:0
  x.seq<-c(x.seq.a,x.seq.b)
  y.fit<-c((exp(ci[1,1])*x.seq.a^ci[2,1]),(exp(ci[1,2])*x.seq.b^ci[2,2]))
  polygon(x.seq,y.fit,col=colours2[i],border=F)
}



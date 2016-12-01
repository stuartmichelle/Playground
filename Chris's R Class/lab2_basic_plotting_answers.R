################################################################
# Week 2 - Plotting in R
# Goals - 1) Construct and format basic scatter plots in R
#         2) Append plots with shapes and text
#         3) Export plots to desired file type
#         4) Explore the basics of other plot types



# Read and Subset Mongolia Fish Data from Week 1
################################################################

#make new data frame with only the lengths,weights, and age of Lenok

data<-read.csv('C:/Users/Joseph/Documents/Classes Fall 2016/R Workshop/Mongolia Fish Data.csv')

data.lenok<-subset(data,species_name=='lenok',select=c('tl_mm','weight_g'))
colnames(data.lenok)<-c('length','weight')

# Make a scatter plot
################################################################

#make a basic default scatter plot of length and weight
plot(data.lenok$length,data.lenok$weight)

##edit the "type" argument (points, lines, both, and null)
plot(data.lenok$length,data.lenok$weight,type='p')
plot(data.lenok$length,data.lenok$weight,type='l')
plot(data.lenok$length,data.lenok$weight,type='b')
plot(data.lenok$length,data.lenok$weight,type='n')

#Formating a scatter plot
################################################################

#Editing axis text and main title
#################

#x labels
plot(data.lenok$length,data.lenok$weight,xlab='Length (mm)')
#y labels
plot(data.lenok$length,data.lenok$weight,xlab='Length (mm)',ylab='Weight (g)')
#main title
plot(data.lenok$length,data.lenok$weight,xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight')

#Editing axis limits
#################

#x axis limits
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700))
#y axis limits
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000))

#Editing point parameters
#################

#point type
plot(1:20,rep(1,20),pch=1:20)

plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16)

#point color
plot(1:8,rep(1,8),col=1:20,pch=16)

#by default color id's
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col=2)
#by named colors
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3')
#by rgb function
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col=rgb(r=0.5,g=0,b=0))
#by hexidecimal id
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='#330000')

#point size
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)

#Appending Plot
###############################################################

#Polygons
####################

#polygon function - Needs coordinates of corners
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
poly.x<-c(300,300,500,500)
poly.y<-c(-10,2000,2000,-10)
polygon(poly.x,poly.y)

#rectangle function - Also needs corners but not in vector
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000)

#Add color and transparency with 'alpha'
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))

#Lines
######################

#abline (y=ax+b) - makes horizontal, vertical or slanted lines
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0)

#lines - needs vectors for x and y
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
lines(1:700,rep(0,700))

#curve - need a function in terms of x and a start and end
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
curve(expr = 0*x,from = 0,to = 700,add=T)

#Formatting Lines
########################

#line width
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2)

#line type
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2)

#line color
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')

#Adding Text
##########################

#Text function - Text within plot
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',main='Lenok Length vs Weight',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Legal Size',cex=1.5)

#Mtext Function - Text outside of plot
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Legal Size',cex=1.5)
mtext(text = 'Lenok Length vs Weight',side = 3,line = 0,cex=1.5)

#Custom Axes
####################################################################################

#Use yaxt or xaxt to not plot axis ticks 
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     yaxt='n',
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Legal Size',cex=1.5)
mtext(text = 'Lenok Length vs Weight',side = 3,line = 0,cex=1.5)

#Use "axis" function to make your own ticks
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     yaxt='n',
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Legal Size',cex=1.5)
mtext(text = 'Lenok Length vs Weight',side = 3,line = 0,cex=1.5)
axis(side = 2,at = seq(0,2000,100))

#Only label some ticks - 2 Overlapping Axes
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     yaxt='n',
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Legal Size',cex=1.5)
mtext(text = 'Lenok Length vs Weight',side = 3,line = 0,cex=1.5)
axis(side = 2,at = seq(0,2000,500),labels = seq(0,2000,500))
axis(side = 2,at = seq(0,2000,100),label=F,tick=T)

#Export Plot - 2 ways
###########################################################################

#In R Studio click on the export button above the figure and save in desired size and format

#Within a script - Open with  (png, jpeg, bmp, tiff ) close with dev.off()
png('Lenok - Size vs Weight.png',width = 1000,height = 750,units = 'px')
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     yaxt='n',
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Legal Size',cex=1.5)
mtext(text = 'Lenok Length vs Weight',side = 3,line = 0,cex=1.5)
axis(side = 2,at = seq(0,2000,500),labels = seq(0,2000,500))
axis(side = 2,at = seq(0,2000,100),label=F,tick=T)
dev.off()

####################################################################################################################
####################################################################################################################

#Exercise 1:
#Add another species length and weight using the points() function. Format the points so they can be distinguished
#from lenok and add a made-up legal size box to it. Save it as a jpeg when you're done.

#BONUS CHALLENGE: Try to add a right-side axis for the other species using "par(new=T)" then plot() then axis()
#so that both take up the same height

data.grayling<-subset(data,species_name=='grayling-Hovsgol',select=c('tl_mm','weight_g'))
colnames(data.grayling)<-c('length','weight')


#Answer 
jpeg('Lenok & Grayling - Size vs Weight.jpg',width = 1000,height = 750,units = 'px')
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     yaxt='n',
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Lenok Legal Size',cex=1)
mtext(text = 'Lenok & Grayling Length vs Weight',side = 3,line = 0,cex=1.5)
axis(side = 2,at = seq(0,2000,500),labels = seq(0,2000,500))
axis(side = 2,at = seq(0,2000,100),label=F,tick=T)
points(data.grayling$length,data.grayling$weight,pch=16,cex=0.75,col='green4')
rect(xleft = 250,ybottom = 0,xright = 325,ytop = 2000, col=rgb(r=0,g=0.5,b=0.1,alpha=0.25))
text(275,1800,'Grayling Legal Size')
dev.off()

#Bonus
jpeg('Lenok & Grayling - Size vs Weight - Bonus.jpg',width = 1000,height = 750,units = 'px')
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     yaxt='n',
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
text(x = 400,y=1800,labels='Lenok Legal Size',cex=1)
mtext(text = 'Lenok & Grayling Length vs Weight',side = 3,line = 0,cex=1.5)
axis(side = 2,at = seq(0,2000,500),labels = seq(0,2000,500))
axis(side = 2,at = seq(0,2000,100),label=F,tick=T)

par(new=T)
plot(data.grayling$length,data.grayling$weight,xaxt='n',yaxt='n',ylab='',xlab='',
     ylim=c(0,500),xlim=c(0,700),
     pch=16,col='green4',cex=0.75)
axis(side=4,at=seq(0,500,100))
rect(xleft = 250,ybottom = 0,xright = 325,ytop = 500, col=rgb(r=0,g=0.5,b=0.1,alpha=0.25))
text(275,450,'Grayling Legal Size')
dev.off()

#Adding a Legend
####################################################################################

##Remove Legal Size Text and Make a Legend with names, colors, and shapes
plot(data.lenok$length,data.lenok$weight,
     xlab='Length (mm)',ylab='Weight (g)',
     xlim=c(0,700),ylim=c(0,2000),
     yaxt='n',
     pch=16,col='red3',cex=0.75)
rect(xleft = 300,ybottom = -10,xright = 500,ytop = 2000,col=rgb(r=0.5,g=0,b=0.1,alpha = 0.25))
abline(h=0,lwd=2,lty=2,col='blue3')
mtext(text = 'Lenok & Grayling Length vs Weight',side = 3,line = 0,cex=1.5)
axis(side = 2,at = seq(0,2000,500),labels = seq(0,2000,500))
axis(side = 2,at = seq(0,2000,100),label=F,tick=T)
points(data.grayling$length,data.grayling$weight,pch=16,cex=0.75,col='green4 ')
rect(xleft = 250,ybottom = 0,xright = 325,ytop = 2000, col=rgb(r=0,g=0.5,b=0.1,alpha=0.25))
legend(x=0,y=1900,legend = c('Lenok','Grayling'),col=c('red3','green4'),pch=c(16,16))

#################################################################################################
#Other Plot Types
##################################################################################################

#Histograms - Frequency Distributions
##############################

#Plotting a histogram
brks<-seq(0,800,25)
hist(x = data.lenok$length,col=rgb(0.5,0,0.1,0.25),breaks=brks,ylim=c(0,150))
hist(x=data.grayling$length,col=rgb(0,0.5,0.1,0.25),breaks=brks,add=T)

#saving hist() as an object for frequencies
LL<-hist(data.lenok$length,plot=F)
LL$counts

#Boxplots - Box-and-Whisker - See data distribution
################################

#Single vector
boxplot(data.lenok$length,names = 'Lenok')

#Multiple uneven vectors
length.df<-list(data.lenok$length,data.grayling$length)
boxplot(length.df,names=c('Lenock','Grayling'))

#Barplots - Single Values across categories
################################

#One group
barplot(colMeans(data.lenok,na.rm=T))

#Two groups
lenok.means<-colMeans(data.lenok,na.rm=T)
grayling.means<-colMeans(data.grayling,na.rm=T)

barplot(t(cbind(lenok.means,grayling.means)))
#OR
barplot(t(cbind(lenok.means,grayling.means)),beside=T)

#Adding a legend
barplot(t(cbind(lenok.means,grayling.means)),beside=T,legend.text=c('Lenok','Grayling'))

#Excersize 2 
#Plot a histogram of the weight distribution of 3 species so that all can be seen.
#Add a legend that shows what the colors mean. Format the axes.
#BONUS CHALLENGE: add vertical, colorcoded, non-solid lines showing the mean and median for each species

#Answer
data.burbot<-subset(data,species_name=='burbot',select=c('tl_mm','weight_g'))
colnames(data.burbot)<-c('length','weight')

spp.weight<-list(na.omit(data.lenok$weight),na.omit(data.grayling$weight),na.omit(data.burbot$weight))
spp.weight<-
range(spp.weight,na.rm=T)
brks<-seq(0,6000,200)

hist(spp.weight[[1]],xlim=c(0,6000),breaks=brks,col=rgb(1,0,0,0.25),ylim=c(0,350),
     xlab='Weight (g)')
hist(spp.weight[[2]],breaks=brks,col=rgb(0,1,0,0.25),add=T)
hist(spp.weight[[3]],breaks=brks,col=rgb(0,0,1,0.25),add=T)
legend('topright',legend=c('Lenok','Grayling','Burbot'),fill=c(rgb(1,0,0,0.25),rgb(0,1,0,0.25),rgb(0,0,1,0.25)))

#Bonus

means<-c(mean(spp.weight[[1]]),mean(spp.weight[[2]]),mean(spp.weight[[3]]))
medians<-c(median(spp.weight[[1]]),median(spp.weight[[2]]),median(spp.weight[[3]]))
abline(v=means,col=c('red','green','blue'),lty=c(2,2,2),lwd=3)
abline(v=medians,col=c('red','green','blue'),lty=c(3,3,3),lwd=3)

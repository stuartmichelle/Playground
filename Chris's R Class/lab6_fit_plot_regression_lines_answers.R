
# READ AND FORMAT DATA
################################################################################

# Clear workspace
rm(list = ls())

# Read data
data_orig <- read.csv("mongolia_fish_data.csv", as.is=T)

# Reduce data to important columns
data_orig <- subset(data_orig, select=c(year, water_body, species_name, gear, tl_mm, weight_g))

# Rename columns
colnames(data_orig) <- c("year", "water_body", "species", "gear", "length_mm", "weight_g")

# Lower case species names
data_orig$species <- tolower(data_orig$species)

# SUBSET DATA TO FISH OF INTEREST
################################################################################

# We want to look at trends in fish body lengths in Lake Hovsgol over time.
# Decreases in body size are often used as evidence of a negative fishing
# impact because fishing selectively removes large individuals from the population.

# Subset 1. Fish caught in Lake Hovsgol using horizontal-gillnets
table(data_orig$water_body)
data <- subset(data_orig, water_body=="Hovsgol" & gear=="gillnet-horizontal")

# Subset 2. Species of interest
table(data$species)
species_list <- c("grayling-hovsgol", "lenok", "burbot", "roach", "perch")
data <- subset(data, species %in% species_list)

# Subset 3. Must have year and length information
data <- subset(data, !is.na(length_mm) & !is.na(year))


# SETUP A SINGLE PLOT
################################################################################

# Subset Hovsgol grayling data
sdata <- subset(data, species=="grayling-hovsgol")

# Plot 1. Regression line
##########################################

# Plot Hovsgol grayling length over time
plot(length_mm ~ year, sdata, bty="n", las=1, 
     xlab="Year", ylab="Length (mm)", ylim=c(200,400), col="grey60")

# Fit and inspect linear regression
lmfit <- lm(length_mm ~ year, sdata)
summary(lmfit)
coef(lmfit)

# Method #1. Plot linear regression with abline()
# Can customize with lty, lwd, col, etc
abline(lmfit, lwd=2)

# Method #2. Plot linear regression with curve()
# Can customize with lty, lwd, col, etc
# y = slope*x + intercept
slope <- coef(lmfit)[2]
intercept <- coef(lmfit)[1]
curve(slope*x+intercept, from=2009, to=2013, add=T, lwd=8)

# Plot 2. Regression line + CI lines
##########################################

# Plot Hovsgol grayling length over time
plot(length_mm ~ year, sdata, bty="n", las=1, 
     xlab="Year", ylab="Length (mm)", ylim=c(200,400), col="grey60")

# Fit and plot linear model
lmfit <- lm(length_mm ~ year, sdata)
pred.vals <- seq(2009,2013,0.2)
lmci <- predict(lmfit, data.frame(year=pred.vals), interval="confidence")
points(wide$score, wide$bbmsy, col="grey30", cex=0.8)
lines(pred.vals, lmci[,"fit"], lwd=1.5) # regression fit
lines(pred.vals, lmci[,"lwr"], lwd=1.5, lty=2) # lower confidence interval
lines(pred.vals, lmci[,"upr"], lwd=1.5, lty=2) # lower confidence interval


# Plot 3. Regression line + CI polygon
##########################################

# Plot Hovsgol grayling length over time
plot(length_mm ~ year, sdata, type="n", bty="n", las=1, 
     xlab="Year", ylab="Length (mm)", ylim=c(200,400), col="grey60")

# Fit and plot linear model
lmfit <- lm(length_mm ~ year, sdata)
pred.vals <- seq(2009,2013,0.2)
lmci <- predict(lmfit, data.frame(year=pred.vals), interval="confidence")
polygon(x = c(pred.vals, rev(pred.vals)), y = c(lmci[,"lwr"], rev(lmci[,"upr"])), col="grey80", border=NA) 
points(length_mm ~ year, sdata, col="grey30", cex=0.8)
lines(pred.vals, lmci[,"fit"], lwd=1.5) # regression fit

# Add species name, sample size (n), correlation coefficient (r2), and p-value
n <- nrow(sdata)
r2 <- format(round(summary(lmfit)$r.squared, 3), nsmall=3)
pvalue <- format(round(anova(lmfit)$'Pr(>F)'[1], 3), nsmall=3)
stat_text <- paste("n=", n, "; p=", pvalue, sep="")
mtext("Hovsgol grayling", side=3, line=-1, adj=0.05, cex=0.8, font=2)
mtext(stat_text, side=3, line=-2, adj=0.05, cex=0.8)


# SETUP A MULTI-PANEL PLOT (CLASS EXERCISE!)
################################################################################

# Setup figure
# par(mfrow=c(2,3), mar=c(5,4,4,1), mgp=c(3,1,0))
figname <- "length_over_time.png"
png(figname, width=6, height=4, units="in", res=600)
par(mfrow=c(2,3), mar=c(4,4,1,0.8), mgp=c(2.8,1,0))

# Axis limits
ymins <- c(200, 100, 300, 100, 100)
ymaxs <- c(450, 700, 1000, 500, 600)

# Loop through species and plot
for(i in 1:length(species_list)){
  
  # Subset species data
  spp <- species_list[i]
  sdata <- subset(data, species==spp)
  
  # Plot length over time
  plot(length_mm ~ year, sdata, type="n", bty="n", las=1, ylim=c(ymins[i], ymaxs[i]),
       xlab="Year", ylab="Length (mm)", col="grey60", cex.axis=0.8)
  
  # Fit and plot linear model
  lmfit <- lm(length_mm ~ year, sdata)
  pred.vals <- seq(2009,2013,0.2)
  lmci <- predict(lmfit, data.frame(year=pred.vals), interval="confidence")
  polygon(x = c(pred.vals, rev(pred.vals)), y = c(lmci[,"lwr"], rev(lmci[,"upr"])), col="grey80", border=NA) 
  points(length_mm ~ year, sdata, col="grey30", cex=0.8)
  lines(pred.vals, lmci[,"fit"], lwd=1.5) # regression fit
  
  # Add species name, sample size (n), correlation coefficient (r2), and p-value
  n <- nrow(sdata)
  r2 <- format(round(summary(lmfit)$r.squared, 3), nsmall=3)
  pvalue <- format(round(anova(lmfit)$'Pr(>F)'[1], 3), nsmall=3)
  stat_text <- paste("n=", n, "; p=", pvalue, sep="")
  mtext(spp, side=3, line=-1, adj=0.05, cex=0.7, font=2)
  mtext(stat_text, side=3, line=-2, adj=0.05, cex=0.7)
  
  
}

# Off
dev.off()
graphics.off()













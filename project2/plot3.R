# Exploratory Data Analysis: Course Project 2
# Plot3: Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999b 2008 for Baltimore City? Which have seen increases in 
# emissions from 1999b 2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

# Get the data for plotting
# Data stored in smry and scc data frames
source("./getdata.R")

# Filter data for Baltimore City
balt <- subset(smry, fips == "24510")

# Create factor for each source
balt$type <- factor(balt$type)

# Create factor for each year indicator
balt$year <- factor(balt$year)

# apply log10 to Emissions, add 1e-3 to remove zeros
balt$log10_emis <- log10(balt$Emissions + 0.001)

library(ggplot2)

png("./figures/plot3.png")
ggplot(data=balt, aes(x=year, y=log10_emis, color=year)) + 
    facet_grid(.~type) + 
    labs(x="Observation year", y=expression(paste(log[10],"(Emmisions+1e-3)")),
         title="Change in overall emissions (Baltimore City) by source type") + 
    geom_boxplot()
dev.off()

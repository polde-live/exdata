# Exploratory Data Analysis: Course Project 2
# Plot 4: Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999b 2008?

# Get the data for plotting
# Data stored in smry and scc data frames
source("./getdata.R")

# Get SCC for coal-combustion-related sources
comb_scc <- unique(scc$SCC[grep("Coal", scc$EI.Sector)])

# Filter data for combustion-related sources
comb <- subset(smry, SCC %in% comb_scc)

# Merge scc with data to form ggplot facets
comb_sec <- merge(comb, data.frame(SCC=scc$SCC, EI.Sector=scc$EI.Sector), by = "SCC")

# Create factor for each source
comb_sec$year <- factor(comb_sec$year)

# apply log10 to Emissions, add 1e-3 to remove zeros
comb_sec$log10_emis <- log10(comb_sec$Emissions + 0.001)

# Change EI.Sector text to fit on the plot
pat <- "(^Fuel Comb - )|( - Coal$)"
comb_sec$sect_short <- factor(gsub(pat, "", comb_sec$EI.Sector))

library(ggplot2)

png("./figures/plot4.png")
ggplot(data=comb_sec, aes(x=year, y=log10_emis, color=year)) + 
    facet_grid(.~sect_short) + 
    labs(x="Observation year", y=expression(paste(log[10],"(Emmisions+1e-3)")),
         title="Change in overall emissions from coal sources") + 
    geom_boxplot()
dev.off()

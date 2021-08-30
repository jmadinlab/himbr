
# ggplot course for molsa

###############################################
# 5 steps to data visualization with ggplot: 
###############################################
# Knowing the stats first
# Wrangling/formatting data ("long" format)
# Getting familiar with the ggplot language
# Googling the right things (using stack overflow)
# Being creative but keeping the message clear

###############################################
# Today 
###############################################
# Basic plots (barplot, boxplot, xy-plot, histogram, densityplot, lineplot, tile/contourplot)
# Themes, transformations, labels, legends, colours, annotations
# Inserting plots/images
# Multi-panel & Saving plots
# Inserting plots/images/text
# Complex plots, long format data (species barplots)
# Complex plot, multiple datasets (nMDS or PCA)

###############################################
# Data - bleaching in Indonesia (10x30m transects, 6 years )
###############################################
# Warwick, R.M., Clarke, K.R. & Suharsono (1990): A statistical analysis of coral community responses to the 1982-1983 El Nino in the Thousand Islands, Indonesia. - Coral Reefs, 8: 171-179.

library("mvabund")
data(tikus)

corals <- tikus$abun # cover
data <- tikus$x


###############################################
# Basic plots
###############################################



###############################################
# Themes/colours/legends/transformations/labels
###############################################

# default themes - https://ggplot2.tidyverse.org/reference/ggtheme.html

# other themes - https://mran.microsoft.com/snapshot/2017-02-04/web/packages/ggthemes/vignettes/ggthemes.html

# colour schemes - https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/

# other colour schemes - https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3

# library("RColorBrewer")

# display.brewer.pal(n = 8, name = 'Dark2')
# brewer.pal(n = 8, name = 'Dark2')



###############################################
# Inserting plots/images
###############################################

#library("png")
#library("grid")

#img<-readPNG("~/desktop/image.png")
#img<-rasterGrob(img, interpolate=TRUE)



###############################################
# Multipanel plots / saving
###############################################

# library("cowplot")

#ggsave("~/Desktop/fig.1.png", fig.1, width=15, height=9.5, units="cm", dpi = 300)



###############################################
# Data wrangling/more complex plots
###############################################

#library("reshape2")

# which species are most abundant?

#library("vegan")

# isolate genera names - sub(" .*", "", colnames(corals))

#mds<-metaMDS(corals, k=2, distance="bray", autotransform=FALSE, trymax=100)
#stressplot(mds)

#points<-cbind(data.frame(scores(mds)), data)
#vectors<-data.frame(mds$species)





###############################################
# Mapping in ggplot
###############################################

library("maptools")
library("raster")
library("rgdal")

# source of this code: http://www.rpubs.com/spoonerf/countrymapggplot2

usa<-getData("GADM", country="USA", level=1)  # choose country ISO code
usa_UTM<-spTransform(usa, CRS("+init=EPSG:32404"))  # set projection
# UTM square from: http://www.dmap.co.uk/utmworld.htm (longitude square + N/S)
# search this UTM code to get ESPG no at https://spatialreference.org 

hi<-usa_UTM[usa_UTM@data$NAME_1 == "Hawaii",] 
hi = spTransform(hi, "+init=epsg:4326")
hi_df<-fortify(hi)  
           
mid<-c(21.5, -158.0) # midpoint
a<-0.35 # area
            
ggplot() + 
geom_polygon(data=hi_df, aes(long,lat, group=group), fill="whitesmoke", col="black", size=0.1)+
 xlim(min(hi_df$long),max(hi_df$long))+
 ylim(min(hi_df$lat),max(hi_df$lat))+
coord_cartesian(c(mid[2]-a, mid[2]+a) ,c(mid[1]-a, mid[1]+a))+
theme_void()








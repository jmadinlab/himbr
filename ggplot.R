
# mjmcwilliam@outlook.com

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
summary(tikus)

corals <- tikus$abun # species cover
data <- tikus$x

head(corals)
data

data$cover <- rowSums(corals)/3000*100  # total cover

pres_abs <- ifelse(corals < 1, 0, 1)
head(pres_abs)

data$rich <- rowSums(pres_abs) # richness

head(data)

###############################################
# Basic plots
###############################################

library("ggplot2")

# x-y plot

ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point()

# boxplot
head(data)
ggplot(data, aes(time, rich))+
geom_boxplot()

# barplot
ggplot(data, aes(time, rich))+
stat_summary(geom="bar", fun="mean")+
stat_summary(geom="errorbar", fun.data=mean_se, width=0.1)

avs <- aggregate(cover~time, data=data, FUN=mean)

se <- function(x){sd(x)/sqrt(length(x))}

avs$se <- aggregate(cover~time, data=data, FUN=se)$cover

ggplot(avs, aes(time, cover))+
geom_bar(stat="identity")+
geom_segment(aes(x=time, xend=time, y=cover-se, yend=cover+se))+
geom_errorbar(aes(x=time,  ymin=cover-se, ymax=cover+se), col="red")

# line plot
str(data)

ggplot(data=data, aes(time, cover))+
geom_line(aes(group=rep))

ggplot(data=avs, aes(as.numeric(as.character(time)), cover))+
geom_line()


###############################################
# Themes/colours/legends/transformations/labels
###############################################

# transformations

ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point()+
scale_y_log10()+scale_x_log10()


# default themes - https://ggplot2.tidyverse.org/reference/ggtheme.html

ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point()+
theme_bw()

# other themes - https://mran.microsoft.com/snapshot/2017-02-04/web/packages/ggthemes/vignettes/ggthemes.html

library("ggthemes")

ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point()+
theme_wsj()

# self made theme

ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point(col="white")+
theme(axis.title=element_text(size=5, colour="white"), 
axis.text=element_text(size=5, colour="white"), plot.background=element_rect(fill="black"), panel.background=element_blank())

# edit legends
ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point(aes(fill=time), shape=21, stroke=0.2)+
theme(legend.position=c(0.1, 0.8), legend.key.size=unit(2, "mm"), legend.title=element_text(size=7))

# colour schemes - https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/

# continous colour
ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point(aes(colour=rich))+
scale_colour_distiller(palette="Spectral")+
theme_classic()

# dicrete colour

library("RColorBrewer")

display.brewer.pal(n = 6, name = 'Dark2')
pal <- brewer.pal(n = 6, name = 'Dark2')

ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point(aes(fill=time), shape=21, stroke=0.2)+
scale_fill_manual(values=pal)+
theme_classic()

# bbc theme - https://medium.com/bbc-visual-and-data-journalism/how-the-bbc-visual-and-data-journalism-team-works-with-graphics-in-r-ed0b35693535

# other colour schemes - https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3

###############################################
# Inserting plots/images
###############################################

# insert image

library("png")
library("grid")

img<-readPNG("data/images/image.png")
img<-rasterGrob(img, interpolate=TRUE)

plot <- ggplot(data=data, aes(x=cover, y=rich))+
geom_smooth(method="lm")+
geom_point(aes(fill=time), shape=21, stroke=0.2)+
annotation_custom(img, xmin=40, xmax=50, ymin=0, ymax=10)+
scale_fill_manual(values=pal)+
theme_classic()+
theme(legend.position=c(0.1, 0.8), legend.key.size=unit(2, "mm"), legend.title=element_text(size=7))
plot

# insert plot

inplot <- plot+
guides(fill="none")+
theme(axis.text=element_text(size=3), axis.title=element_text(size=3))

plot+
annotation_custom(ggplotGrob(inplot), xmin=40, xmax=50, ymin=0, ymax=10)

###############################################
# Multipanel plots / saving
###############################################

library("cowplot")

boxes <- ggplot(data, aes(time, rich))+
geom_boxplot()


fig.1 <- plot_grid(plot+ylim(0,35), boxes+ylim(0,35), labels=c("A","B"), rel_widths=c(1, 0.8), nrow=1, align="h", axis="bt")
fig.1 

#ggsave("figs/fig.1.png", fig.1, width=13, height=8, units="cm", dpi = 300)


# panels for variables in data = facets

ggplot(data=data, aes(rich, cover))+
geom_point()+
facet_wrap(~time)


###############################################
# Data wrangling/more complex plots
###############################################

library("reshape2")

# which species are most abundant?

head(corals)

new <- cbind(time=data$time, rep=data$rep, corals)

long <- melt(new, id.var=c("time","rep"), variable.name="species")

unique(long$species)

long$genus <- sub(" .*", "", long$species)

head(long)

genus <- aggregate(value~time+genus+rep, data=long, FUN=sum)

head(genus)

ggplot(genus, aes(x=value, y=reorder(genus, value), fill=time))+
geom_bar(stat="identity")+
facet_wrap(~time)

# mds plot

library("vegan")

wide <- dcast(genus, time+rep~genus)

mdsdat <- subset(wide, select=-c(time, rep))

mds<-metaMDS(sqrt(mdsdat), k=2, distance="bray", autotransform=FALSE, trymax=100)
#stressplot(mds)

points<-cbind(data.frame(scores(mds)), data)
vectors<-data.frame(mds$species)

library("ggrepel")

ggplot(data=points)+
geom_segment(data=vectors, aes(x=0, xend=MDS1, y=0, yend=MDS2))+
geom_text_repel(data=vectors, aes(MDS1*1.1, MDS2*1.1, label=rownames(vectors)), size=1.5)+
geom_point(data=points, aes(NMDS1, NMDS2, col=time, size=cover))+
theme_bw()


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








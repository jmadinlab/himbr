# Loading and manipulating data in R

data <- read.csv("data/seed_root_herbivores.csv", strip.white = TRUE)

data$Height

data[["Height"]]
coln <- c("Plot", "Height")

data[coln]
data$coln

data[,5]

seq(5, 30, by=1)
idx <- sample(1:nrow(data), 10, replace=FALSE)
data[idx,]

idx <- data$Plot != "plot-12" & data$Seed.herbivore == TRUE & data$Root.herbivore == FALSE & data$No.stems > 1
data[idx,]

data[data$Plot == "plot-12",]

subset(data, Plot != "plot-12" & Seed.herbivore == TRUE)

data2 <- subset(data, Seed.heads >= 25)

subset(data, Seed.heads < 25)
data$Seeds.in.25.heads[data$Seed.heads < 25]

data$Seeds.in.25.heads[data$Seed.heads < 25] <- NA

write.csv(data, "output/seed_root_herbivores_scrubbed.csv", row.names=FALSE)

data$Height_log10 <- log10(data$Height)
data$Height_log10 <- NULL





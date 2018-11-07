# My R code

file.exists("data/seed_root_herbivores.csv")

dat <- read.csv("data/seed_root_herbivores.csv")
head(dat)
tail(dat)
names(dat)
summary(dat)

dat$Height
mean(dat$Height)
hist(dat$Height)

plot(dat$Height, dat$Weight)
plot(dat$Height, dat$Weight, col="red")
plot(log10(dat$Height), log10(dat$Weight), col="red")

dat$Height_log10 <- log10(dat$Height)
dat$Weight_log10 <- log10(dat$Weight)

plot(dat$Height_log10, dat$Weight_log10)

plot(Weight_log10 ~ Height_log10, data=dat)
boxplot(Height_log10 ~ Root.herbivore, data=dat)

mod <- lm(Height_log10 ~ Root.herbivore, data=dat)
summary(mod)

mod <- lm(Weight_log10 ~ Height_log10, data=dat)
summary(mod)

plot(Weight_log10 ~ Height_log10, data=dat, col="grey")
abline(mod)

plot(mod)

# Introduction to R

# Testing to see if the data file exists
file.exists("data/seed_root_herbivores.csv")

# Loading the data file in R (it is a comma-delimited file)
dat <- read.csv("data/seed_root_herbivores.csv")

# Some functions for looking at the loaded file. What do they do?
head(dat)
tail(dat)
names(dat)
summary(dat)

# Extracting a column form the data file
dat$Height

# Some functions for doing stuff to the vector of data from a column 
mean(dat$Height)
hist(dat$Height)

# A plot of two variables form the data file
plot(dat$Height, dat$Weight)
plot(dat$Height, dat$Weight, col="red")

# Logging the axes
plot(log10(dat$Height), log10(dat$Weight), col="red")

# Creating new variables in the data set. Here we are creating columns for log-transformed variables. 
dat$Height_log10 <- log10(dat$Height)
dat$Weight_log10 <- log10(dat$Weight)

# Plotting these again. Why is this better?
plot(dat$Height_log10, dat$Weight_log10)

# Plotting using the R formula syntax. This is the same syntax as used in statistical models
plot(Weight_log10 ~ Height_log10, data=dat)
boxplot(Height_log10 ~ Root.herbivore, data=dat)

# Let's run a simple linear model (anova / t-test in this case)
mod <- lm(Height_log10 ~ Root.herbivore, data=dat)
summary(mod)

# And a regression
mod <- lm(Weight_log10 ~ Height_log10, data=dat)
summary(mod)

# Plotting the data and the model fit
plot(Weight_log10 ~ Height_log10, data=dat, col="grey")
abline(mod)

# These are a series of diagnostics for the the statistical model. 
plot(mod)


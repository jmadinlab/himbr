# Loading and manipulating data in R

# Loading the data file in R (it is a comma-delimited file)
data <- read.csv("data/seed_root_herbivores.csv")

# Some functions for looking at the loaded file. What do they do?
head(data)
names(data)

nrow(data)
ncol(data)
length(data)

# - Column names should be consistent, the right length, contain no special characters.
# - For missing values, either leave them blank or use NA. But be consistent and don’t use -999 or ? or your cat’s name.
# - Be careful with whitespace “x” will be treated differently to “x “, and Excel makes it easy to accidently do the latter. Consider the strip.white=TRUE argument to read.csv.
# - Think about the type of the data. We’ll cover this more, but are you dealing with a TRUE/FALSE or a category or a count or a measurements.
# - Dates and times will cause you nothing but pain. Excel and R both have issues with dates and times, and exporting through CSV can make them worse. I recommend Year-Month-Day (ISO 8601 format, or different colummns for different entries and combine later). E.g., 2018-11-07
# - Watch out for dashes between numbers. Excel will convert these into dates. So if you have “Site-Plant” style numbers 5-20 will get converted into the 20th of May 1904 or something equally useless. Similar problems happen to gene names in bioinformatics!
# - Merged rows and columns will not work (or at least not in an easily predictible way).
# - Spare rows at the top, or double header rows will not work without jumping through hoops.
# - Equations will (should) convert to the value displayed in Excel on export.

# Subsetting

data$Plot
data[["Plot"]]

# This is the main difference: if the column name is in a variable, then $ won’t work, while [[ will. Let’s define a variable v that has the name if the first column as its value:

v <- "Plot"

# We can extract this column of the data set using the [[ notation:

data[[v]]

# but using the $ notation won’t work as it will look for the column called v:

data$v

# Also, data$P will “expand” to make data$Plot, but data$S will return NULL because that is ambiguous. Always use the full name!

# Single square brackets also index the data, but do so differently. This returns a data.frame with one column:

head(data["Plot"])

# This returns a data.frame with two columns:

head(data[c("Plot", "Weight")])

data.sub <- data[c("Plot", "Weight")]


hist(data$Height)
plot(data$Weight, data$Height)
pairs(data[c("Height", "Weight", "Seed.heads")])

# Rows of data.frames

data[10,]
data[10:20,]
data[c(1, 5, 10),]

# Be careful with indexing by location

data.height <- data[[5]]
data.height <- data[,5]

# This should really be avoided. By name is much more robust and easy to read later on, even if it is more typing at first.

data.height <- data$Height
data.height <- data[["Height"]]

# When should you index by location?
  

idx <- seq(1, nrow(data), by=2)
data.oddrows <- data[idx,]
nrow(data.oddrows)
nrow(data)

idx <- sample(1:nrow(data), 20, replace=FALSE)
data.randrows <- data[idx,]

# Indexing and subsetting

data$Plot
data$Plot == "plot-12"
which(data$Plot == "plot-12")

idx <- which(data$Plot == "plot-12")

data[idx,]
data[data$Plot == "plot-12",]

data[data$Plot != "plot-12",]

# Subsetting can be useful when you want to look at bits of your data. For example, all the rows where the Height is at least 10 and there was no seed herbivore:

data[data$Height > 10 & data$Seed.herbivore,]

# The & operator here is a logical “and” (read x & y as “x and y”):
  
# TRUE & TRUE is TRUE
# TRUE & FALSE is FALSE
# FALSE & TRUE is FALSE
# FALSE & FALSE is FALSE

# In contrast, the | operator is a logical “or” (read as “or”)

# TRUE | TRUE is TRUE
# TRUE | FALSE is TRUE
# FALSE | TRUE is TRUE
# FALSE | FALSE is FALSE

data[data$Plot == "plot-2" & data$Seed.herbivore & data$Root.herbivore,]
data[data$Height > 75 & (data$Seed.herbivore | data$Root.herbivore),]

subset(data, Height > 75 & (Seed.herbivore | Root.herbivore))

data$small.plant <- data$Height < 50

data$small.plant <- NULL



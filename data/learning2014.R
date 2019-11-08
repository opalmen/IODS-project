# Olli Palmén (2.11.2019)
# RStudio Exercise 2: Regression analysis using learning data

# Install required packages
install.packages("dplyr")

lrn14 <- read.table("C:/Users/palme/Documents/IODS-project/data/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
str(lrn14)

## Scale data and create dataset for analysis

# access the dplyr library

library(dplyr)


# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")


# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)
head(learning2014)
dim(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"

colnames(learning2014)[7] <- "points"

# print out the new column names of the data

print(colnames(learning2014))

# select rows where points is greater than zero

learning2014 <- filter(learning2014, points > 0)

# check dimensions of new dataset

dim(learning2014)

# set working directory to IODS-project

setwd("C:/Users/palme/Documents/IODS-project/")

# write table to data folder

write.table(learning2014, file="C:/Users/palme/Documents/IODS-project/data/learning2014.txt", sep="\t")

# read table from data folder

learning2014_read <- read.table("C:/Users/palme/Documents/IODS-project/data/learning2014.txt", sep="\t", header=TRUE)

# check structure of imported dataset
head(learning2014_read)
str(learning2014_read)

lrn14 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)

  
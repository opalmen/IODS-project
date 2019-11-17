# Olli Palmen, 
# 16.11.2019
# Combine datasets student-mat and student-por (retrieved from: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/)

## Read data

# Read student-mat.csv
math <- read.csv("C:/Users/palme/Documents/IODS-project/data/student-mat.csv", header=TRUE, sep=";")
str(math)

# Read student-por.csv
por <- read.csv("C:/Users/palme/Documents/IODS-project/data/student-por.csv", header=TRUE, sep=";")
str(por)


## Join datasets

# Access the dplyr library
install.packages("dplyr")
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# see the new column names
colnames(math_por)

# dataset consists of 53 variables and 382 observations

# glimpse at the data
glimpse(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# New dataset consists of 33 variables and 382 observations

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Save the joined and modififed data to data folder

write.table(alc, file="C:/Users/palme/Documents/IODS-project/data/alc.csv", sep=",")

# Read table and check everything ok
test <- read.table("C:/Users/palme/Documents/IODS-project/data/alc.csv", sep=",", header=TRUE)
glimpse(test)

# everything ok!
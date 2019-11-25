hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the datasets: see the structure and dimensions of the data.
str(hd)

# 195 observations of 8 variables

str(gii)

# 195 observations of 10 variables


# Create summaries of the variables

summary(hd)

summary(gii)

hd_colnames = c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.Minus.Rank")

gii_colnames = c("GII.Rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "LFP.F", "LFP.M")

colnames(hd) <- hd_colnames
colnames(gii) <- gii_colnames

# new variable edu2ratio = edu2m/edu2f

gii$Edu2.Ratio = gii$Edu2.F/gii$Edu2.M


# new variable lfpratio = lfpf/lfpm

gii$LFP.Ratio = gii$LFP.F/gii$LFP.M

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("Country")

# join the two datasets by the selected identifiers
human <- inner_join(gii, hd, by = join_by)

# Summary of data
summary(human)

# Dimensions of data
str(human)

#195 observations of 19 variables
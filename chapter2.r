## Data analysis for RStudio Exercise 2

# Install required packages

install.packages("ggplot2")
install.packages("GGally")
install.packages("gridExtra")
# Read data

lrn14 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)

# Check data structure

str(lrn14)

# Check data summary statistics

summary(lrn14)

# access the GGally and ggplot2 libraries
library(ggplot2)
library(GGally)

# create a more advanced plot matrix with ggpairs()
ggpairs(lrn14, mapping = aes(col=gender, alpha=0.3), lower = list(combo = wrap("facethist", bins = 20))) + ggtitle("Learning 2014: Summary Statistics")

require(gridExtra)

# initialize plot with data and aesthetic mapping
p1 <- ggplot(lrn14, aes(x = attitude, y=points, col=gender)) + geom_point() + ggtitle("Attitude vs points") + theme(legend.position="bottom")

# initialize plot with data and aesthetic mapping
p2 <- ggplot(lrn14, aes(x = stra, y=points, col=gender)) + geom_point() + ggtitle("Strategic learning vs points")

# initialize plot with data and aesthetic mapping
p3 <- ggplot(lrn14, aes(x = surf, y=points, col=gender)) + geom_point() + ggtitle("Surface learning vs points")

# initialize plot with data and aesthetic mapping
p4 <- ggplot(lrn14, aes(x = deep, y=points, col=gender)) + geom_point() + ggtitle("Deep learning vs points")

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(p1)

grid.arrange(arrangeGrob(p1 + theme(legend.position="none"),
                               p2 + theme(legend.position="none"),
                               p3 + theme(legend.position="none"),
                               p4 + theme(legend.position="none"),
                               nrow=2),
                   mylegend, nrow=2,heights=c(10,1))

grid.arrange(p1, p2, p3, p4, ncol=2)


# Use semi-transparent fill


p6 <- ggplot(lrn14, aes(x=attitude, fill=gender, color=gender)) +
  geom_histogram(position="identity", alpha=0.5) 

p7 <- ggplot(lrn14, aes(x=deep, fill=gender, color=gender)) +
  geom_histogram(position="identity", alpha=0.5)

p8 <- ggplot(lrn14, aes(x=stra, fill=gender, color=gender)) +
  geom_histogram(position="identity", alpha=0.5)

p9 <- ggplot(lrn14, aes(x=surf, fill=gender, color=gender)) +
  geom_histogram(position="identity", alpha=0.5)

p10 <- ggplot(lrn14, aes(x=points, fill=gender, color=gender)) +
  geom_histogram(position="identity", alpha=0.5)

p11 <- ggplot(lrn14, aes(x=points, fill=gender, color=gender)) +
  geom_histogram(position="identity", alpha=0.5)


grid.arrange(arrangeGrob(p6 + theme(legend.position="none"),
                         p7 + theme(legend.position="none"),
                         p8 + theme(legend.position="none"),
                         p9 + theme(legend.position="none"),
                         p10 + theme(legend.position="none"),
                         p11 + theme(legend.position="none"),
                         nrow=3),
             mylegend, nrow=2,heights=c(10,1), top="Learning 2014: Frequencies")


# Dependent variable: points, explanatory variables: attitude, stra, surf

my_model2 <- lm(points ~ attitude + stra + surf, data = lrn14)
summary(my_model2)
par(mfrow = c(1,3))
plot(my_model2, which=c(1,2,5))





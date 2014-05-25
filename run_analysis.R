


#merges training and test sets
setwd("C:/Users/Dylan/Desktop/Coursera R/Tidy Data Project")

# read and merge files to create dataset
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
train <- cbind(subject_train, Y_train, X_train)

subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
test <- cbind(subject_test, Y_test, X_test)

dataset <- rbind(train, test)

#rename subject and activity columns
colnames(dataset)[1] <- "subject"
colnames(dataset)[2] <- "activity"


# retrieve features that only calculate mean and sd
# subset the dataset to only have mean, sd and subject and activity
feature.file <- read.table("./features.txt", col.names = c("index", "name"))
features <- subset(feature.file, grepl('-mean[(]|std[(])', feature.file$name))

# store the column numbers and names needed
list.of.columns <- as.numeric(as.character(features$index))
list.of.columns <- c(1, 2, list.of.columns+c(2))
name.of.columns <- as.character(features$name)
name.of.columns <- c("subject", "activity", name.of.columns)

# subset the data
meanSD.dataset <- dataset[,list.of.columns]

# rename the columns using name.of.columns
colnames(meanSD.dataset) <- name.of.columns

# read activity labels
activity.labels <- read.table("./activity_labels.txt")
activity <- activity.labels[2]
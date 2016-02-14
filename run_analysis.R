# Check if data directory is exists; create if doesn't
dataDirName <- "./data"
if(!file.exists(dataDirName)) {
	dir.create(dataDirName)
}

# Download and unzip source data
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tmpFile <- tempfile()
library(RCurl)
download.file(zipUrl, destfile = tmpFile, method = "libcurl")
unzip(tmpFile, exdir = dataDirName)

## Read all the data sets
datasetDir <- paste0(dataDirName, "/UCI HAR Dataset")
subject_test  <- read.table(paste0(datasetDir, "/test/subject_test.txt"),   header = F, stringsAsFactors = F, fill = T)
x_test        <- read.table(paste0(datasetDir, "/test/X_test.txt"),         header = F, stringsAsFactors = F, fill = T)
y_test        <- read.table(paste0(datasetDir, "/test/y_test.txt"),         header = F, stringsAsFactors = F, fill = T)
subject_train <- read.table(paste0(datasetDir, "/train/subject_train.txt"), header = F, stringsAsFactors = F, fill = T)
x_train       <- read.table(paste0(datasetDir, "/train/X_train.txt"),       header = F, stringsAsFactors = F, fill = T)
y_train       <- read.table(paste0(datasetDir, "/train/y_train.txt"),       header = F, stringsAsFactors = F, fill = T)

# Read the variables names from features.txt
features <- read.table(paste0(datasetDir,"/features.txt"), header = F, stringsAsFactors = F, fill = T)

# Merge the training and the test sets into single data set
mergedData <- cbind(rbind(subject_test, subject_train), 
	                rbind(y_test, y_train),
                    rbind(x_test, x_train))

# Set meaningful names 
colnames(mergedData)[1:2] <- c("Subject", "Activity")
colnames(mergedData)[3:563] <- features[, 2]

# Subset mergedData to only include columns which name includes "mean", "std", "Activity" or "Subject" but not "meanFreq"
mergedData <- mergedData[, grepl("mean()|std()|Activity|Subject", colnames(mergedData)) & !grepl("meanFreq", colnames(mergedData))]

# To use descriptive activity names to name the activities in the data set
# Read activity names from activity_labels.txt
activities <- read.table(paste0(datasetDir, "/activity_labels.txt"), header = F, stringsAsFactors = F, fill = T)

# Label the data set with descriptive activity names.
mergedData$Activity <- factor(mergedData$Activity, levels = activities[, 1], labels = activities[, 2])

# Create an independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
tidyData <- ddply(mergedData, .(Subject, Activity),
                  .fun=function(x) { colMeans(x[ ,-c(1:2)]) })

# Write out resulting tidy data set into CSV
write.csv(tidyData, "./data/tidydata.txt", row.names = FALSE)

# Download and unzip the data file
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
download.file(fileUrl, "UCI HAR Dataset.zip", mode="wb")
unzip("UCI HAR Dataset.zip")

# Read the measure files and combine for training and test
train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
measure <- rbind(train, test)

# Read the Subject information and combine for training and test
train <- read.table("UCI HAR Dataset/train/subject_train.txt")
test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(train, test)

# Read the Activity information and combine for training and test
train <- read.table("UCI HAR Dataset/train/y_train.txt")
test <- read.table("UCI HAR Dataset/test/y_test.txt")
activity <- rbind(train, test)

# Read features/measures list
featuresAll <- read.table("UCI HAR Dataset/features.txt")
# Identify the indices of the features that we want to keep
features <- grep("mean\\(|std\\(", featuresAll[, 2])
# subset the measure to keep only required features
measure <- measure[, features]

# Read the activity names, and substitute these for IDs in activity information
activityName <- read.table("UCI HAR Dataset/activity_labels.txt")
activity[,1] = activityName[activity[,1], 2]

# Add column names to the data frames and remove "(" and ")"
names(measure) <- featuresAll[features, 2]
names(measure) <- gsub("\\(|\\)", "", names(measure))
names(activity) <- "activity"
names(subject) <- "subject"

# Combine subject, activity, measure data frames to get a composite frame
combined <- cbind(subject, activity, measure)
#write.table(combined, "merged.txt", quote=FALSE, row.names=FALSE, sep="\t")

# Use the melt, dcast functions to generate the final tidy dataset.
library(reshape2)
molten <- melt(combined, id = c("subject","activity"))
tidy <- dcast(molten, subject + activity ~ variable, mean)

# Write the output to disk
write.table(tidy, "tidy_output.txt", quote=FALSE, row.names=FALSE, sep="\t")


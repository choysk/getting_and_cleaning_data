# This is R script called run_analysis.R that does the following:
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
#
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Read training data

X_trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")

# Add subject and activity columns to training data

subjectTrainData <- read.table ("./UCI HAR Dataset/train/subject_train.txt")
y_trainData <- read.table ("./UCI HAR Dataset/train/y_train.txt")


trainData <- cbind(X_trainData, subjectTrainData, y_trainData)

# Read test data

X_testData <- read.table("./UCI HAR Dataset/test/X_test.txt")

# Add subject and activity columns to test data

subjectTestData <- read.table ("./UCI HAR Dataset/test/subject_test.txt")
y_testData <- read.table ("./UCI HAR Dataset/test/y_test.txt")

testData <- cbind(X_testData, subjectTestData, y_testData)

# Merge train and test data
traintestData <- rbind(trainData, testData)

# Read the column names of data set
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
colnamesFeatures <- features[,2]

# add new column names for new columns
colnamesFeatures[562] <- c("subject")
colnamesFeatures[563] <- c("activityId")

# Add column names to data set
colnames(traintestData) <- colnamesFeatures

# add Activity Name column by matching Activity Id 

activityLabels <- read.table ("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
colnames(activityLabels) <- c("activityId", "activity.Name")

allData <- join(traintestData, activityLabels, by="activityId")

colnamesFeatures[564] <- c("activity.Name")

# Keep only columns with mean and standard deviation in their column names

meanCols <- grep("mean", colnamesFeatures)
stdCols <- grep("std", colnamesFeatures)

# Also add activty and subject columns
# Change activity name instead of activity number

subjectCols <- grep("subject", colnamesFeatures)
activityCols <- grep("activity.Name", colnamesFeatures)

meanData <- allData[, meanCols]
stdData <- allData[, stdCols]
subjectData <- allData[, subjectCols]
activityData <- allData[, activityCols]
meanStdData <- cbind(subjectData, activityData, meanData, stdData)


# meanStdData$subjectData <- as.factor(meanStdData$subjectData)
# meanStdData$activityData <- as.factor(meanStdData$activityData)

tidyData <- aggregate(meanStdData, by=list(subject=meanStdData$subjectData,
                                           activity=meanStdData$activityData), 
                        mean)


# remove extra subjectData and activityData columns which has been averaged

tidyData$subjectData <- NULL
tidyData$activityData <- NULL

# create text file for tidy data set

write.table(tidyData, file = "./tidy_data.txt", sep=",", row.names=FALSE)
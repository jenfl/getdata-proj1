# Read in labels for activity and columns
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

# Read in subject IDs for observations
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names=c("Subject ID"))
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names=c("Subject ID"))

# Read in observation data, columns as listed in features.txt
test_X <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     col.names=features[,2])
train_X <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names=features[,2])

# Read in activity IDs for observations, turn into factor using the
# activity descriptions we gathered earlier
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names=c("Activity ID"))
test_y$Activity.ID <- factor(test_y$Activity.ID, labels=activity_labels[,2])
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names=c("Activity ID"))
train_y$Activity.ID <- factor(train_y$Activity.ID, labels=activity_labels[,2])

# Combine the observation data for training and test groups
test_full <- cbind(test_subject, test_y, test_X)
train_full <- cbind(train_subject, train_y, train_X)

# Combine training and test groups into full data set; Subject ID can be factor
fullDataSet <- rbind(test_full, train_full)
fullDataSet$Subject.ID <- factor(fullDataSet$Subject.ID)

# Look for column names that include mean or std, also keep Subject ID and Activity ID
featureCols <- c(grep ("\\.std\\.", colnames(fullDataSet), ignore.case=TRUE),
                 grep ("\\.mean\\.", colnames(fullDataSet), ignore.case=TRUE))
colsToKeep <- c(featureCols, 
                grep ("Activity.ID", colnames(fullDataSet), ignore.case=TRUE), 
                grep ("Subject.ID", colnames(fullDataSet), ignore.case=TRUE))
colsToKeep <- sort(colsToKeep)

# Cut down the full data set to just the columns we need to keep
reducedDataSet <- fullDataSet[,colsToKeep]

# Empty vectors to hold our tidy data as we create it
SubjectVector <- character(0)
ActivityVector <- character(0)
VariableNameVector <- character(0)
VariableMeanVector <- integer(0)

# Loop through each subject, activity, and variable to determine the mean
for (subj in levels(reducedDataSet$Subject.ID)) {
    for (activity in levels(reducedDataSet$Activity.ID)) {
        for (feature in colnames(reducedDataSet[-1:-2])) {
            
            featureMean <- mean(reducedDataSet[reducedDataSet$Subject.ID == subj &
                                               reducedDataSet$Activity.ID == activity,
                                               feature])
            
            SubjectVector <- c(SubjectVector, subj)
            ActivityVector <- c(ActivityVector, activity)
            VariableNameVector <- c(VariableNameVector, feature)
            VariableMeanVector <- c(VariableMeanVector, featureMean)
        }
    }
}

# Create a tidy data frame from the vectors we populated
tidyData <- data.frame(Subject=SubjectVector, 
                       Activity=ActivityVector,
                       VariableName=VariableNameVector,
                       VariableMean=VariableMeanVector)

# Write out the tidy data
write.table(tidyData, row.name=FALSE)
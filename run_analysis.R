library(dplyr)

## STEP -1: GETTING THE DATA
## Download zipfile if it has not been downloaded yet
zipurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"

if(!file.exists(zipfile)) {
        download.file(zipurl, zipfile, mode = "wb")
}

## Unzip the zip file if the data folder doesn't exist
data_all <- "UCI HAR Dataset"
if(!file.exists(data_all)) {
        unzip(zipfile)
}

## STEP 0: READING THE DATA
## Reading the training data
training_subjects <- read.table(file.path(data_all, "train", "subject_train.txt"))
training_values <- read.table(file.path(data_all, "train", "X_train.txt"))
training_activity <- read.table(file.path(data_all, "train", "y_train.txt"))

## Reading the test data
test_subjects <- read.table(file.path(data_all, "test", "subject_test.txt"))
test_values <- read.table(file.path(data_all, "test", "X_test.txt"))
test_activity <- read.table(file.path(data_all, "test", "y_test.txt"))

## Reading the features but no conversion of text labels to factors
features <- read.table(file.path(data_all, "features.txt"), as.is = TRUE)

## Reading the activity labels
activities <- read.table(file.path(data_all, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

## STEP 1: MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATE SET
## Concatenating the individual data tables into one data table
human_activity <- rbind(
        cbind(training_subjects, training_values, training_activity),
        cbind(test_subjects, test_values, test_activity)
)

## Removing the individual data tables for memory efficiency
rm(training_subjects, training_values, training_activity, 
   test_subjects, test_values, test_activity)

## Assigning names to columns
colnames(human_activity) <- c("subject", features[, 2], "activity")

## STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
## Determining which columns of the data set to keep based on column name
columns_to_keep <- grepl("subject|activity|mean|std", colnames(human_activity))
human_activity <- human_activity[, columns_to_keep]

## STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
## Replacing the activity values with named factor levels
human_activity$activity <- factor(human_activity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])

## STEP 4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
## Getting the column names
human_activity_cols <- colnames(human_activity)

## Removing the special characters
human_activity_cols <- gsub("[\\(\\)-]", "", human_activity_cols)

## Expanding the abbreviations and cleaning up the names
human_activity_cols <- gsub("^f", "frequencyDomain", human_activity_cols)
human_activity_cols <- gsub("^t", "timeDomain", human_activity_cols)
human_activity_cols <- gsub("Acc", "Accelerometer", human_activity_cols)
human_activity_cols <- gsub("Gyro", "Gyroscope", human_activity_cols)
human_activity_cols <- gsub("Mag", "Magnitude", human_activity_cols)
human_activity_cols <- gsub("Freq", "Frequency", human_activity_cols)
human_activity_cols <- gsub("mean", "Mean", human_activity_cols)
human_activity_cols <- gsub("std", "StandardDeviation", human_activity_cols)

## Correcting typos
human_activity_cols <- gsub("BodyBody", "Body", human_activity_cols)

## Using new labels as column names
colnames(human_activity) <- human_activity_cols

## STEP 5: CREATE A SECOND, INDEPENDENT TIDY SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACITVITY AND EACH SUBJECT
## Grouping by subject and activity and summarising using mean
human_activity_means <- human_activity %>% 
        group_by(subject, activity) %>%
        summarise_each(funs(mean))

## Creating the second tidy data set named "tidy_data.txt"
write.table(human_activity_means, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
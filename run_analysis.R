library(dplyr)

## STEP -1: GETTING THE DATA
## Download zipfile if it has not been downloaded yet
filename <- "UCI HAR Dataset.zip"

if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename)
}  

## Unzip the zip file if the data folder doesn't exist
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

## STEP 0: ASSIGNING ALL THE DATA FRAMES
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

## STEP 1: MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATE SET
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
MergedData <- cbind(Subject, Y, X)

## STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
TidyData <- MergedData %>% select(subject, code, contains("mean"), contains("std"))

## STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
TidyData$code <- activities[TidyData$code, 2]

## STEP 4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

## STEP 5: CREATE A SECOND, INDEPENDENT TIDY SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACITVITY AND EACH SUBJECT
tidy_data <- TidyData %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)

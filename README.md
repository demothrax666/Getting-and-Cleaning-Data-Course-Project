## Dataset
The original dataset was downloaded from the link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

A full description is available from the following website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## Files in the repository
+ ```codebook.md``` is the code book that provides description for the:
    + Variables
    + Data
    + Any adjustments, mergers and transformations performed to arrive at the final output (a tidier dataset)
+ ```run_analysis.R``` preps the data and performs the required 5 steps as described in the course project's instructions:
    + Merges the training and the test sets to create one data set.
    + Extracts only the measurements on the mean and standard deviation for each measurement.
    + Uses descriptive activity names to name the activities in the data set
    + Appropriately labels the data set with descriptive variable names.
    + From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
+ ```tidy_data.txt``` is the created second, independent tidy data set after all the adjustments, mergers and transformations per the required 5 steps described in the course project's instructions.
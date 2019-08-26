# **run_analysis.R codebook**

The run_analysis.R script preps the data and performs the required 5 steps as described in the course project's instructions.

1. **STEP -1: GETTING THE DATA**
    + Dataset downloaded and extracted into the folder "UCI HAR Dataset".

2. **STEP 0: ASSIGNING ALL THE DATA FRAMES**
    + ```features``` <- ```features.txt```. *The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.*
    + ```x_test``` <- ```test/X_test.txt```. *Contains recorded features test data*
    + ```y_test``` <- ```test/y_test.txt```. *Contains test data of activities’code labels*
    + ```subject_test``` <- ```test/subject_test.txt```. *Contains test data of 9/30 volunteer test subjects being observed*    
    + ```x_train``` <- ```test/X_train.txt```. *Contains recorded features train data*
    + ```y_train``` <- ```test/y_train.txt```. *Contains train data of activities’code labels*
    + ```subject_train``` <- ```test/subject_train.txt```. *Contains train data of 21/30 volunteer subjects being observed*
    + ```activities``` <- ```activity_labels.txt```. *List of activities performed when the corresponding measurements were taken and its codes (labels)*

3. **STEP 1: MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET**
    + ```X``` is created by merging ```x_train``` and ```x_test``` using **rbind()** function.
    + ```Y``` is created by merging ```y_train``` and ```y_test``` using **rbind()** function.
    + ```Subject``` is created by merging ```subject_train``` and ```subject_test``` using **rbind()** function.
    + ```Merged_Data``` is created by merging ```Subject```, ```Y``` and ```X``` using **cbind()** function.

4. **STEP 2: EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT**
    + ```TidyData``` is created by subsetting ```Merged_Data```, selecting only columns: ```subject```, ```code``` and the measurements on the ```mean``` and standard deviation (```std```) for each measurement.

5. **STEP 3: USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET**
    + Entire numbers in ```code``` column of the ```TidyData``` replaced with corresponding activity taken from second column of the ```activities``` variable.

6. **STEP 4: APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIE VARIABLE NAMES**
    + All start with character ```f``` in column’s name subsituted to ```Frequency```.
    + All start with character ```t``` in column’s name subsituted to ```Time```.
    + All ```Acc``` in column’s name subsituted to ```Accelerometer```.
    + All ```Gyro``` in column’s name subsituted to ```Gyroscope```.
    + All ```BodyBody``` in column’s name subsituted to ```Body```.
    + All ```Mag``` in column’s name subsituted to ```Magnitude```.
    + ```code``` column in ```TidyData``` renamed into ```activities```.    

7. **STEP 5: FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT**
    + ```tidy_data``` is created by summarizing ```TidyData``` via the means of each variable for each activity and each subject, after grouped by subject and activity.
    + Export ```tidy_data``` into ```tidy_data.txt``` file.
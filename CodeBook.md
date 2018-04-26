### This code book describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md

#--- Variables in run_analysis.R:
# y_test : table for Test labels

# y_train : table for Training labels

# X_test : table for Test set

# X_train : table for Training set

# subject_test : table for Subject Test (Each row identifies the subject who 
# performed the activity for each window sample. Its range is from 1 to 30.) 

# subject_train : table for Subject Train (Each row identifies the subject who 
# performed the activity for each window sample. Its range is from 1 to 30.)

# dataSubject : Concatenate the data tables by rows for subject_train, subject_test

# dataActivity : Concatenate the data tables by rows for y_train, y_test

# dataFeatures : Concatenate the data tables by rows for X_train, X_test

# dataFeaturesNames: table for List of all features

# dataCombine : Merge columns to get the data frame Data for all data for dataSubject, dataActivity

# Data : Merge columns to get the data frame Data for all data for dataFeatures, dataCombine

# activityLabels : table for class labels with their activity name

#--- Actions performed to clean up data in run_analysis.R:
# Data extracted from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1) Extract and download zipfile from url, unzip and check all listed files
##      Change working directory if required

# 2) Read Data from Activity files, Features files, Subject files

# 3) Merge the training and the test sets to create one data set.
##      Concatenate the data tables by rows
##      Set names to variables
##      Merge columns to get the data frame Data for all data

# 4) Extract only the measurements on the mean and standard deviation for each measurement.

# 5) Use descriptive activity names to name the activities in the data set
##      Read descriptive activity names from “activity_labels.txt”
##      The activity field in Data is originally of numeric type, change to character so that it can accept activity names. 
##      The activity names are taken from metadata activityLabels.
##      Factor the activity variable, once the activity names are updated.

# 6) Appropriately labels the data set with descriptive variable names.
##      Replace below acronyms:
#-- Acc can be replaced with Accelerometer
#-- Gyro can be replaced with Gyroscope
#-- BodyBody can be replaced with Body
#-- Mag can be replaced with Magnitude
#-- Character f can be replaced with Frequency
#-- Character t can be replaced with Time

# 7) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##      Set Subject as a factor variable.
##      Create tidyData as a data set with average for each activity and subject. 
##      Order the enties in tidyData and write it into data file Tidy.txt that contains the processed data.

#--- Getting and Cleaning Data Course Project

#--- The purpose of this project is to demonstrate your ability to collect, work with, 
#--- and clean a data set. The goal is to prepare tidy data that can be used for 
#--- later analysis. You will be graded by your peers on a series of yes/no 
#--- questions related to the project. You will be required to submit: 
#--- 1) a tidy data set as described below, 
#--- 2) a link to a Github repository with your script for performing the analysis, and 
#--- 3) a code book that describes the variables, the data, and any transformations 
#--- or work that you performed to clean up the data called CodeBook.md. 
#--- You should also include a README.md in the repo with your scripts. 
#--- This repo explains how all of the scripts work and how they are connected.

#--- Here are the data for the project:
#--- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#--- You should create one R script called run_analysis.R that does the following.
#--- 1) Merges the training and the test sets to create one data set.
#--- 2) Extracts only the measurements on the mean and standard deviation for each measurement.
#--- 3) Uses descriptive activity names to name the activities in the data set
#--- 4) Appropriately labels the data set with descriptive variable names.
#--- 5) From the data set in step 4, creates a second, independent tidy data set 
#--- with the average of each variable for each activity and each subject.

#--- Extracts and downloads zipfile from url, specify url and zipfile name
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "dataset.zip")

#--- Unzip file, to directory as C3W4-CP
unzip("dataset.zip", exdir = "C3W4-CP")
#--- Check all listed files
setwd("~/C3W4-CP/UCI HAR Dataset")
getwd() 
list.files()

#--- Read Data
#--- Read the Activity files
y_test <- read.table("~/C3W4-CP/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("~/C3W4-CP/UCI HAR Dataset/train/y_train.txt")

#--- Read Features files
X_test <- read.table("~/C3W4-CP/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("~/C3W4-CP/UCI HAR Dataset/train/X_train.txt")

#--- Read the Subject files
subject_test <- read.table("~/C3W4-CP/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("~/C3W4-CP/UCI HAR Dataset/train/subject_train.txt")

#--- 1) Merges the training and the test sets to create one data set.
#--- Concatenate the data tables by rows
dataSubject <- rbind(subject_train, subject_test)
dataActivity <- rbind(y_train, y_test)
dataFeatures <- rbind(X_train, X_test)

#--- Set names to variables
names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table("~/C3W4-CP/UCI HAR Dataset/features.txt") 
names(dataFeatures) <- dataFeaturesNames$V2

#--- Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

print(Data)

#--- 2) Extracts only the measurements on the mean and standard deviation for each measurement.
MeanStdOnly <- grep("mean()|std()", dataFeaturesNames[, 2]) 
Data.sub1 <- Data[,MeanStdOnly]
print(Data.sub1)

#--- 3) Uses descriptive activity names to name the activities in the data set
#--- Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table("~/C3W4-CP/UCI HAR Dataset/activity_labels.txt")

#--- The activity field in Data is originally of numeric type, change to character 
#--- so that it can accept activity names. 
#--- The activity names are taken from metadata activityLabels.
Data$activity <- as.character(Data$activity)
for (i in 1:6){
        Data$activity[Data$activity == i] <- as.character(activityLabels[i,2])
}

#--- Factor the activity variable, once the activity names are updated.
Data$activity <- as.factor(Data$activity)

#--- 4) Appropriately labels the data set with descriptive variable names.
#--- Replace below acronyms:
#-- Acc can be replaced with Accelerometer
#-- Gyro can be replaced with Gyroscope
#-- BodyBody can be replaced with Body
#-- Mag can be replaced with Magnitude
#-- Character f can be replaced with Frequency
#-- Character t can be replaced with Time

names(Data) # Check before

names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("^t", "Time", names(Data))
names(Data) <- gsub("^f", "Frequency", names(Data))
names(Data) <- gsub("tBody", "TimeBody", names(Data))
names(Data) <- gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data) <- gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data) <- gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data) <- gsub("angle", "Angle", names(Data))
names(Data) <- gsub("gravity", "Gravity", names(Data))

names(Data) # Check after

#--- 5) From the data set in step 4, creates a second, independent tidy data set 
#--- with the average of each variable for each activity and each subject.

#--- Set Subject as a factor variable.
Data$subject <- as.factor(Data$subject)
Data <- data.table(Data)

#--- Create tidyData as a data set with average for each activity and subject. 
#--- Order the enties in tidyData and write it into data file Tidy.txt that 
#--- contains the processed data.

tidyData <- aggregate(. ~subject + activity, Data, mean)
tidyData <- tidyData[order(tidyData$subject,tidyData$activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
# Getting and Cleaning Data Course Project Code Book

## 1.Data source

The raw data is obtained from UCI Machine Learning Repository. The link is as followed:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A Full Description of the data could be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## 2.Data
Raw data used in this project were as followed:
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

## 3.Variale description
### 3.1 Data Identifier
- Subject
- Activity

Subject record the target while Activity record the target activity status, including 6 levels regarding to 6 values. 
### 3.2 Activity levels
The activity levels are as followed:
- WALKING (1)
- WALKING_UPSTAIRS (2)
- WALKING_DOWNSTAIRS (3)
- SITTING (4)
- STANDING (5)
- LAYING (6)

### 3.3 Measured Variables
The following variales were used in this project, specific explanation could be found in the previous description link or in the data file.
- tBodyAccMeanX
- tBodyAccMeanY
- tBodyAccMeanZ
- tBodyAccStdX
- tBodyAccStdY
- tBodyAccStdZ
- tGravityAccMeanX
- tGravityAccMeanY
- tGravityAccMeanZ
- tGravityAccStdX
- tGravityAccStdY
- tGravityAccStdZ
- tBodyAccJerkMeanX
- tBodyAccJerkMeanY
- tBodyAccJerkMeanZ
- tBodyAccJerkStdX
- tBodyAccJerkStdY
- tBodyAccJerkStdZ
- tBodyGyroMeanX
- tBodyGyroMeanY
- tBodyGyroMeanZ
- tBodyGyroStdX
- tBodyGyroStdY
- tBodyGyroStdZ
- tBodyGyroJerkMeanX
- tBodyGyroJerkMeanY
- tBodyGyroJerkMeanZ
- tBodyGyroJerkStdX
- tBodyGyroJerkStdY
- tBodyGyroJerkStdZ
- tBodyAccMagMean
- tBodyAccMagStd
- tGravityAccMagMean
- tGravityAccMagStd
- tBodyAccJerkMagMean
- tBodyAccJerkMagStd
- tBodyGyroMagMean
- tBodyGyroMagStd
- tBodyGyroJerkMagMean
- tBodyGyroJerkMagStd
- fBodyAccMeanX
- fBodyAccMeanY
- fBodyAccMeanZ
- fBodyAccStdX
- fBodyAccStdY
- fBodyAccStdZ
- fBodyAccMeanFreqX
- fBodyAccMeanFreqY
- fBodyAccMeanFreqZ
- fBodyAccJerkMeanX
- fBodyAccJerkMeanY
- fBodyAccJerkMeanZ
- fBodyAccJerkStdX
- fBodyAccJerkStdY
- fBodyAccJerkStdZ
- fBodyAccJerkMeanFreqX
- fBodyAccJerkMeanFreqY
- fBodyAccJerkMeanFreqZ
- fBodyGyroMeanX
- fBodyGyroMeanY
- fBodyGyroMeanZ
- fBodyGyroStdX
- fBodyGyroStdY
- fBodyGyroStdZ
- fBodyGyroMeanFreqX
- fBodyGyroMeanFreqY
- fBodyGyroMeanFreqZ
- fBodyAccMagMean
- fBodyAccMagStd
- fBodyAccMagMeanFreq
- fBodyBodyAccJerkMagMean
- fBodyBodyAccJerkMagStd
- fBodyBodyAccJerkMagMeanFreq
- fBodyBodyGyroMagMean
- fBodyBodyGyroMagStd
- fBodyBodyGyroMagMeanFreq
- fBodyBodyGyroJerkMagMean
- fBodyBodyGyroJerkMagStd
- fBodyBodyGyroJerkMagMeanFreq

## 4. Script explanation
This project contains one script called `run_analysis.R`. This script will do the following:

1. Clear the R workspace and install necessary package `plyr`.
```{r}
rm(list = ls())
if(!plyr %in% installed.packages()){install.packages("plyr")}
library(plyr)
```
2. Download the data file and save them in getandcleandata folder and unzip the file.
```{r}
if(!file.exists("./cleandata_project")){dir.creat("./cleandata_project")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./cleandata_project/rawdata.zip")
unzip(zipfile = "./cleandata_project/rawdata.zip", exdir = "./cleandata_project")
```
3. Read target raw data files.
```{r}
data_path <- "./cleandata_project/UCI HAR Dataset"
ActivityTest <- read.table(file.path(data_path, "test", "Y_test.txt"))
ActivityTrain <- read.table(file.path(data_path, "train", "Y_train.txt"))
SubjectTest <- read.table(file.path(data_path, "test", "subject_test.txt"))
SubjectTrain <- read.table(file.path(data_path, "train", "subject_train.txt"))
FeatureTest <- read.table(file.path(data_path, "test", "X_test.txt"))
FeatureTrain <- read.table(file.path(data_path, "train", "X_train.txt"))
FeatureName <- read.table(file.path(data_path, "features.txt"))
ActivityLabel <- read.table(file.path(data_path, "activity_labels.txt"))
```
4. Merge and Change label names
```{r}
Activity <- rbind(ActivityTest, ActivityTrain)
Subject <- rbind(SubjectTest,SubjectTrain)
Feature <- rbind(FeatureTest, FeatureTrain)
names(Activity) <- c("Activity")
names(Subject) <- c("Subject")
names(Feature) <- FeatureName$V2
Data_merged <- cbind(Subject, Activity, Feature)
```
5. Extract the mean and standard deviation files
```{r}
mean_and_std_names <- FeatureName$V2[grep("-(mean|std)\\(\\)", FeatureName$V2)]
mean_and_std_names <- c("Subject", "Activity", as.character(mean_and_std_names))
Data_subset <- Data_merged[, mean_and_std_names]
```
6. Change the Activity label and column labels to proper descriptive names
```{r}
Data_subset[, 2] <- ActivityLabel[Data_subset[, 2], 2]
names(Data_subset) <- gsub("^t", "Time", names(Data_subset))
names(Data_subset) <- gsub("^f", "Frequency", names(Data_subset))
names(Data_subset) <- gsub("Acc", "Accelerometer", names(Data_subset))
names(Data_subset) <- gsub("Gyro", "Gyroscope", names(Data_subset))
names(Data_subset) <- gsub("Mag", "Magnitude", names(Data_subset))
```
7. Create a second tidy data set with means of data for each subject and each activity
```{r}
Data <- aggregate(. ~Subject + Activity, Data_subset, mean)
Data <- Data[order(Data$Subject,Data$Activity), ]
write.table(Data, file = "./cleandata_project/tidydata.txt",row.name=FALSE)
```

The script will create a final tidy data set call `tidydata.txt`
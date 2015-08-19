#Getting and cleaning data course project
**Kentryo**

**August 19, 2015**

This is the README markdown for the getting and cleaning data course project.

The prokect is to clean a raw data set collected from UCI

The data set could be downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description could be found at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This project contains one script called `run_analysis.R`. This script will do the following:

1. Clear the R workspace and install necessary package `plyr`.
2. Download the data file and save them in getandcleandata folder and unzip the file.
3. Read target raw data files.
4. Merge and Change label names
5. Extract the mean and standard deviation files
6. Change the Activity label and column labels to proper descriptive names
7. Create a second tidy data set with means of data for each subject and each activity

The script will create a final tidy data set call `tidydata.txt`
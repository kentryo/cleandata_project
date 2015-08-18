#This is a script to  get clean data
# clear workspace
rm(list = ls())
#load necessary R packages

#Download the data file and save them in get and clean data folder
if(!file.exists("./cleandata_project")){dir.creat("./cleandata_project")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./cleandata_project/rawdata.zip")
#unzip the file
unzip(zipfile = "./cleandata_project/rawdata.zip", exdir = "./cleandata_project")

#Load the raw data file
data_path <- "./cleandata_project/UCI HAR Dataset"
#Read Activity files
ActivityTest <- read.table(file.path(data_path, "test", "Y_test.txt"))
ActivityTrain <- read.table(file.path(data_path, "train", "Y_train.txt"))
#Read Subject files
SubjectTest <- read.table(file.path(data_path, "test", "subject_test.txt"))
SubjectTrain <- read.table(file.path(data_path, "train", "subject_train.txt"))
#Read Feature files
FeatureTest <- read.table(file.path(data_path, "test", "X_test.txt"))
FeatureTrain <- read.table(file.path(data_path, "train", "X_train.txt"))
#Read Name and level files
FeatureName <- read.table(file.path(data_path, "features.txt"))
ActivityLabel <- read.table(file.path(data_path, "activity_labels.txt"))

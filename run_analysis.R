#This is a script to  get clean data
# clear workspace
rm(list = ls())
#load necessary R packages
if(!curl %in% installed.packages()){install.packages("curl")}
#Download the data file and save them in get and clean data folder
if(!file.exists("./cleandata_project")){dir.creat("./cleandata_project")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./cleandata_project/rawdata.zip", method = "curl")
#unzip the file
unzip(zipfile = "./cleandata_project/rawdata.zip", exdir = "./cleandata_project")
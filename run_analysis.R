# Coursera Getting and Cleaning Data Course Project
# Denis Rasulev
# 2015-06-21
#
# This script will perform the following steps on the UCI HAR Dataset:
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names.
# 5. Create a tidy data set with the average of each variable for each activity and each subject.

# Clean up workspace
rm(list=ls())

# Download the file and put it in the data folder
if(!file.exists("./data")) {dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/Dataset.zip", method = "auto")

# Unzip the file
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# Get the list of the files
pathRF <- file.path("./data", "UCI HAR Dataset")
files <- list.files(pathRF, recursive = TRUE)
files

# Read Activity files
dataActivityTest  <- read.table(file.path(pathRF, "test" , "Y_test.txt" ), header = FALSE)
dataActivityTrain <- read.table(file.path(pathRF, "train", "Y_train.txt"), header = FALSE)

# Read Subject files
dataSubjectTrain <- read.table(file.path(pathRF, "train", "subject_train.txt"), header = FALSE)
dataSubjectTest  <- read.table(file.path(pathRF, "test" , "subject_test.txt" ), header = FALSE)

# Read Features files
dataFeaturesTest  <- read.table(file.path(pathRF, "test" , "X_test.txt" ), header = FALSE)
dataFeaturesTrain <- read.table(file.path(pathRF, "train", "X_train.txt"), header = FALSE)

# Look at the properties of the above variables
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)

# Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

# Set names to the variables
names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(pathRF, "features.txt"), head = FALSE)
names(dataFeatures) <- dataFeaturesNames$V2

# Merge columns to get the data frame 'Data' for all data
dataCombined <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombined)

# Subset Name of Features by measurements on the mean and standard deviation,
# i.e taken Names of Features with “mean()” or “std()”
subFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# Subset the data frame 'Data' by selected names of Features
selectedNames <- c(as.character(subFeaturesNames), "subject", "activity" )
Data <- subset(Data, select = selectedNames)

# Check the structure of the data frame 'Data'
str(Data)

# Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(pathRF, "activity_labels.txt"), header = FALSE)

# Factorize variable 'Activity' in the data frame 'Data' using descriptive activity names
head(Data$activity, 30)

# Label the data set with descriptive variable names
names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "freq", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data)

# Create tidy data set and output it
library(plyr);
Data2 <- aggregate(. ~subject + activity, Data, mean)
Data2 <- Data2[order(Data2$subject, Data2$activity),]
write.table(Data2, file = "tidydata.txt", row.name = FALSE)

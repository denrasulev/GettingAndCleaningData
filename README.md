# GettingAndCleaningData

Repository for Coursera "Getting and Cleaning Data" course files.

# The task for the script:

Perform the following steps on the UCI HAR Dataset:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names.
5. Create a tidy data set with the average of each variable for each activity and each subject.

# How run_analysis.R works

01. Cleans up workspace
02. Downloads the file and put it in the data folder
03. Unzips the file
04. Gets the list of the files
05. Reads Activity files
06. Reads Subject files
07. Reads Features files
08. Looks at the properties of the above variables
09. Concatenates the data tables by rows
10. Sets names to the variables
11. Merges columns to get the data frame 'Data' for all data
12. Subsets Name of Features by measurements on the mean and standard deviation,
13. Subsets the data frame 'Data' by selected names of Features
14. Checks the structure of the data frame 'Data'
15. Reads descriptive activity names from “activity_labels.txt”
16. Factorizes variable 'Activity' in the data frame 'Data' using descriptive activity names
17. Labels the data set with descriptive variable names
18. Creates tidy data set and output it

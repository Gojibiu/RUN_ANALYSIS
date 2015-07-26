This file explains how all of the scripts work and how they are connected.

First, run_analysis.R will download the data from the given URL:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Then, it will do these things to get tidy data:
1.merge the training and the test sets to create one data frame.
2.extracts a subset of data with only the measurements on the mean "mean()" and standard deviation "std()" for each measurement Also excludes meanFreq()-X measurements or angle measurements where the term mean exists resulting in 66 measurement variables.
3.updates the variable names in dataframe variable names for data fame to improve readibility
4.appropriately labels the data set with descriptive activity names in place of activity Ids
5.reshapes dataset to create a data frame with average of each measurement variable for each activity and each subject
6.writes new tidy data frame to a text file

the tidy data was put into "tidydata.txt"

code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

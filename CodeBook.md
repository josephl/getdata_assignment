# Getting and Cleaning Data - Assignment CodeBook

This data contains readings from an accelerometer on the Samsung Galaxy SII smartphone while the subject performs different tasks.

The script `run_analysis.R` is used to clean and consolidate data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). It merges training data, test data, and various labels into one cohesive table, and creates and writes out a new table which compiles mean values for each observation based on the unique reading, subject, and activity that subject was performing.

subject - The subject id.
activity - Description of the activity that the subject was performing while values were being read by the accelerometer.
other features - Mean values of mean and standard-deviation values, grouped by the subject and activity.

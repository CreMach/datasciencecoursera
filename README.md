run_analysis.R
===================

This script allows user to clean and combine the training data and testing data obtained from this 
link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. On top of that,
it joins each test subject ID with each activity into a single variable (there will be 180 values for this variable named ID_Activity. Each value under ID_Activity denotes a particular test subject doing a specific activity. For example, "20 Sitting" means data collected came from test subject 20 when she was sitting. The script then will compute the mean of all the relevant variables for every combination of test subjects and activities and create a text file named "clean.txt" in the working directory which contains the end result.

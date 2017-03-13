Introduction
================
This script uses training and test data from UCI's HAR Dataset, and outputs a clean, labeled table consisting of mean values of sensor data aggregated across the experiment's subjects and activities.

Pre-requisites
================
1. Download the UCI HAR Dataset (available here: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/) and extract it into your working directory
2. Run the script

Script processes
================
1. Loads relevant files from the UCI HAR Dataset into memory
2. Merges training and test data sets, as well as related activity labels, and test subjects
3. Searches the feature names looking for either "mean" or "std" in the name, and stores the resultant row numbers in a new filtered_features variable
4. Uses the filtered_features row numbers as a filter on the columns of the dataset, to create a new merged_data data frame that contains the data set filtered by only "mean" or "std" features
5. Uses the same filtered_features row numbers to obtain the feature names and append that to the data.frame
6. Binds the subjects and labels to the data frame
7. Calculates the mean of the variables, aggregating on subject and activity
8. Writes the table to the file system.
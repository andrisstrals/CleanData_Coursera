# CleanData_Coursera
### Coursera Getting and Cleaning Data Course Project

Repository contains Coursera Getting nad Cleaning Data Course project.

The main script in this project is 'run_analysis.R' which performs the following tasks:

1. Downloads data from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
2. Unzips all files into './data' directory
3. Reads all the data for Subject, X, and Y, both training and test datasets using 'read.csv' function.
4. Uses 'rbind' to merge training and test data sets, and 'cbind' to merge Subject, Activity and Measurements.
5. Gives hard-coded names for **Subject** and 'aCtivity' columns, reads 'features.txt' to give meaningful names for other columns in the combined data set.
6. Uses `grepl` to find all column names containing "mean" or "std". Columns containing "meanFreq" are excluded since these contain rate of measurement but not sensor data.
7. Reads IDs and names of activities from 'activity_labels.txt' and converts activity ids in the dataset to descriptive names of activities using `factor`.
8. Uses `ddply` to create a second data set with the average of each variable for each activity and each subject. Data is split by variables *Subject* and *Activity*, `colMeans` are used to calculate means on all columns except first two (Subject and Activity).
9. Uses `write.csv` to save the final tidy dataset as a CSV file names ./data/tidydata.txt.

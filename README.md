---
title: "README.md"
author: "Jen Becker"
date: "July 16, 2015"
output: html_document
---

This describes how to generate the tidy data set and required output files for Project 1 for the *Getting and Cleaning Data* class.

It assumes that the raw data is in a folder in the current working directory called **UCI HAR Dataset**.  This should contain the following:  
* activity_labels.txt  
* features.txt  
* test/subject_test.txt  
* test/X_test.txt  
* test/y_test.txt  
* train/subject_train.txt  
* train/X_test.txt  
* train/y_test.txt  

The script to clean the data is **run_analysis.R**, and it generates as output a tidy data set.  It can be run with no arguments.

The tidy data set consists of the following columns:  
* Subject (factor, values 1-30)  
* Activity (factor, values LAYING, SITTING, STANDING, WALKING, WALKING DOWNSTAIRS, WALKING UPSTAIRS)
* VariableName (factor, values are the names of each observation variable that we are averaging)
* VariableMean (numeric, the average of each observation variable per suject/activity)

This is the wide form as mentioned in the rubric as either long or wide form is acceptable, see https://class.coursera.org/getdata-030/forum/thread?thread_id=107 for discussion.

The input data from the *UCI HAR Dataset* is transformed via the run_analysis script through the following steps:  

1. Read the file activity_labels.txt which provides a correlation between the numbers 1-6 as seen in the data files and the activity they represents (walking, walking upstairs, walking downstairs, sitting, standing, or laying).  
2. Read the file features.txt which contains the column labels for the data files.  
3. Read in subject IDs contained in the train/subject_train.txt and test/subject_test.txt files; these correlate to the rows in the data files to identify the subject whose data is recorded.  
4. Read in the observation data from data files train/X_train.txt and test/X_test.txt; the column names are given in the features.txt file.  
5. Read in the activity IDs for the rows in the data files form the train/y_train.txt and test/y_test.txt; these are converted to a factor and labelled using the activity_lables.txt data gathered earlier.  
6. For each of the training and testing datasets, the subject, activity, and observation data are combined.  
7. The test and training datasets are combined.  
8. Subject ID is converted to a factor.  
9. The full dataset is reduced, keeping only the columns for Subject ID, Activity ID, and the mean and std for the variables estimated from the signals.  
10. For each subject/activity/feature combination, a mean is produced and stored in the longData data frame.  
11. Make the long data into a wide table.
11. Write as output the tidy data set.  
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

This is the long form as mentioned in the rubric as either long or wide form is acceptable, see https://class.coursera.org/getdata-030/forum/thread?thread_id=107 for discussion.
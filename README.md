#GetCleanDataCourseProject
=========================

Coursera Getting and Cleaning Data Course Peer Assessment Course Project

##readme describes things like

###    listing all the related files, 
http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
the zip file which contains the initial raw data set
after it is unzipped the UCI HAR Dataset directory is created under the working directory and contains

UCI HAR Dataset:
README.txt: is presented a little below on the "general description of the raw data and it's source" part of this file
activity_labels.txt: contains the activities long-names connected to values 1:6
features.txt: contains the 561 variables names of the initial data set
features_info.txt:additional info on variables names and explanation of what they are
SUBDIR test:
	X_test.txt:the raw data test file, contains 2947 rows and 561 columns with measurements
	y_test.txt:the raw activities file, contains 2947 rows and 1 column with activity numbers (1:6)
	subject_test.txt:the raw subject file, contains 2947 rows and 1 column with subject numbers (1:30)
	SUBDIR Inertial Signals: contains 9 files with observations, but these are not necessary
SUBDIR train:
	X_train.txt:the raw data train file, contains 7352 rows and 561 columns with measurements
	y_trai.txt:the raw activities file, contains 7352 rows and 1 column with activity numbers (1:6)
	subject_train.txt:the raw subject file, contains 7352 rows and 1 column with subject numbers (1:30)
	SUBDIR Inertial Signals: contains 9 files with observations, but these are not necessary

###    instructions on how to use the script, 
execute the command source("run_analysis.R") from RGUI environment (Windows-user)
This will run the whole script as a whole, just displaying "Starting step x" where x = 1:5
The script should be reside on the working subdirectory.
The script will create the final tidy data set on the working directory with name "TidyFileCourseProject.txt"
###    a general description of the raw data and it's source, 
Data Set Characteristics:  
Multivariate, Time-Series
Number of Instances:10299
Area:Computer
Attribute Characteristics:N/A
Number of Attributes:561
Date Donated 2012-12-10
Associated Tasks:Classification, Clustering
Missing Values? N/A
Number of Web Hits:98367
-------------------------------
HAR Dataset
Human Activity Recognition Using Smartphones Data Set 
Link to UCI Site Download
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Abstract: 
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) 
while carrying a waist-mounted smartphone with embedded inertial sensors.

Source:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - Universit? degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition@smartlab.ws 
www.smartlab.ws 

Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Attribute Information:
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Citation Request:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

###    a description of what the script will do

run_analysis.R
Step 0(initial preparation Step):Download the zipped data and copy them into the working directory
Plain http has been used insted of https
Unzip it (under the working subdirectory)
####Step 1:Merges the training and the test sets to create one data set.
setting the path (under the working directory) for the test file
Displaying the message: Starting step 1
Read the files
"./UCI HAR Dataset/test/X_test.txt"
"./UCI HAR Dataset/train/X_train.txt"
"./UCI HAR Dataset/test/y_test.txt"
"./UCI HAR Dataset/train/y_train.txt"
"./UCI HAR Dataset/test/subject_test.txt"
"./UCI HAR Dataset/train/subject_train.txt"
add the activity, subject columns to test and train files 
by using cbind (files 1,3,5 and 2,4,6) to create a test and train file with 563 columns
Using rbind to create one file with all the data (rows=10299, columns=563)
####Step 2:Extracts only the measurements on the mean and standard deviation for each measurement. 
Displaying the message: Starting step 2
Read file features.txt to name the columns of the total file
Use the names "Activities" and "Subjects" for the two additional columns (562, 563)
find those colnames that contains (exactly) "mean()" or "std()" or "Activity" or "Subject"
The new file has rows=10299, columns=68
####Step 3:Uses descriptive activity names to name the activities in the data set
Displaying the message: Starting step 3
Substitute the variable Activity values (1:6) with desriptive names
WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING
####Step 4:Appropriately labels the data set with descriptive variable names
Displaying the message: Starting step 4
Substitute invalid characters as well as abbreviations with valid and whole name characters in variables column names
####Step 5:Creates a second, independent tidy data set with the average of each variable for each activity and subject
Displaying the message: Starting step 5
load library plyr in order to use ddply function
(the amazing!!, awesome!! ddply function saved me at least one day of work)
use ddply() to create a new file with the mean of 66 columns
write the new tidy data file under working subdirectory with name "TidyFileCourseProject.txt"

------------------------

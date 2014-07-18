##Getting and Cleaning Data Course Project
## Step 0:Download the zipped data and copy them into the working directory
fileUrl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./getdata_projectfiles_UCI HAR Dataset.zip")
##Unzip it
unzip("./getdata_projectfiles_UCI HAR Dataset.zip")
## Step 1:Merges the training and the test sets to create one data set.
##setting the path (under the working directory) for the test file
path1<-"./UCI HAR Dataset/test/X_test.txt"
##setting the path (under the working directory) for the train file
path2<-"./UCI HAR Dataset/train/X_train.txt"
##setting the path (under the working directory) for the test file labels
path3<-"./UCI HAR Dataset/test/y_test.txt"
##setting the path (under the working directory) for the train file labels
path4<-"./UCI HAR Dataset/train/y_train.txt"
##setting the path (under the working directory) for the subjects test file 
path5<-"./UCI HAR Dataset/test/subject_test.txt"
##setting the path (under the working directory) for the subjects train file
path6<-"./UCI HAR Dataset/train/subject_train.txt"
##read the four files
tf<-read.table(path1, header=FALSE, sep = "")
trf<-read.table(path2, header=FALSE, sep = "")
tfl<-read.table(path3, header=FALSE, sep = "")
trfl<-read.table(path4, header=FALSE, sep = "")
tfs<-read.table(path5, header=FALSE, sep = "")
trfs<-read.table(path6, header=FALSE, sep = "")
##adding the activity, subject columns to test and train files
tf<-cbind(tf, tfl, tfs)
trf<-cbind(trf, trfl, trfs)
##create ONE file that contains both test and train files
ttf<-rbind(tf, trf)
## checking the number of rows, columns
dim(ttf)
## Step 2:Extracts only the measurements on the mean and standard deviation 
##        for each measurement. 
path<-"./UCI HAR Dataset/features.txt"
features<-read.csv(path, header=FALSE,sep = " ")
actsub<-data.frame(matrix(vector(), 2, 2, dimnames=list(c(), c("V1", "V2"))), 
                   stringsAsFactors=F)
actsub[1,1]<-562
actsub[1,2]<-"Activity"
actsub[2,1]<-563
actsub[2,2]<-"Subject"
colnames(actsub)<-colnames(features)
features<-rbind(features, actsub)
colnames(ttf)<-features$V2
##find those colnames that contains (exactly) "mean()" or
## "std()" or "Activity" or "Subject"
tidyf<-ttf[,grep("\\bmean()\\b|std()|Activity|Subject", colnames(ttf))]
## Step 3:Uses descriptive activity names to name the activities in the data set
path<-"./UCI HAR Dataset/activity_labels.txt"
actlab<-read.csv(path, header=FALSE,sep = " ")
for (i in 1:6) {
  tidyf$Activity<-gsub(actlab$V1[i], actlab$V2[i], tidyf$Activity)
}
## Step 4:Appropriately labels the data set with descriptive variable names
colnames(tidyf)<-gsub("-", "", colnames(tidyf))
colnames(tidyf)<-gsub("\\(", "", colnames(tidyf))
colnames(tidyf)<-gsub("\\)", "", colnames(tidyf))
colnames(tidyf)<-gsub(",", "", colnames(tidyf))
colnames(tidyf)<-gsub("^t", "TimeSignals", colnames(tidyf))
##colnames(tidyf)<-gsub("anglet", "angleTimeSignals", colnames(tidyf))
colnames(tidyf)<-gsub("^f", "Frequency", colnames(tidyf))
colnames(tidyf)<-gsub("Acc", "Acceleration", colnames(tidyf))
colnames(tidyf)<-gsub("Gyro", "Gyroscope", colnames(tidyf))
colnames(tidyf)<-gsub("std", "Standarddeviation", colnames(tidyf))
colnames(tidyf)<-gsub("mean", "Mean", colnames(tidyf))
colnames(tidyf)<-gsub("X", "Xaxis", colnames(tidyf))
colnames(tidyf)<-gsub("Y", "Yaxis", colnames(tidyf))
colnames(tidyf)<-gsub("Z", "Zaxis", colnames(tidyf))
colnames(tidyf)<-gsub("BodyBody", "Body", colnames(tidyf))
##colnames(tidyf)<-gsub("angle", "Angle", colnames(tidyf))
##colnames(tidyf)<-gsub("gravity", "Gravity", colnames(tidyf))
###colnames(tidyf)<-gsub("MeanFreq", "Mean", colnames(tidyf))
###colnames(tidyf)<-gsub("MagFreq", "Mag", colnames(tidyf))
## Step 5:Creates a second, independent tidy data set with the average of each variable 
##        for each activity and each subject
ntidyf<-ddply(tidyf, .(Subject, Activity), numcolwise(mean))
write.table(ntidyf, "./TidyFileCourseProject.txt", row.names=FALSE)
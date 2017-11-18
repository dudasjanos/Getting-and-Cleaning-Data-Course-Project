# CodeBook
The original data and a full description is available at the following sites:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Variables 
* data - the test and train data sets
* label - the activity labels
* subject - the subject of the observations
* activities - the name of each type of activity

## The transformations
* merge the test and train datasets
* keep the variables which contain mean or standard deviation
* relabel the name of activities
* merge the data, the labels and the subject datasets
* calculate the mean of each variable for each activity and each subject.

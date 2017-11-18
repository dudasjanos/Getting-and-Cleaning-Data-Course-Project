run_analysis <- function() {
    # The aim of the following function is:
    # Merges the training and the test sets to create one data set.
    # Extracts only the measurements on the mean and standard deviation for each measurement.
    # Uses descriptive activity names to name the activities in the data set
    # Appropriately labels the data set with descriptive variable names.
    # From the data set in step 4, creates a second, independent tidy data set with
    #     the average of each variable for each activity and each subject.
    
    library(dplyr)
    
    # read and merge the labels
    label1 <- read.table("./UCI HAR Dataset/test/y_test.txt")
    label2 <- read.table("./UCI HAR Dataset/train/y_train.txt")
    label <- rbind(label1, label2)
    rm(label1, label2)
    names(label)="activity"

    # read and merge the subjects
    subject1 <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    subject2 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    subject <- rbind(subject1, subject2)
    rm(subject1, subject2)
    names(subject)="subject"
    
    #  read the names of the variables
    varnames <- read.table("./UCI HAR Dataset/features.txt")
    
    #  read the names of the activities
    activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
    
    # read and merge the 2 data sets
    data1 <- read.table("./UCI HAR Dataset/test/X_test.txt")
    data2 <- read.table("./UCI HAR Dataset/train/X_train.txt")
    # data1 <- cbind(data1, label1)
    data <- rbind(data1, data2)
    rm(data1, data2)
    
    #  the numbers of the var.names that contains
    # mean or standard deviation
    rem_var <- grep("mean|std", varnames[,2])
    
    # extract the necessary variables
    data <- select(data, rem_var)
    
    # name the activities
    label[,1] <- factor(label[,1])
    levels(label[,1]) <- as.vector(activities[,2])
    
    # descriptive variable names
    colnames(data) <- gsub("[-()]","",varnames[rem_var, 2])
    
    # merging the 3 tables
    data <- cbind(data, label, subject)
    
    new_data <- data %>% group_by(activity, subject) %>%
        summarise_all(funs(mean))
    new_data
    
    write.table(new_data, file="new.txt", row.name=FALSE)
}
run_analysis <- function() {

    # looks for dataset dir
    if (!dir.exists("UCI HAR Dataset")) {
        # if dir not found looks for zip file
        if (!file.exists("UCI HAR Dataset.zip")) {
            # if zip file not found either then downloading it
            url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            download.file(url, destfile = "UCI HAR Dataset.zip")
        }
        # and unzip
        unzip("UCI HAR Dataset.zip")
    }

    # go inside dataset dir
    setwd("UCI HAR Dataset")
    
    # loading metadata: feature names
    Xnames <- read.table("features.txt", stringsAsFactors = FALSE)
    Xnames <- Xnames[,2]
    # select only mean and std features
    Xselect <- grepl("mean|std", Xnames) | grepl("std", Xnames)
    # and only their names required
    Xnames <- Xnames[Xselect]
    
    # loading feature data
    Xdata <- rbind(read.table("train/X_train.txt", colClasses = rep("numeric", 561)),
                   read.table("test/X_test.txt", colClasses = rep("numeric", 561)))
    # select only required data and assign names
    Xdata <- Xdata[,Xselect]
    names(Xdata) <- Xnames

    # loading metadata: activity names
    Ylevels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)

    # loading activity data and convert to factor
    Activity <- rbind(read.table("train/y_train.txt", colClasses = "integer"),
                      read.table("test/y_test.txt", colClasses = "integer"))
    Activity <- factor(Activity[,1], levels = Ylevels[,1], labels = Ylevels[,2])
    
    # loading subject data
    Subject <- rbind(read.table("train/subject_train.txt", colClasses = "factor"),
                     read.table("test/subject_test.txt", colClasses = "factor"))
    Subject <- Subject[,1]
    
    # going back to project dir
    setwd("..")
    
    # merge subject, activity and features - dataset for step 4
    data <- cbind(Subject, Activity, Xdata)
    
    # write it (oh, 2.7Mb, maybe not)
    # write.table(data, "data-step-4.txt", row.names = FALSE)
    
    # using reshape2 to generate step 5 dataset
    library(reshape2)
    # melt data by subject and activity
    meltData <- melt(data, id = c("Subject", "Activity"), measure.vars = Xnames)
    # calculate mean values of all features grouped by subject and activity
    meanData <- dcast(meltData, Subject + Activity ~ variable, mean)
    
    # write it
    write.table(meanData, "data-step-5.txt", row.names = FALSE)
    
}
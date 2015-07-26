    if (!file.exists("C:/Gojibiu")) {dir.create("C:/Gojibiu")}
    harDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(harDataUrl, destfile = "C:/Gojibiu/UCI HAR Dataset.zip", method = "curl")
    list.files("C:/Gojibiu")
    unzip("C:/Gojibiu/UCI HAR Dataset.zip", exdir="C:/Gojibiu")
    list.files("C:/Gojibiu/UCI HAR Dataset")
    
    FEATURES<-read.table("C:/Gojibiu/UCI HAR Dataset/features.txt", sep="", header=FALSE)
    LABELS<-read.table("C:/Gojibiu/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
    colnames(FEATURES)<-c("varId", "varName")
    colnames(LABELS)<-c("activityId", "activityName")
    xtest<-read.table("C:/Gojibiu/UCI HAR Dataset/test/X_test.txt", sep="",header=FALSE)
    ytest<-read.table("C:/Gojibiu/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
    subjecttest<-read.table("C:/Gojibiu/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
    xtrain<-read.table("C:/Gojibiu/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
    ytrain<-read.table("C:/Gojibiu/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
    subjecttrain<-read.table("C:/Gojibiu/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
    colnames(xtest)<-FEATURES$varName
    colnames(ytest)<-"activityId"
    colnames(subjecttest)<-"subjectId"
    colnames(xtrain)<-FEATURES$varName
    colnames(ytrain)<-"activityId"
    colnames(subjecttrain)<-"subjectId"
    test<-cbind(subjecttest, ytest, xtest)
    train<-cbind(subjecttrain, ytrain, xtrain)
    newdata<-rbind(test, train)
    subsetFeatureVarIndex<-grep("mean\\(\\)|std\\(\\)", names(newdata))
    subsetnewdata<-newdata[ , c(1,2, subsetFeatureVarIndex)]
    names(subsetnewdata)<-gsub("-", "", names(subsetnewdata))
    names(subsetnewdata)<-gsub("\\(\\)", "", names(subsetnewdata))
    names(subsetnewdata)<-gsub("mean", "Mean", names(subsetnewdata))
    names(subsetnewdata)<-gsub("std", "Std", names(subsetnewdata))
    subFinalData<-merge(LABELS, subsetnewdata, by="activityId", all=TRUE)
    finalData<-subset(subFinalData, select = -activityId)
    library(reshape2)
    finalDataMelt<-melt(finalData, id.vars=c("activityName", "subjectId"), measure.vars=(names(finalData[3:68])) )
    tidydata<-dcast(finalDataMelt, activityName + subjectId ~variable, mean)
    write.table(tidydata, "tidydata.txt", sep="\t", row.names=FALSE)

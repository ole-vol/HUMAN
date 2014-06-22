#Script for making tidy data out of a activity measurement of samsung samrtphone.

#First step reading the test-data sets.
subjects_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/y_test.txt")


#Second step reading the train-data sets.
subjects_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

#Third step merging the train and test dataset
Y<-rbind(Y_test,Y_train)
x<-rbind(X_test,X_train)
subjects<-rbind(subjects_test,subjects_train)

#4th stepreading the features-names and setting the colnames to these names
features<-read.table("UCI HAR Dataset/features.txt")
colnames(x)<-features[,2]

#5th step merging all the data in the dataframe measure. The first 561 Variable are the
# features of the measurement, the 562 variable are the activity-numbers and the
# 563. variable are the subject-numbers
measure<-x
measure$Y<-Y
measure$subjects<-subjects

#6th step subsetting only the variable with means and standart derivates in its names
# and creating a second data frame measure_mean_std with these variables and the acitivty-numbers
# and subject numbers.
measure_mean_std<-measure[grepl("mean()",colnames(measure))|grepl("std()",colnames(measure))]
measure_mean_std$Y<-Y[,1]
measure_mean_std$Subjects<-subjects[,1]

#7th step reading the activity-labels and setting them as levels of the activiy numbers
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
levels(measure_mean_std$Y)<-activity_labels[,2]

# 8th Setting the activity-lables from factors to character so that you reading the activitys in the table.
i <- sapply(measure_mean_std, is.factor)
measure_mean_std[i] <- lapply(measure_mean_std[i], as.character)

#9th writing the table to measure_mean_std.txt
write.table(measure_mean_std,"measure_mean_std.txt")

#Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.

#1st step splitting the measurement in activity- tables  (Y is the activity-number) 
measure_avg<-split(measure,measure$Y)

#2nd creating a dummy variable saver which will save the COLUMNS of the matrix measure_avg_split,
#which will have the avg features for each subject and each activity
saver<-NULL
measure_avg_split = matrix(NaN, nrow=180,ncol=561)

#Thrid step for each feature of the measurement a columns is created which includes in the first
#six rows the avg of the feature for the first subject and the six activitys and in the second
#six rows the avg of the feature for the second subject and the six activitys and so on...
for(j in 1:561)
    {
        for(i in 1:6)
        {
            saver<-c(saver,tapply(measure_avg[[i]][[j]],measure_avg[[i]]$subjects,mean))
        }
        measure_avg_split[,j]<-saver
        saver=NULL
    }

#4th step wrting a dataframe out of the matrix measure_avg_split
measure_splits<-data.frame(measure_avg_split)

#5th step labeling the variables of the measurement with the feature-names
colnames(measure_splits)<-features[,2]

#6th step adding the activity column to the data frame. Because the first six rows a the
#activitys og the first person, they are labeled with 1:6, as the next sixt rows and so on.
measure_splits$acivitys<-as.factor(c(rep(1:6,30)))

#7th step the first 6 rows of the data frame belongs to the first subject and the second
# six rows to second subject and so on.. So we creating a vector which looks like 
#(1,1,1,1,1,1,2,2,2,2,2,2,3....) and adding a column with the subject numbers to the data frame
subj<-NULL
for(i in 1:30){subj<-c(subj,rep(i,6))}
measure_splits$subjects<-as.factor(subj)

#8th step reading the activity-labels and setting them as levels of the activiy numbers
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
levels(measure_splits$acivitys)<-activity_labels[,2]

# 9th Setting the activity-lables from factors to character so that you reading the activitys in the table.
i <- sapply(measure_splits, is.factor)
measure_splits[i] <- lapply(measure_splits[i], as.character)

#writing the data frame to measure_splits.txt
write.table(measure_splits,"measure_splits.txt")

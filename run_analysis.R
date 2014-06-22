#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#setwd("~/Turkmen/getting-and-cleaning-data/project/UCI HAR Dataset/");
X_train <-read.table("./train/X_train.txt", quote="\"");
X_test <-read.table("./test/X_test.txt", quote="\"");
features <- read.table("./features.txt", quote="\"")
activity_labels <- read.table("./activity_labels.txt", quote="\"");
subject_train <- read.table("./train/subject_train.txt", quote="\"");
subject_test <- read.table("./test/subject_test.txt", quote="\"");
y_train <- read.table("./train/y_train.txt", quote="\"")
y_test <- read.table("./test/y_test.txt", quote="\"")

convert=function(activity_no,activity_labels){
  idx=which(activity_labels[,1]== activity_no);
  return (as.character(activity_labels[idx,2]));
}

al_train=c()
for( i in y_train[,1]){
  al=convert(i,activity_labels);
  al_train=c(al_train,al);
}
al_test=c();
for( i in y_test[,1]){
  al=convert(i,activity_labels);
  al_test=c(al_test,al);
}

columns_to_choose=grep("*[sS]td*|*[mM]ean*",features[,2]);
column_names=as.character(features[columns_to_choose,2]);


#merging training and test
X_filtered_train=X_train[,columns_to_choose]
X_filtered_test=X_test[,columns_to_choose]

X_filtered=rbind(X_filtered_train,X_filtered_test);
subject=rbind(subject_train,subject_test);
y_labeled=c(al_train,al_test);

tidy_set=data.frame(cbind(subject,y_labeled,X_filtered));
names(tidy_set)=c("Subject","Activity",column_names)

#save it to disk
write.csv(x=tidy_set,file="tidy_set.txt")
###now second

columns_to_choose_for_mean=grep("*[mM]ean*",features[,2]);
column_names_for_mean=as.character(features[columns_to_choose_for_mean,2]);

X_filtered_train_2=X_train[,columns_to_choose_for_mean]
X_filtered_test_2=X_test[,columns_to_choose_for_mean]

X_filtered_2=rbind(X_filtered_train_2,X_filtered_test_2);


tidy_set_mean=data.frame(cbind(subject,y_labeled,X_filtered_2));
names(tidy_set_mean)=c("Subject","Activity",column_names_for_mean)
write.csv(x=tidy_set_mean,file="tidy_set_mean.txt")

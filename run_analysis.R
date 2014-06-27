#Downloading the file
run_analysis <- function(){
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile<-"./project.zip",method="curl")

#loading test data sets
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
Sub_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
names(Sub_test)<-"sub_id"
feature<-read.table("./UCI HAR Dataset/features.txt")

#loading train data sets
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
sub_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

#combining X test and X train data sets
X_merge<-rbind(X_test,X_train)
nrow(X_merge) - #10299 rows
ncol(X_merge) - #561 cols
colnames<-names(X_merge)
mean<-grep("mean\\(\\)",colnames) # identifying columns containing word mean.
std<-grep("std\\(\\)",colnames)  # identifying columns containing word std.
mean_std_col<-c(mean,std) 

X_test_train<-X_merge[,mean_std_col] #selecting columns with mean and std

#combining Y test and Y train data sets
Y_test_train<-rbind(Y_test,Y_train) 
sub_test_train<-rbind(Sub_test,sub_train)

#combining X,Y and Subject data sets
merge_test_train<-cbind(sub_test_train,Y_test_train,X_test_train)
data<-merge_test_train[order(merge_test_train$sub_id),]
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")# reading activity label data

# merging  activity data set with the data we obtained by previous steps
merged_data<-merge(activity,data,by.x="activity_id",by.y="activity",all=TRUE)
ordered_merged_data<-merged_data[order(merged_data$sub_id),]
rearranged<-ordered_merged_data[,c(3,1,2,4:69)] # rearranging the columns

#cleaning the data to remove () and - symbols from the columns for further processing 
cleanData<-gsub("\\(\\)","",names(rearranged)) 
ncleanData<-gsub("-","",names(rearranged))
names(rearranged)<-cleanData
names(rearranged)<-ncleanData

#performing aggregation on individual subjects and activity they performed
aggdata <- aggregate(rearranged[,4:69], list(activity=rearranged$activity,sub_id=rearranged$sub_id), FUN=mean)

finaldata<-aggdata[,c(2,1,3:68)]

write.table(finaldata,"./project.txt")  
}

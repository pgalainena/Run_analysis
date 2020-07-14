#Download and read data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./Dataset.zip", method= "curl")
unzip("./Dataset.zip")
Subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
Y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
Subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
Y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

#1. Merge the training and the test sets to create one data set.
Subject<-rbind(Subject_test, Subject_train)
Labels<-rbind(Y_test, Y_train)
Set<-rbind(X_test, X_train)

names(Subject)<-"Subject"
names(Labels)<-"Activity"

Features<-read.table("./UCI HAR Dataset/features.txt", header = FALSE)
names(Set)<-Features$V2

Final_data<-cbind(Subject, Labels, Set)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_data<-Final_data[,c(1,2,grep("mean|std", names(Final_data)))]
              
#3. Uses descriptive activity names to name the activities in the data set
Activity_names<-read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
mean_std_data$Activity<-factor(mean_std_data$Activity, levels=Activity_names$V1, labels=Activity_names$V2)

#4. Appropriately labels the data set with descriptive variable names.
names(mean_std_data)
names(mean_std_data)<-gsub("^t", "Time", names(mean_std_data))
names(mean_std_data)<-gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data)<-gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data)<-gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data)<-gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data)<-gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data)

#5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
install.packages("dplyr")
library(dplyr)
Independent_tidy_data <- mean_std_data %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
write.table(Independent_tidy_data, file = "Independent_tidy_data.txt",row.name=FALSE)




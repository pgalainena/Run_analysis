In this code book all the variables, data, transformations and work performed to clean up the data is described:

1. Merge the training and the test sets to create one data set:

  cbind and rbind functions are used to combine different sets by columns and rows.
  names function used to define all the variable names of the data set.
  
  Final_data is the final data set that contains all the information

2. Extract only the measurements on the mean and standard deviation for each measurement:

  grep function used to search for matches to "mean"" and "std" within each element of the vector formed by the names of the       columns.
  
  mean_std_data is the data set that contains only the measurements on the mean and standard deviation for each measurement.

3. Use descriptive activity names to name the activities in the data set:

  factor function used to encode the Activity column as a factor and change numbers to descriptive activity names.

4. Appropriately label the data set with descriptive variable names:

  gsub function used to replace abbreviations with descriptive names


5. Create a second, independent tidy data set with the average of each variable for each activity and each subject:

  group_by function used to convert the data set into a grouped one where operations such as the average of each variable are performed by group.
  
  Independent_tidy_data is the independent tidy data set with the average of each variable for each activity and each subject.
  

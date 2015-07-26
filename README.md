## Processes of Getting and Cleaning Data Course Project

For this project, the script for data processing is in the file "run_analysis.R",
final tidy data is stored in the file "tidydata.txt", with description in the file
"CodeBook.md"

In the script "run_analysis.R", it does the following:  
1.Merges the training and the test sets to create one data set.  
        Read the data of training set from file "train/X_train.txt", "train/Y_train.txt",
        "train/subject_train.txt", and the data of test set from file "test/X_test.txt",
        "test/Y_test.txt"", "test/subject_test.txt".  
        For training set, "train/Y_train.txt" stores the activity for each observation in 
        "train/X_train.txt", and "train/subject_train.txt" strores the the subject who 
        performed the activity for each. Thus, use cbind to combine them at the beginning of
        process.  
        It is the same for test set.  
        Then use rbind to merge the training and the test sets, as both sets have the same 
        column structure.  
        And then read the column names from file "features.txt", assign them to the merge 
        data set. And delete duplicate columns.

2.Extracts only the measurements on the mean and standard deviation for each measurement.   
Use seclect funtion to abstract all the columns contains "mean()" or "std()", and store
the subset in a new data frame mrgsub.

3.Uses descriptive activity names to name the activities in the data set.  
Read the activities names from file "activity_labels.txt". Use mutate function to replace 
the activity number into name label.

4.Appropriately labels the data set with descriptive variable names. 
Use sub fuction to replace short form of the column names in to more readable descriptive
variable names.  
  
5.From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.  
Use summarise_each and group_by function to calculate mean and sum of each variable for 
each activity and each subject. Store it into a new data frame tidydata.  
Extracts all the mean columns and rename them with suffix ".Average".  
Finally write this data to "tidydata.txt".  


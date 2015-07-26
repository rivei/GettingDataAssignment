## load library for data processing
library(dplyr)

## read train and test data and combine the index of each set
trainset <- cbind(read.table("train/subject_train.txt"),
                  read.table("train/Y_train.txt"),
                  read.table("train/X_train.txt"))

testset <- cbind(read.table("test/subject_test.txt"),
                 read.table("test/Y_test.txt"),
                 read.table("test/X_test.txt"))

## 1. Merges the training and the test sets to create one data set.
mrg <- rbind(trainset, testset)

## set column names to the data set and clear duplicate columns
cfeatures <- read.table("features.txt", stringsAsFactors = FALSE)
colnames(mrg) <- c("subjectID", "activity", cfeatures[,2])
mrg <-  mrg[, unique(colnames(mrg))]

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mrgsub <- select(mrg, subjectID, activity, contains("mean()"), contains("std()"))
gat <- gather(mrgsub, key = Variable.Stat, value = Num, -c(subjectID,activity))
gat <- separate(gat, Variable.Stat, c("features", "Stat", sep="-"))

## 3. Uses descriptive activity names to name the activities in the data set
cActivity <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
mrgsub <- mutate(mrgsub, activity = cActivity[activity,2])

## 4. Appropriately labels the data set with descriptive variable names.
colnames(mrgsub) <- sub("-", ".", colnames(mrgsub))
colnames(mrgsub) <- sub("Acc", ".Accelerometer", colnames(mrgsub))
colnames(mrgsub) <- sub("Gyro", ".Gyroscope", colnames(mrgsub))
colnames(mrgsub) <- sub("Mag", ".Magnitude", colnames(mrgsub))
colnames(mrgsub) <- sub("Jerk", ".Jerk", colnames(mrgsub))
colnames(mrgsub) <- sub("-X", ".X.Axis", colnames(mrgsub))
colnames(mrgsub) <- sub("-Y", ".Y.Axis", colnames(mrgsub))
colnames(mrgsub) <- sub("-Z", ".Z.Axis", colnames(mrgsub))
colnames(mrgsub) <- sub("*mean[()][()]","Mean",colnames(mrgsub))
colnames(mrgsub) <- sub("*std[()][()]","Standard.Deviation",colnames(mrgsub))

## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.
tidydata <- summarise_each(group_by(mrgsub, subjectID, activity), funs(mean))
## tidy the data set with narrow format
tidydata <- gather(tidydata, key = Variable, value = Average, -c(subjectID,activity))
write.table(tidydata, "tidydata.txt", row.names = FALSE)

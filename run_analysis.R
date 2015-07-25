library(dplyr)

## Read data into R
## subject_ Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
## X_       Available variables for determining an activity label
## y_       Activity label according to the variables

activity_labels <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/activity_labels.txt")
features <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/features.txt")

subject_test <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/test/X_test.txt")   # test set
Y_test <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/test/y_test.txt")   # test label
colnames(X_test) <- features$V2
colnames(subject_test) <- "subject"
colnames(Y_test) <- "activity_label"
testData <- cbind(subject_test, Y_test, X_test)

subject_train <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/train/X_train.txt") # training set
Y_train <- read.table("C:/Users/stefan/Documents/R/getting and cleaning data/project/UCI HAR Dataset/train/y_train.txt") # training label
colnames(X_train) <- features$V2
colnames(subject_train) <- "subject"
colnames(Y_train) <- "activity_label"
trainData <- cbind(subject_train, Y_train, X_train)

rm(list = c("subject_test","X_test","Y_test","subject_train","X_train","Y_train","features"))

## Merge training and test set into one data set
testData <- mutate(testData,group = "test")
trainData <- mutate(trainData, group = "train")
data <- rbind(testData, trainData)

## Extract the mean and standard deviation for each measurement
data <- data[,grepl("subject",colnames(data)) | grepl("activity..",colnames(data)) | (grepl("-mean()",colnames(data)) & !grepl("-meanFreq()",colnames(data))) | grepl("-std()",colnames(data))]

## Use descriptive activity names to name the activities
data$activity_label <- factor(data$activity_label, levels = activity_labels[,1], labels = activity_labels[,2])

## Appropriately label the data set with descriptive variable names
data <- rename(data, activity=activity_label, subjectID=subject)
colnames(data) <- gsub("-mean","Mean",colnames(data))
colnames(data) <- gsub("-std","Std",colnames(data))
colnames(data) <- gsub("[()]","",colnames(data))
colnames(data) <- gsub("[-]","",colnames(data))

## From step 4, create a 2nd, independent tidy data set with the average 
## of each variable for each activity and each subject
averageData <- data %>% group_by(subjectID,activity) %>% summarise_each(funs(mean))
write.table(averageData,"C:/Users/stefan/Documents/R/getting and cleaning data/project/data.txt",row.name = FALSE)

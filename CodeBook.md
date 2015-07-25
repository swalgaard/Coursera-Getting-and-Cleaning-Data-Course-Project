
The script run_analysis.R performs 5 steps as described in the course definition

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Variables
test contains a test data set and train contains a training data set
x_train and x_test contain the variables for determining an activity label
y_train and y_test contain the activity label according to the variables
subject_train and subject_test contain the subject who performed the activity for each window sample

x_train, y_train and subject_train are merged to trainData.
x_test, y_test and subject_test are merged to testData.

trainData and testData are merged to data

Variables that do not contain mean or sd are extracted.

Variables are renamed with descriptive names

the average per subject and per activity is calculated and stored in the tidy dataset averageData

averageData is exported as data.txt

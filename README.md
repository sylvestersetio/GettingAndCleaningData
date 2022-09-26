# GettingAndCleaningData

Libraries used:

tidyverse
stringi
The purpose of this code is to get data from the following website and do some data cleanup for further analysis. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

When the code downloads the zip file from the link above, the user is given multiple text files. [1] "./UCI HAR Dataset/activity_labels.txt"
[2] "./UCI HAR Dataset/features.txt"
[3] "./UCI HAR Dataset/features_info.txt"
[4] "./UCI HAR Dataset/README.txt"
[5] "./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"
[6] "./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"
[7] "./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"
[8] "./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"
[9] "./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"
[10] "./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"
[11] "./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"
[12] "./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"
[13] "./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"
[14] "./UCI HAR Dataset/test/subject_test.txt"
[15] "./UCI HAR Dataset/test/X_test.txt"
[16] "./UCI HAR Dataset/test/y_test.txt"
[17] "./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt" [18] "./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt" [19] "./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt" [20] "./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt" [21] "./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt" [22] "./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt" [23] "./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt" [24] "./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt" [25] "./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt" [26] "./UCI HAR Dataset/train/subject_train.txt"
[27] "./UCI HAR Dataset/train/X_train.txt"
[28] "./UCI HAR Dataset/train/y_train.txt"

The code will open the text files individually and whatever can be turned into dataframe will be turned as such. features_info.txt and README.txt is not in a table structure

The code will append the test and train data together from x, y, and subject by rows initially and then by columns once row sizes are adequate. x_test and x_train AND y_train and y_test AND subject_train and subject_test will be appended using rbind (to add more rows) The table size will result in 10,299 rows and we can cbind them together to result in 563 rows

The code will then select all columns containing "mean" and "std" in its name List of column name is too large to be contained here.

The code will then merge with each other according to the activity code. 1 = WALKING 2 = WALKING_UPSTAIRS 3 = WALKING_DOWNSTAIRS 4 = SITTING 5 = STANDING 6 = LAYING

The code will then get all column names, rename each column based on regular expression (regex), and replace it back to the table Acc = Accelerometer Gyro = Gyroscope Anything that starts with t = "Euclid" Anything that starts with f = "FastFourierTrans." tBody = Time Body BodyBody = Body .mean() = Mean .std() = StDev .freq() = frequency angle. = Angle

The code will then create summary statistic through grouping by Subject and Activity and summarizing across everything and based on mean. The code will then create text file named "FinalProject_Problem5.txt".

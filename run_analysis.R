# Open up library
library(tidyverse)
library(stringi)


# Downloading the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp, mode = "wb")
con <- unzip(temp)

# Opening up fully text file
features_info <- read.table(file = con[3], header = TRUE, sep = '\t')
readme <- read.table(file = con[4], header = TRUE, sep = "\t")

# Opening up table files
activity_labels <- read.table(file = con[1], col.names = c("code", "activity"))
features <- read.table(file = con[2], col.names = c("code", "feature"))
x_test <- read.table(file = con[15], col.names = (features$feature))
y_test <- read.table(file = con[16], col.names = "code")
subject_test <- read.table(file = con[14], col.names = "subjectCode")

x_train <- read.table(file = con[27], col.names = (features$feature))
y_train <- read.table(file = con[28], col.names = "code")
subject_train <- read.table(file = con[26], col.names = "subjectCode")

# Append x_train and x_test AND y_train and y_test

x_append <- rbind(x_train, x_test)
y_append <- rbind(y_train, y_test)
subject_append <- rbind(subject_train, subject_test)
Merged_All <- cbind(subject_append, y_append, x_append)

# Get data containing mean and std
Problem2 <- Merged_All %>%
  select(subjectCode, code, contains(c("mean", "std")))


# Replace numeric label with descriptive activity label
Problem3 <- merge(Problem2, activity_labels, by = "code", all.x = TRUE)
Problem3 <- Problem3 %>%
            select(subjectCode, code, activity, contains(c("mean", "std")))

# Replace cryptic column names with more sensible column names
Problem4 <- Problem3
Problem4colnames <- colnames(Problem4) #get all column names

# replace string using regular expressions
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = "Acc", "Accelerometer")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = "Gyro", "Gyroscope")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = "^t", "Euclid")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = "^f", "FastFourierTrans.")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = "tBody", "TimeBody")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = "BodyBody", "Body")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = ".mean()", "Mean")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = ".std()", "StDev")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = ".freq()", "frequency")
Problem4colnames <- stri_replace_all_regex(Problem4colnames, pattern = "angle.", "Angle")

# replace the colnames with array
colnames(Problem4) <- Problem4colnames

# Create summary statistic
Problem5 <- Problem4 %>%
  group_by(activity) %>%
  summarise(across(everything(), mean))

write.table(Problem5, "FinalProject_Problem5.txt", row.name = FALSE)

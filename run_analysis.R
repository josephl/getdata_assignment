# Joseph Lee
# Getting and Cleaning Data
# Course Porject
# 12/21/2014
# run_analysis.R
# Note: The requirements (1-5) of the assignment aren't performed in order

setwd('UCI HAR Dataset/')
options(stringsAsFactors = FALSE)


# 1) Merge training and test sets into one dataset

raw_train <- read.table('train/X_train.txt')
raw_test <- read.table('test/X_test.txt')
dataset <- rbind(raw_train, raw_test)

# 4) Appropriately labels the data set with descriptive variable names.
feature_names <- read.table('features.txt', col.names = c('feature_id', 'feature_name'))
colnames(dataset) <- feature_names$feature_name

# 2) Extract only mean and stddev measurements
keep_feature_idxs <- c(seq(1, 6), seq(41, 46), seq(81, 86), seq(121, 126),
                       seq(161, 166), 201, 202, 214, 215, 227, 228, 240, 241,
                       253, 254, seq(266, 271), seq(345, 350), seq(424, 429),
                       503, 504, 516, 517, 529, 530, 542, 543)
dataset <- dataset[, keep_feature_idxs]

# 3) Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('activity_labels.txt', col.names = c('activity_id', 'activity_name'))
raw_train_labels <- read.table('train/y_train.txt', col.names = c('activity_id'))
raw_test_labels <- read.table('test/y_test.txt', col.names = c('activity_id'))
labels <- rbind(raw_train_labels, raw_test_labels)
labels <- merge(labels, activity_labels, by = 'activity_id', sort = FALSE)
dataset$activity <- labels$activity_name

# 5) From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

# first, add subect data
subject_train <- read.table('train/subject_train.txt', col.names = c('subject_id'))
subject_test <- read.table('test/subject_test.txt', col.names = c('subject_id'))
subjects <- rbind(subject_train, subject_test)
dataset$subject <- subjects$subject_id

avgs <- aggregate(dataset[, 1:(length(dataset) - 2)], list(dataset$activity, dataset$subject), mean)
colnames(avgs)[1:2] <- c('activity', 'subject')
write.table(avgs, 'dataset.txt', row.names = FALSE)

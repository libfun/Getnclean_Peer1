# Download and extract the archive
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'dataset.zip', method = 'curl')
unzip('dataset.zip')

# Read train dataset into data_train variable
obs <- length(readLines('./UCI HAR Dataset/train/X_train.txt'))
data_train <- read.fwf('./UCI HAR Dataset/train/X_train.txt', widths = rep(16, 561), header = FALSE, n = obs, buffersize = 100)

# Get feature names from features.txt file and apply them to data_train
data_features <- read.csv('./UCI HAR Dataset/features.txt', sep = ' ', header = FALSE)
names(data_train) <- data_features[,2]

# Select features with means and standard deviations and subset by them
meansnstds <- names(data_train)[grepl('mean()', names(data_train)) | grepl('std()', names(data_train))]
smaller_train <- data_train[,meansnstds]

# Add column of labels and subjects to the dataset
train_labels <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE)
smaller_train$Label <- train_labels$V1
train_subjects <- read.csv('./UCI HAR Dataset/train/subject_train.txt', header = FALSE)
smaller_train$Subject <- train_subjects$V1

# Repeat above for the test dataset
obs <- length(readLines('./UCI HAR Dataset/test/X_test.txt'))
data_test <- read.fwf('./UCI HAR Dataset/test/X_test.txt', widths = rep(16, 561), header = FALSE, n = obs, buffersize = 100)
names(data_test) <- data_features[,2]
smaller_test <- data_test[,meansnstds]
test_labels <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE)
smaller_test$Label <- test_labels$V1
test_subjects <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE)
smaller_test$Subject <- test_subjects$V1

# Concatenate both sets to get full set
data_all <- rbind(smaller_test, smaller_train)

# Create new independent set with the average of each variable by subject
data_new <- aggregate(x = data_all, by = list(data_all$Subject), FUN = mean)

# Omit unnecessary feature and label
data_new <- data_new[,-1]
data_new <- data_new[,-80]

# Save dataset
write.table(data_new, file = 'new_tidy_set.txt', row.names = FALSE)
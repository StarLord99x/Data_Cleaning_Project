library(dplyr)

## Download data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fname <- "./project_data.zip"
if (!file.exists(fname)) {download.file(fileUrl,fname,"curl")}

## Unzip data file
pathname <- "./UCI HAR Dataset/"
if (!file.exists(pathname)) {unzip(fname)}

## Read in feature and activity labels
features <- read.table(paste0(pathname,"features.txt"),header = FALSE)
activities <- read.table(paste0(pathname,"activity_labels.txt"),header = FALSE)

##
## Create a tidy data frame for the test data
##

## Read in subject index for the test data
subject_test <- read.table(paste0(pathname,"test/subject_test.txt"),header = FALSE)
names(subject_test) <- "subject_id"
subject_test <- mutate(subject_test, test_or_train = "test")

## Read in activity index and map to activity labels for the test data
y_test <- read.table(paste0(pathname,"test/y_test.txt"),header = FALSE)
names(y_test) <- "activity_index"
y_test <- mutate(y_test,activity_label = activities[activity_index,2])

## Read in test data set and name variables using the feature labels
x_test <- read.table(paste0(pathname,"test/X_test.txt"),header = FALSE)
names(x_test) <- features[,2]

## Select only the mean and standard deviation variables
x_test <- x_test[grep("mean\\(|std\\(",names(x_test))]

## Create the tidy data frame for the test data by combining
## the subject index, activity labels, and data
x_test <- bind_cols(subject_test,y_test,x_test)

##
## Create a tidy data frame for the training data
##

## Read in subject index for the training data
subject_train <- read.table(paste0(pathname,"train/subject_train.txt"),header = FALSE)
names(subject_train) <- "subject_id"
subject_train <- mutate(subject_train, test_or_train = "train")

## Read in activity index and map to activity labels for the training data
y_train <- read.table(paste0(pathname,"train/y_train.txt"),header = FALSE)
names(y_train) <- "activity_index"
y_train <- mutate(y_train,activity_label = activities[activity_index,2])

## Read in training data set and name variables using the feature labels
x_train <- read.table(paste0(pathname,"train/X_train.txt"),header = FALSE)
names(x_train) <- features[,2]

## Select only the mean and standard deviation variables
x_train <- x_train[grep("mean\\(|std\\(",names(x_train))]

## Create the tidy data frame for the training data by combining
## the subject index, activity labels, and data
x_train <- bind_cols(subject_train,y_train,x_train)

## Combine the test and training data sets and clean up the 
## environment
project_data_tidy <- bind_rows(x_test,x_train)
write.table(project_data_tidy,file = "./project_data_tidy.txt")
rm(subject_test,x_test,y_test)
rm(subject_train,x_train,y_train)
rm(activities,features)

##
## Group by activity labels and subjects. Calculate the mean for each
## measurement within these groups.
##
project_data_tidy <- group_by(project_data_tidy,activity_label,subject_id)
project_data_means_tidy <- summarize_at(project_data_tidy,vars(-group_cols(),-activity_index,-test_or_train),mean)
write.table(project_data_means_tidy,"./project_data_means_tidy.txt")

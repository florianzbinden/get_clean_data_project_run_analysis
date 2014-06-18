
# unzip the compressed file
# setwd("/Users/fisoflo/Documents/coursera/stat/R_Hopkins/Getting_Cleaning_data/project/") # Mac
# unzip("getdata_projectfiles_UCI HAR Dataset.zip")
# setwd("/Users/fisoflo/Documents/coursera/stat/R_Hopkins/Getting_Cleaning_data/project/UCI HAR Dataset") # Mac
# wd <- getwd()

wd <- getwd()
# unzip the compressed file saved in to current wd (any directory on the computer, but zip file must be saved there)
unzip("getdata_projectfiles_UCI HAR Dataset.zip")
wd <- paste(wd, "/", "UCI HAR Dataset", sep="")


# load the required packages
library(stringr)
library(plyr)


# Phase 1 - Merges the training and the test sets to create one data set

# Phase 1a - melt the train dataset

subject_train_file <- paste(wd, "/", "train/", "subject_train.txt", sep="")
subj_train_dataset <- read.table(subject_train_file, strip.white=TRUE, colClasses=c("numeric"))

X_train_file <- paste(wd, "/", "train/", "X_train.txt", sep="")
X_train_dataset <- read.table(X_train_file, strip.white=TRUE, colClasses=c("numeric"))

y_train_file <- paste(wd, "/", "train/", "y_train.txt", sep="")
y_train_dataset <- read.table(y_train_file, strip.white=TRUE, colClasses=c("numeric"))

train_dataset <- cbind(subj_train_dataset, y_train_dataset, X_train_dataset)
colnames(train_dataset) <- c("subject", "y", colnames(X_train_dataset))

# Phase 1b - melt the test dataset
                             
subject_test_file <- paste(wd, "/", "test/", "subject_test.txt", sep="")
subj_test_dataset <- read.table(subject_test_file, strip.white=TRUE, colClasses=c("numeric"))

X_test_file <- paste(wd, "/", "test/", "X_test.txt", sep="")
X_test_dataset <- read.table(X_test_file, strip.white=TRUE, colClasses=c("numeric"))

y_test_file <- paste(wd, "/", "test/", "y_test.txt", sep="")
y_test_dataset <- read.table(y_test_file, strip.white=TRUE, colClasses=c("numeric"))

test_dataset <- cbind(subj_test_dataset, y_test_dataset, X_test_dataset)
colnames(test_dataset) <- c("subject", "y", colnames(X_train_dataset))

# Phase 1c - Merge the two datasets

whole_dataset <- rbind(test_dataset, train_dataset)

# Phase 2 - Extracts only the measurements on the mean and standard deviation for each measurement

# Phase 2a - load the features

features_file <- paste(wd, "/", "features.txt", sep="")
features_dataset <- read.table(features_file, strip.white=TRUE, colClasses=c("numeric", "character"))

# Phase 2b - transform the column names (remove dots and parentheses)

features_dataset <- make.names(features_dataset[ , 2])
features_dataset <- str_replace_all(features_dataset, "\\.", "")

# Phase 2c - change the column names of the whole_dataset

colnames(whole_dataset) <- c("subject", "y", features_dataset)

# Phase 2d - extract only the mean and std

colnumber_mean <- grep("mean", colnames(whole_dataset), ignore.case = TRUE) # gives the columns number containing "mean". 
# The case makes a difference (see column 560)

colnumber_std <- grep("std", colnames(whole_dataset), ignore.case = TRUE) # gives the columns number containing "std". 
# The cases makes no difference.

col_to_extract_all <- sort(c(colnumber_mean, colnumber_std))

# Phase 2d - remove the meanFreq

col_to_remove <- grep("meanFreq", colnames(whole_dataset), ignore.case = TRUE) # gives the columns number containing "meanFreq". 
# The cases makes no difference.

# Phase 2e - remove the columns containing "meanFreq" from the "mean"

col_to_extract <- setdiff(col_to_extract_all, col_to_remove)
col_to_extract <- (c(1,2,col_to_extract)) # The first two columns (subject and activity) must be added manually because there were not selected by the grep

# Phase 2f - extract the columns

extrait <- whole_dataset[, col_to_extract]

# Phase 3 - Uses descriptive activity names to name the activities in the data set
  
# Phase 3a - load the activity

activity_labels_file <- paste(wd, "/", "activity_labels.txt", sep="")
activity_labels_dataset <- read.table(activity_labels_file, strip.white=TRUE, colClasses=c("numeric", "character"))

# Phase 3b - switch activity names

extrait$y <- activity_labels_dataset$V2[match(extrait$y,activity_labels_dataset$V1)] 
colnames(extrait)[2] <- "activity" # the "y" column is renamed "activity"

# Phase 4 - Appropriately labels the data set with descriptive variable names

# this was already done in phase 2

# Phase 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

extrait$subject <- as.factor(extrait$subject)

tidy_ds <- ddply(extrait, .(subject, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })

write.table(tidy_ds, file="./tidy_ds.txt", sep="\t", row.names=FALSE)
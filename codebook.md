# codebook 
# get_clean_data_project_run_analysis
===================================


# What are these data for ?
Ultimately the goal of the data is to recognize what activity (sitting, walking, etc.) a human is doing based on the gyroscope and accelerometer measurements gathered from its smartphone.

# Activity (from activity_labels.txt) :
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
In the data files, the activities are described by the numbers. The numbers 1 to 6 are taken from y_test.txt and y_train.txt.

# Subjects : 
numbers 1 to 30 (from subject_test.txt and subject_train.txt)

# Observations (or cases)
A case (a line of the dataset) consists in the numerous measurements from the gyroscope and the accelerometer of a smartphone. The measurements are related to one person (subject, numbered from 1 to 30, split into two groups – train and test - originally) performing one activity (out of 6). Several measurements were gathered for a single subject performing a single activity. But the tidy dataset averages the measurements for one single subject performing one single activity, therefore there are 30*6=180 cases (lines) in the tidy dataset.

# Variables (columns)
The variables are the numerous measurements from the gyroscope and the accelerometer of a smartphone. The tidy datasets contains only the mean and standard deviation data from the original data.
## units
The data has been scaled by dividing by the range, and when you divide units by the same units, the units are cancelled.
The variables beginning with 't' are in the time domain but without units.
The variables beginning with 'f' are in the frequency domain after a fourier transform, but without units.
## Names
e.g. tGravityAcc-mean()-X tGravityAcc-mean()-Y

# Source of the original data:
UCI Machine Learning Repository
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


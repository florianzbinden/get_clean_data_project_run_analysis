README get_clean_data_project_run_analysis
===================================

The original data can be downloaded from :
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
.  Then, save the zip file in the working directory of the computer.

Open the run_analysis.R and run the whole code.

My script does 5 required steps but in more details it gives: 

- Merges (melt) the training data into one first dataset
- Merges (melt) the test data into one first dataset 
- Merges the two datasets; the first two columns represents the subject code and the activity code; the other 561 columns represents the measurement points, or features. 
- Loads the 561 features. The names contain (). and other critical characters to code. Therefore there are all replaced by «.» dots with make.names() fun and then the dots are removed. The modified names are the columns names in the merged dataset
- Column names (measurement) containing «mean» or «std» (mean and standard deviation) are selected; the «meanFreq» are removed cause they represent «Weighted average of the frequency components to obtain a mean frequency» which is not what is required (even though this can be debated, but this is not the point here).
- Loads the activity labels (number 1:6 versus «SITTING» for instance) and matches (switches) according to the numbers in the merges dataset. 
- Use ddply() and an internal function for calculating the average of each measurements with respect to subject and activity; this creates the tidy dataset.
- Write a tidy table as .txt 

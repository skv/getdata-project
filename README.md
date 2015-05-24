# Course Project: Getting and Cleaning Data

## Project Goal

The goal is to prepare tidy data that can be used for later analysis. 

## Project Outcome

* Code book — describes the variables, the data, and any transformations or work that  performed to clean up the data 
* Script — to produce tidy dataset and analyze it
* Tidy dataset — in the separate file

### Script parts

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to reproduce results

1. Download the data source (see link in project on Coursera)
2. Save data source into the working directory. It'll be ```UCI HAR Dataset``` folder.
3. Save script ```run_analysis.R``` in the working directory.
4. Install next libraries before script run:
* ```data.table```
* ```reshape2```
5. Run script in R or RStudio
6. The script will generate a new file ```tiny_dataset.txt```.

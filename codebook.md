# Introduction

The codebook is organized in the following sections.
* Domain information - background on the data and measures.
* Data sources - brief description of input files, structure and 
	organization.
* Data processing - details of the processing with reference to the 
	run_analysis.R script.

# Domain Information

The data used for this analysis is originally sourced from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data is captured a group of 30 volunteers within an age bracket of 19-48 
years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung 
Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a 
constant rate of 50Hz. The experiments have been video-recorded to label 
the data manually. The obtained dataset has been randomly partitioned into 
two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by 
applying noise filters and then sampled in fixed-width sliding windows 
of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration 
signal, which has gravitational and body motion components, was separated 
using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, 
a vector of features was obtained by calculating variables from the time 
and frequency domain. See 'features_info.txt' for more details.

**Source** - README.txt included with the data.

# Data Sources 

All the files are included in the "UCI HAR Dataset" directory. This directory 
contains the README.txt and features_info.txt which provide information about 
the data. Apart from these activity_labels.txt and features.txt provide the 
descriptive names for the columns present in the actual data. Besides these 
files, the folder contains two folders, one for the training set and the 
other for the testing set. Both these directories contain data for feature 
measurements (X_<train/test>.txt), the activities for corresponding 
measurements (y_<train/test>.txt) and subject IDs (subject_<train/test>.txt).
Both these directories also contains a sub-directory "Inertial Signals", 
which is ignored for the purpose of this exercise.
  
# Data Processing

The R script does the following.  
1. Download and extract the UCI HAR Dataset.  
2. Read the measure files and combine for training and test  
3. Read the Subject information and combine for training and test  
4. Read the Activity information and combine for training and test  
5. Read features/measures list and identify and filter the column indexes to 
	keep in the processed data, by matching "mean(" or "std(". This additional 
	"(" is used to ensure columns like "fBodyAccJerk-meanFreq()-X" are not 
	selected.  
6. Read the activity names, and substitute these for IDs in activity 
	information.  
7. Add proper column names to all data frames and remove "(" and ")" from 
	column names.  
8. Combine subject, activity, measure data frames to get a composite frame. 
	This is equivalent to the result after requirement 4.  
9. Use the melt, dcast functions to generate the final tidy dataset.  
10. Write the output to disk  


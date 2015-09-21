Analysis and summary of Samsung Human Activity Recognition dataset
==================================================================
 
Submission contains two files:

 * data-step-5.txt - tidy dataset, original data summary
 * run_analysis.R - script to generate it

data-step-5.txt
---------------

This file contains data frame with 180 observations of 81 variables. Variables are:

 * Subject - a factor variable with numbers describing different persons participating in the experiment.
 * Activity - a factor variable describing different person activities, such as walking, laying, sitting, etc.
 * rest of 79 variables is taken from feature list of Samsung data by the way described below.
 
run_analysis.R
--------------

This is a script to generate data-step-5. Using reshape2 library. Works the following way:

1. Check the datafiles, and download them if required.
2. Load feature and activity names.
3. From feature names it selects only features which contains 'mean' of 'std' in their names.
4. Load feature data, select only required, and assign names to them.
5. Load activity and subject data.
6. Merge subject, activity, and feature into one data frame called 'data'
7. Create 'dataMean' data frame. It contains the mean values of each of 79 feature variables grouped by unique subject and activity values.
8. Save it to file.
# GetAndCleanData_Project

Coursera Data Science Specialization - Getting and Cleaning Data - Project

==================================================================

This repository contains a script named <run_analysis.R>, which reads and processes movement data provided by the accelerometer and gyroscopeembedded in a smartphone.
The data is related to a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing the smartphone. 

The output is a summary file, grouped by volunteer and activity, gicing the mean value of all the measurements.

==================================================================

**The script expects to find the data in a folder called "data" (the path is relative to the work directory).
I chose to put the data inside a folder so that scripts and data are not mixed; by the way, the data directory is defined at the top of the script ( dataDir <- "./data" ) and can be easily modified.

The output is a file named <TidyData.txt>, written to the work directory.**

==================================================================

The output file can be read with the command 

summary <- read.table(file = "./TidyData.txt", header = T)

**The meaning of the data columns is detailed in the <CodeBook.md> file.**

==================================================================

**The <dplyr> and <utils> libraries are used by the script; if not already installed, the following lines (the top lines of the script) should be uncommented before tunning the script:**

#install.packages("dplyr")
#install.packages("utils")

==================================================================

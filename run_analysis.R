#install.packages("dplyr")
#install.packages("utils")

library(dplyr)
library(utils)

dataDir <- "./data"

improveDescription <- function(x = character) {
  improved <- x
  
  improved <- sub("BodyBody", " body ", improved)
  improved <- sub("Body", " body ", improved)
  improved <- sub("Gravity", " gravity ", improved)
  
  improved <- sub("t ", "time ", improved)
  improved <- sub("f ", "frequency ", improved)
  
  improved <- sub(" AccJerkMag-", " accelerator Jerk magnitude ", improved)
  improved <- sub(" AccJerk-", " accelerator Jerk ", improved)
  improved <- sub(" AccMag-", " accelerator magnitude ", improved)
  improved <- sub(" Acc-", " accelerator ", improved)
  
  improved <- sub(" GyroJerkMag-", " gyroscope Jerk magnitude ", improved)
  improved <- sub(" GyroJerk-", " gyroscope Jerk ", improved)
  improved <- sub(" GyroMag-", " gyroscope magnitude ", improved)
  improved <- sub(" Gyro-", " gyroscope ", improved)
  
  improved <- sub(" std()", " stddev", improved, fixed = T)
  improved <- sub(" mean()", " mean", improved, fixed = T)
  improved <- sub("-X", " Xaxis", improved)
  improved <- sub("-Y", " Yaxis", improved)
  improved <- sub("-Z", " Zaxis", improved)
  
  improved <- gsub(" ", "_", improved)
  
  improved
}  

# read data files
# sep="": looks for one or more white spaces, tabs, etc
# no header in files
subject_train <- read.csv(paste(dataDir, "/train/subject_train.txt", sep = ""), sep = "", header=F)
subject_test <- read.csv(paste(dataDir, "/test/subject_test.txt", sep = ""), sep = "", header=F)

y_train <- read.csv(paste(dataDir, "/train/Y_train.txt", sep = ""), sep = "", header=F)
y_test <- read.csv(paste(dataDir, "/test/Y_test.txt", sep = ""), sep = "", header=F)

x_train <- read.csv(paste(dataDir, "/train/X_train.txt", sep = ""), sep = "", header=F)
x_test <- read.csv(paste(dataDir, "/test/X_test.txt", sep = ""), sep = "", header=F)

#
# step 1: Merge the training and the test sets to create one data set.
#
subject_merged <- rbind(subject_test, subject_train)
y_merged <- rbind(y_test, y_train)
x_merged <- rbind(x_test, x_train)
all_merged <- cbind(subject_merged, y_merged, x_merged)

#
# step 2: Extract only the measurements on the mean and standard deviation for each measurement
#
# read features list
features <- read.csv(paste(dataDir, "/features.txt", sep = ""), sep = "", header=F, stringsAsFactors = F)
# indexes of all features containing "mean()" in description
means <- which(grepl("mean()", features[,2], fixed = T, perl = F))
# indexes of all features containing "std()" in description
stds <- which(grepl("std()", features[,2], fixed = T, perl = F))
to_keep_columns <- sort(c(means, stds))
# keep only variables defined in to_keep_columns (+2, as first two columns must be preserver)
all_filtered <- all_merged[,c(1:2, to_keep_columns+2)]

#
# step 3: Use descriptive activity names to name the activities in the data set
#
# read activity names
activities <- read.csv(paste(dataDir, "/activity_labels.txt", sep = ""), sep = "", header=F, stringsAsFactors = F)
# replace codes with descriptions
for (i in 1:nrow(all_filtered)) {
  activity_row_idx <- which(activities[,1] == all_filtered[i, 2])
  desc <- activities[activity_row_idx, 2]
  all_filtered[i,2] <- desc
}

#
# step 4: Appropriately label the data set with descriptive variable names
#
# keep only required features
features <- features[to_keep_columns, ]
# make names more readable:
# - prefix "t" --> "time"
# - prefix "f" --> "freq"
# - "Body" --> " body "
# - "Gravity" --> " gravity "
# - "Acc" --> " accelerometer "
# - "Gyro" --> " gyroscope "
readable_features <- features
readable_features <- cbind(readable_features, features[,2])
for (i in 1:nrow(features)) {
  original_desc <- features[i,2]
  improved_desc <- improveDescription(original_desc)
  readable_features[i,2] <- improved_desc
}
# overwrite column names with proper ones
right_names <- c("subject", "activity", readable_features[,2])
names(all_filtered) <- right_names

#
# step 5: From the data set in step 4, create a second, independent tidy data set
# with the average of each variable for each activity and each subject
#

all_grouped <- all_filtered %>% group_by(subject, activity) %>% summarise_each(funs(mean))

write.table(all_grouped, file = "./TidyData.txt", row.names = F)
run_analysis <- function() {
  library(dplyr)
  library(reshape2)
  
  ## Merges the training and the test sets to create one data set.
  
  ## Import Features Info
  features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")
  activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"")
  names(activity_labels) <- c("activity_id","activity")

  
  ## Import test data
  test_set <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"")
  test_labels <- read.table("~/UCI HAR Dataset/test/Y_test.txt", quote="\"")
  test_subject <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"")
  ## Appropriately labels the data set with descriptive variable names. 
  names(test_set) <- features[,2]

  ## Extracts only the measurements on the mean and standard deviation for each measurement. 
  test_set_mean <- test_set[,grepl("mean()",names(test_set),fixed = TRUE)]
  test_set_std <- test_set[,grepl("std()",names(test_set),fixed = TRUE)]
  test_set <- cbind(test_set_mean,test_set_std)

  names(test_labels) <- "activity_id"
  names(test_subject) <- "subject_id"
  test_full <- cbind(test_labels,test_subject,test_set)

  ## Import Training data
  training_set <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"")
  training_labels <- read.table("~/UCI HAR Dataset/train/Y_train.txt", quote="\"")
  training_subject <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"")
  ## Appropriately labels the data set with descriptive variable names. 
  names(training_set) <- features[,2]

  ## Extracts only the measurements on the mean and standard deviation for each measurement. 
  training_set_mean <- training_set[,grepl("mean()",names(training_set),fixed = TRUE)]
  training_set_std <- training_set[,grepl("std()",names(training_set),fixed = TRUE)]
  training_set <- cbind(training_set_mean,training_set_std)

  names(training_labels) <- "activity_id"
  names(training_subject) <- "subject_id"
  training_full <- cbind(training_labels,training_subject,training_set)

  ## Combines test and training data
  full_data <- rbind(test_full,training_full)

  ## Uses descriptive activity names to name the activities in the data set
  full_data <- merge(activity_labels,full_data,by.x = "activity_id",by.y = "activity_id",all=TRUE)


  ## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  meltdata <- melt(full_data,id.vars = c("activity","subject_id"),measure.vars = colnames(full_data[4:69]))
  tidy <- acast(meltdata, subject_id + activity ~ variable,mean)
  write.table(tidy,"~/tidy_data.txt",row.name = FALSE)
  write.table(rownames(tidy),"~/tidy_row_names.txt",row.name = FALSE)
  tidy
}
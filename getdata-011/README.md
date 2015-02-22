##Required Libraries
reshape2
dplyr

Measurements on the mean and standard deviation for each measurement are asked for, therefore, only features where the string "mean()" or "std()" are included. Other instances ("fBodyBodyGyroJerkMag-meanFreq()" or "angle(X,gravityMean)for example) indicate measurements other than mean and are not included.

##Elements of Tidy Data
Each row of the output data represents a combination of activity + subject_id (6 activities + 30 subjects = 180 total)
Each Column represents one of 66 variables (either mean or standard deviation from the source data)
Supporting Reference: https://class.coursera.org/getdata-011/forum/thread?thread_id=248

##Experimental Design and variable descriptions
See Codebook.md
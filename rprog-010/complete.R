complete <- function(directory = "specdata", id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  files <- list.files(directory,full.names = TRUE) ## load files from directory
  masternobs <- data.frame() ## set masternobs as blank data frame
  for (i in id) {
    data <- read.csv(files[i]) ## grab the .csv file
    nobs <- sum(complete.cases(data)) ## count number of complete records
    newnobs <- data.frame(i,nobs) ## create frame with id and nobs
    colnames(newnobs) <- c("id", "nobs")
    masternobs <- rbind(masternobs,newnobs) ## append new frame to master frame
  }
  print(masternobs)
}
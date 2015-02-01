pollutantmean <- function(directory = "specdata", pollutant = "sulfate", id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)

  files <- list.files(directory,full.names = TRUE)
  masterdata <- data.frame() ## set masterdata as blank data frame
  
  for (i in id) {
    data <- read.csv(files[i]) ## grab the .csv file
    masterdata <- rbind(masterdata,data) ## append cleaned data to masterday
   
  }
  subset <- masterdata[,pollutant]
  mastermean <- mean(subset,na.rm = TRUE) # find mean of pollutant column of masterdata, removing NAs
  print(mastermean)
}

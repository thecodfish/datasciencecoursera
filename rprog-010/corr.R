corr <- function(directory = "specdata", threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0

    ## Return a numeric vector of correlations
  files <- list.files(directory,full.names = TRUE) ## load files from directory
  mastervar  <- numeric() ## set mastervar as numeric vector
  for (i in 1:332) {
    data <- read.csv(files[i]) ## grab the .csv file
    nobs <- sum(complete.cases(data)) ## count number of complete records
    if(nobs >= threshold){
    	newvar <- cor(data[,"nitrate"],data[,"sulfate"],na.rm = TRUE) ## calculate variance if over threshold
		mastervar <- c(mastervar,newvar) ## append newvar to mastervar
    } else {
    	next ## skip if not over threshold
    }
  }
  mastervar
}
rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
  ranklist <- data.frame()
  ## set up state and outcome checks
  allstates <- unique(data$State)
  alloutcomes <- c("heart attack","heart failure","pneumonia")
  ## Check that state and outcome are valid
  ##  if (is.na(match(state,allstates))){
  ##    message()
  ##    stop("invalid state")
  ##  }
  if (is.na(match(outcome,alloutcomes))){
    stop("invalid outcome")
  }
  ## For each state, find the hospital of the given rank
  for (state in allstates) {
    statesub <- subset(data, State == state, select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)) ##subset hospital and outcome from state
    colnames(statesub)<-c("Hospital.Name","heart attack","heart failure","pneumonia")
    orderstatesub <- statesub[order(statesub[outcome],statesub["Hospital.Name"], na.last = NA),] ## Sort by outcome and remove NAs
    
    ## switch best and worst to first and last #
    if (num == "best"){
      hospital <- head(orderstatesub$Hospital.Name,1)
    } else if (num == "worst"){
      hospital <- tail(orderstatesub$Hospital.Name,1)
    } else {
      hospital <- orderstatesub$Hospital.Name[num]
    }
    
    hospname <- as.character(hospital) ## Return num on list
    newhosp <- data.frame(hospname,state)
    colnames(newhosp)<- c("hospital","state")
    ranklist <- rbind(ranklist,newhosp)
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  ranklist
}
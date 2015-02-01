best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
  
  ## set up state and outcome checks
  allstates <- unique(data$State)
  alloutcomes <- c("heart attack","heart failure","pneumonia")
  
  ## Check that state and outcome are valid
  if (is.na(match(state,allstates))){
    stop("invalid state")
  }
  if (is.na(match(outcome,alloutcomes))){
    stop("invalid outcome")
  }
  ## Return hospital name in that state with lowest 30-day death rate
  statesub <- subset(data, State == state, select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)) ##subset hospital and outcome from state
  colnames(statesub)<-c("Hospital.Name","heart attack","heart failure","pneumonia")
  orderstatesub <- statesub[order(statesub[outcome]),] ## Sort by outcome
  as.character(head(orderstatesub$Hospital.Name,1)) ## Return first on list
  
  
}
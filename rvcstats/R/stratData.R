## Returns: a STRAT object with weights (wh) for each stratum given
## a data.frame or list with stratum names and total possible
## PSUs in that stratum (NTOT)
stratData = function(data){
  ## Check to make sure required variables are present 
  names(data) = toupper(names(data))
  reqd = c("YEAR", "STRAT", "NTOT")
  d = setdiff(reqd, names(data))
  if (length(d)>0){
    diff = paste(d, collapse = ", ")
    stop("required variables:", diff, " not found in data")
  }
  ## Calculate weights and produce table
  newData = subset(data, select = c("STRAT", "NTOT"))
  tot = sum(newData$NTOT)
  newData$wh = newData$NTOT/tot
  ## Change class to STRAT
  class(newData) = "STRAT"
  
  return(newData)
}
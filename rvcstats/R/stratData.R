## Returns: a STRAT object with weights (wh) for each stratum and year
## Given selected years (defualt = "all") and strata (default = "all").
## If includes.protected then substrata with protected status will be 
## searched for in data with the variable name PROT
stratData = function(data, years = "all", strata = "all", includes.protected = FALSE){
  ## Check to make sure required variables are present 
  names(data) = toupper(names(data))
  reqd = c("YEAR", "STRAT", "NTOT")
  .inList("Required Variable", reqd, names(data))
  
  ## If strata set to all, select all strata
  if (strata == "all"){
    strata = unique(data$STRAT)
  }
  
  ## If years set to all select all years
  if (years == "all"){
    years = unique(data$YEAR)
  }
  
  ## Select variables to aggregate by
  agg.by = c("YEAR", "STRAT")
  
  ## If includes.protected is TRUE add includes protected to agg.by
  if (includes.protected){
    .inList("protection status variable", "PROT", names(data))
    agg.by = c(agg.by, "PROT")
  }
  
  ## Subset and aggregate (if neccessary) by agg.by variables
  sub = subset(data, YEAR %in% years & STRAT %in% strata)
  agg.by = as.list(sub[agg.by])
  newData = aggregate(sub$NTOT, by = agg.by, FUN = sum)
  names(newData)[length(names(newData))] = "NTOT"
  
  ## Calculate weighting
  tot = aggregate(NTOT ~ YEAR, data = newData, FUN = sum)
  xx = merge(newData,tot, by = "YEAR") 
  newData$wh = xx$NTOT.x/xx$NTOT.y
  ## Change class to STRAT
  class(newData) = "STRAT"
  
  return(newData)
}
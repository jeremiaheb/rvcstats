## Returns: a STRAT object with weights (wh) for each stratum and year
## Given selected strata and years and a data.frame containing the years,
## names, and NTOT (total possible PSUs) in each stratum
## by default strata and years are set to "all", which selects
## for all years and strata within data
stratData = function(data, strata = "all", years = "all"){
  ## Check to make sure required variables are present 
  names(data) = toupper(names(data))
  reqd = c("YEAR", "STRAT", "NTOT")
  inList("Required Variable", reqd, names(data))
  ## If strata set to all, select all strata
  if (strata == "all"){
    strata = unique(data$STRAT)
  }
  ## If years set to all select all years
  if (years == "all"){
    years = unique(data$YEAR)
  }
  ## Subset and aggregate (if neccessary) by strata and years 
  newData = aggregate(NTOT ~ YEAR + STRAT,
    data,
    subset = YEAR %in% years & STRAT %in% strata,
    FUN = sum
    )
  ## Calculate weighting
  tot = sum(newData$NTOT)
  newData$wh = newData$NTOT/tot
  ## Change class to STRAT
  class(newData) = "STRAT"
  
  return(newData)
  ## ToDo: Fix to include substrata if desired (e.g. protected)
}
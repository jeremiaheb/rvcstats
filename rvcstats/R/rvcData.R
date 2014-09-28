## Subsets data from data by selected species, year, and strata,
## Returns s3 object of class RVC which can then be utilized by other functions
rvcData = function(species, years, strata, data){
  ## Helper function to produce errors if parameter par composed of x is not in list y
  inList = function(par,x,y){
    d = setdiff(x,y)
    if (length(d)>0){
      diff = paste(d, collapse = ", ")
      stop(paste(par,diff, "not found in data"))
    }
  } 
  
  ## Check to make sure variable names are correct in data
  names(data) = toupper(names(data))
  reqd = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR", "NUM")
  inList("required variables", reqd, names(data))
  ## Check that species, year, and strata are in data
  species = toupper(species)
  inList("species", species, data$SPECIES_CD)
  inList("year(s)", years, data$YEAR)
  strata = toupper(strata)
  inList("strata", strata, data$STRAT)
  
  ## Subset data based on arguments
  newData = subset(
    data,
    subset = SPECIES_CD %in% species & YEAR %in% years & STRAT %in% strata
    )
  ## Combine Data from all length classes
  newData = aggregate(
    NUM ~ SPECIES_CD + YEAR + STRAT + PRIMARY_SAMPLE_UNIT + STATION_NR,
    data = newData,
    FUN = sum
    )
  class(newData) <- "RVC"
  return(newData)
  ## ToDo: Add functionality for user to set variable names(??)
  ## ToDo: Allow users to enter in full sci name and produce species cd from that
  ## ToD0: Change select as more functionality added to package (e.g. length, procteted status)
  ## ToDo: Change so it accepts CSVs directly(??)
}
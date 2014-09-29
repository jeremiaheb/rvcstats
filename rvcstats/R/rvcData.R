## Returns: an RVC object from data as a data.frame subsetted by given parameters
rvcData = function(data, species, years = "all", strata = "all",
                   length.classes = "all", seperate.protected = FALSE,
                   specify.variables = FALSE){  
  ## ToDo: Allow user to specify variables
  if (specify.variables){
    
  }
  
  ## Check to make sure variable names are correct in data
  names(data) = toupper(names(data))
  reqd = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR", "NUM")
  inList("required variables", reqd, names(data))
  
  ##ToDo: Add parser to full scientific names are trucated to SPECIES_CD
  
  ## If years is "all" set to all years in data
  if (years == "all"){
    years = unique(data$YEAR)
  }
  ## If strata is "all" set to all strata in data
  if (strata == "all"){
    strata = unique(data$STRAT)
  }
  
  ## Check that species, year, and strata are in data
  species = toupper(species)
  inList("species", species, data$SPECIES_CD)
  inList("year(s)", years, data$YEAR)
  strata = toupper(strata)
  inList("strata", strata, data$STRAT)
  
  ## list of variables to aggregate by
  vars = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR")
  
  ## ToDO: If length.classes is not all, include in vars, and sum by 
  ## the specified classes
  
  ## If seperate.protected add to vars and subset by protected status
  if (seperate.protected){
    data$PROT = ifelse(data$MPA_NR > 0, 1,0)
    vars = c(vars, "PROT")
  }
  
  ## Subset and combine Data from all length classes
  vars = as.list(data[vars])
  newData = aggregate(
      data$NUM, by = vars, FUN = sum
    )
  names(newData)[length(names(newData))] = "NUM"
  
  class(newData) <- "RVC"
  return(newData)
  ## ToDo: Add functionality for user to set variable names(??)
  ## ToDo: Allow users to enter in full sci name and produce species cd from that
}
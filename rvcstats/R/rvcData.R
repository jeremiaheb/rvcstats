## Returns: an RVC object from data as a data.frame subsetted by given parameters
rvcData = function(data, species, years = "all", strata = "all",
                   length.classes = "all", includes.protected = FALSE,
                   specify.variables = FALSE){  
  ## ToDo: Allow user to specify variables??
  if (specify.variables){
    
  }
  
  ## Check to make sure variable names are correct in data
  names(data) = toupper(names(data))
  reqd = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR", "NUM")
  .inList("required variables", reqd, names(data))
  
  ##Parse full scientific names are trucated to SPECIES_CD
  species = .toSpcCd(species)
  
  ## If years is "all" set to all years in data
  if (years == "all"){
    years = unique(data$YEAR)
  }
  ## If strata is "all" set to all strata in data
  if (strata == "all"){
    strata = unique(data$STRAT)
  }
  
  ## Check that species, year, and strata are in data
  .inList("species", species, data$SPECIES_CD)
  .inList("year(s)", years, data$YEAR)
  strata = toupper(strata)
  .inList("strata", strata, data$STRAT)
  
  ## subset data by species, year, and strata
  data = subset(
    data,
    subset = YEAR %in% years & STRAT %in% strata & SPECIES_CD %in% species
  )
  
  ## list of variables to aggregate by
  agg.by = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR")
  
  ## ToDO: If length.classes is not all, include in vars, and sum by 
  ## the specified classes
  
  ## If includes.protected add to vars and subset by protected status
  if (includes.protected){
    .inList("required variable", "MPA_NR", names(data))
    data$PROT = ifelse(data$MPA_NR > 0, 1,0)
    agg.by = c(agg.by, "PROT")
  }
  
  ## Subset and combine Data from all length classes
  agg.by = as.list(data[agg.by])
  newData = aggregate(
      data$NUM, by = agg.by, FUN = sum
    )
  names(newData)[length(names(newData))] = "NUM"
  
  class(newData) <- "RVC"
  return(newData)
}
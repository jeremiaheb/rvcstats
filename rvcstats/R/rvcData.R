## Returns: an RVC object from data as a data.frame subsetted by given parameters
rvcData = function(data, species, years = "all", strata = "all",
                   includes.protected = FALSE){  
  ## Check to make sure variable names are correct in data
  names(data) = toupper(names(data))
  reqd = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR", "NUM")
  .inList("required variables", reqd, names(data))
  
  ##Parse full scientific names are trucated to SPECIES_CD
  species = .toSpcCd(species)
  
  ## If years is not "all", check that years are in data and subset by years
  if (years != "all"){
    .inList("year(s)", years, data$YEAR)
    data = subset(data, YEAR %in% years)
  }
  ## If strata is not "all" check that strata are in data and subset by strata
  if (strata != "all"){
    strata = toupper(strata)
    .inList("strata", strata, data$STRAT)
    data = subset(data, STRAT %in% strata)
  }
  ## Check that species are in data, and subset by species
  .inList("species", species, data$SPECIES_CD)
  data = subset(data, SPECIES_CD %in% species)

  ## list of variables to aggregate by
  agg.by = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR")
  

  ## If includes.protected is TRUE add to vars and code for protected status
  if (includes.protected){
    .inList("required variable", "MPA_NR", names(data))
    data$PROT = ifelse(data$MPA_NR > 0, 1,0)
    agg.by = c(agg.by, "PROT")
  }
  
  ## Aggregate data by selected pars
  agg.by = as.list(data[agg.by])
  newData = aggregate(
      data$NUM, by = agg.by, FUN = sum
    )
  names(newData)[length(names(newData))] = "NUM"
  
  class(newData) <- "RVC"
  
  return(newData)
}
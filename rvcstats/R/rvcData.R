## Returns: data.frame of densities for given species, years, and strata
rvcData = function(species, years, strata, sample.data, stratum.data){
  ##ToDO: Make sure vars for sample.data are recognized
  ##ToDo Make sure vars for stratum.data are recognized
  ##ToDo: Check for valid species
  ##ToDo: Check for valid strata
  ##ToDo: Check for valid years
  ## ToDo: Add options for all years
  ## ToDo: Add options for all data
  
  ## Split data according to year, species, stratum, and PSU
  split.sample =  split(sample.data, list(sample.data$YEAR, sample.data$SPECIES_CD, sample.data$STRAT, 
                                          sample.data$PRIMARY_SAMPLE_UNIT), drop = TRUE)
  
  return(split.sample)
}
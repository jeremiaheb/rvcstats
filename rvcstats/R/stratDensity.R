## Returns: a data.frame with the number of primary sample units and
## stratum level avg. density and variance for each species and year
stratDensity = function(rvcObj, ...){
  ## Calculate PSU densities
  psu = psuDensity(rvcObj, ...)
  
  ## Calculate number of PSU per stratum
  strat = aggregate(PRIMARY_SAMPLE_UNIT ~ SPECIES_CD + YEAR + STRAT,
                    data = psu, FUN = length)
  names(strat)[length(names(strat))] = "n" 
  
  ## Calculate the avg. density per stratum
  strat$DENS = aggregate(DENS ~ SPECIES_CD + YEAR + STRAT,
                         data = psu, FUN = mean)$DENS
  
  ## Calculate the variance among PSUs per stratum
  v1 = aggregate(DENS ~ SPECIES_CD + YEAR + STRAT,
                 data = psu, FUN = var, na.rm = TRUE)$DENS
  
  ## Calculate the variance among SSUs per stratum
  ssu = ssuDensity(rvcObj, ...) #Not efficient
  v2 = aggregate(DENS ~ SPECIES_CD + YEAR + STRAT,
                 data = ssu, FUN = var, na.rm = TRUE)$DENS
  
  strat$VAR = v1 - v2/177 #Need to fix this so ssu.area can be set as ...
  
  return(strat)
  
  #ToDo: fix so v2 data is passed upwards
}
## Returns a data.frame with fish densities for each PSU, given
## an RVC object
psuDensity = function(rvcObject, ...){
  ## Get ssu densities
  ssu = ssuDensity(rvcObject, ...)
  ## Reclass ssu so aggregate can worl
  class(ssu) = "list"
  ## Number of stations at a PSU
  psu = aggregate(STATION_NR ~ SPECIES_CD + YEAR + STRAT + PRIMARY_SAMPLE_UNIT,
                data = ssu, FUN = max)
  names(psu)[length(names(psu))] = "m"
  ## Get mean density at each PSU
  psu$DENS = aggregate(DENS ~ SPECIES_CD + YEAR + STRAT + PRIMARY_SAMPLE_UNIT,
                       data = ssu, FUN = mean)$DENS
  ## Get variance in mean density for each PSU, will produce NAs
  ## if only one station
  psu$VAR = aggregate(DENS ~ SPECIES_CD + YEAR + STRAT + PRIMARY_SAMPLE_UNIT,
                      data = ssu, 
                      FUN = var)$DENS
  return(psu)
}
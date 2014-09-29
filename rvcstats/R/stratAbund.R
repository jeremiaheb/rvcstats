## Returns: a data.frame including the average count (avg.abund), avg. number of 
## SSUs (avg.m), number of PSUs (n), variance in PSU abundance (v1) and variance 
## in SSU abundance (v2) and total sample variance vari for each stratum in a given 
## RVC object, Given an RVC object, and the ssu.area (default=177m^2) and the psu.area
## (default=40000m^2)
stratAbund = function(rvcObj, ssu.area = 177, psu.area = 40000) {
  ## Calculate mean abundances for PSUs 
  psu = psuAbund(rvcObj)
  ## Calculate average counts and average m per stratum
  strat = aggregate(cbind(avg.abun, m) ~ SPECIES_CD + YEAR + STRAT, data = psu,
                    FUN = mean)
  names(strat)[length(names(strat))] = "avg.m"
  ## calculate number of PSUs per stratum
  strat$n = aggregate(PRIMARY_SAMPLE_UNIT ~ SPECIES_CD + YEAR + STRAT, data = psu,
                      FUN = length)$PRIMARY_SAMPLE_UNIT
  
  ## Calculate v1
  strat$v1 = aggregate(avg.abun ~ SPECIES_CD + YEAR + STRAT, data = psu,
                       FUN = var)$avg.abun
  ## Calculate nm, v2
  ## temp data.frame to hold values
  xx = aggregate(cbind(vari, m, np.freq) ~ SPECIES_CD + YEAR + STRAT, data = psu,
                      FUN = sum)
  strat$v2 = ifelse(xx$np>0, xx$vari/xx$np, 0)
  ## Calculate overall stratum variance
  strat$vari = strat$v1 - strat$v2/(psu.area/ssu.area)
  strat$nm = xx$m
  rm(xx)
return(strat)
}
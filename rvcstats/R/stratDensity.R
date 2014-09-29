## Returns: a data.frame of avg. counts (dbar), total stratum variance (vbar)
## variance among PSUs (v1), variance among SSUs (v2), 
## avg. SSUs per PSU (mbar), number of PSUs (n), number of SSUs (nm),
## total number of possible PSUs (NTOT), and total number of possible
## SSUs (NM), and stratum weighting factor (wh) per Stratum
## Given an RVC object, a STRAT obj, and SSU and PSU areas
## 177m^2 and 40000m^2, by default
stratDensity = function(rvcObj, stratObj, ssu.area = 177, psu.area = 40000) {
  ## ToDo: Make sure years and strata in rvcObj and stratObj match
  
  ## Calculate PSU densities
  psu = psuDensity(rvcObj)
  
  ## Set the variables by which to aggregate
  agg.by = psu[names(psu) %w/o% c("PRIMARY_SAMPLE_UNIT", "NUM")]
  
  ## Calculate dbar
  strat = aggregate(psu$dbar, by = agg.by, FUN = mean)
  names(strat)[length(names(strat))] = "dbar"
  ## Calculate avg. m
  mbar = aggregate(psu$m, by = agg.by, FUN = mean)$x
  ## Calculate n
  n = aggregate(psu$m, by = agg.by, FUN = length)$x
  ## Calculate v1
  v1 = aggregate(psu$dbar, by = agg.by, FUN = length)$x
  ## Calculate nm, v2, and np
  xx = aggregate(cbind(m, vari, np.freq), by = agg.by, FUN = sum)
  
  
  
return(xx)
}
# 
# ## Calculate mean abundances for PSUs 
# psu = psuAbund(rvcObj)
# ## Calculate average counts and average m per stratum
# strat = aggregate(cbind(avg.abun, m) ~ SPECIES_CD + YEAR + STRAT, data = psu,
#                   FUN = mean)
# names(strat)[length(names(strat))] = "avg.m"
# ## calculate number of PSUs per stratum
# strat$n = aggregate(PRIMARY_SAMPLE_UNIT ~ SPECIES_CD + YEAR + STRAT, data = psu,
#                     FUN = length)$PRIMARY_SAMPLE_UNIT
# 
# ## Calculate v1
# strat$v1 = aggregate(avg.abun ~ SPECIES_CD + YEAR + STRAT, data = psu,
#                      FUN = var)$avg.abun
# ## Calculate nm, v2
# ## temp data.frame to hold values
# xx = aggregate(cbind(vari, m, np.freq) ~ SPECIES_CD + YEAR + STRAT, data = psu,
#                FUN = sum)
# strat$v2 = ifelse(xx$np>0, xx$vari/xx$np, 0)
# ## Calculate overall stratum variance
# strat$vari = strat$v1 - strat$v2/(psu.area/ssu.area)
# strat$nm = xx$m
# rm(xx)
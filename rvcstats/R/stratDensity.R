## Returns: a data.frame of avg. counts (dbar), total stratum variance (vbar)
## variance among PSUs (v1), variance among SSUs (v2), 
## avg. SSUs per PSU (mbar), number of PSUs (n), number of SSUs (nm),
## total number of possible PSUs (NTOT), and total number of possible
## SSUs (NMTOT), and stratum weighting factor (wh) per Stratum
## Given an RVC object, a STRAT obj, and SSU and PSU areas
## 177m^2 and 40000m^2, by default
stratDensity = function(rvcObj, stratObj, ssu.area = 177, psu.area = 40000) {
  ## Make sure stratObj is of class STRAT
  if (!inherits(stratObj, "STRAT")){
    stop("stratObj must be of class STRAT, type ?stratData for more info")
  }
  ## Make sure years and strata in rvcObj and stratObj match
  rvcYrs =  unique(rvcObj$YEAR)
  strYrs = unique(stratObj$YEAR)
  d = setdiff(rvcYrs, strYrs)
  if (length(d)>0){
    diff = paste(d, collapse = ", ")
    stop(paste("years:", diff, " in rvcObj not found in stratObj"))
  }
  ## ToDo: Refactor this so it uses an apply function rather than a loop
  ## Also should continue going to catch all exceptions, rather than just the first 
  ## set
  for (i in 1:length(rvcYrs)){
    rvcStr = unique(rvcObj$STRAT[rvcObj$YEAR == rvcYrs[i]])
    strStr = unique(stratObj$STRAT[stratObj$YEAR == rvcYrs[i]])
    d = setdiff(rvcStr, strStr)
    if (length(d)>0){
      diff = paste(d, collapse = ", ")
      stop(paste("strata:", diff, " in year ",
                 rvcYrs[i], " in rvcObj not found in stratObj"))
    }
  }
  
  ## Calculate PSU densities
  psu = psuDensity(rvcObj)
  
  ## Set the variables by which to aggregate
  agg.by = psu[names(psu) %w/o% c("PRIMARY_SAMPLE_UNIT", "NUM",
                                  "dbar", "vari", "m", "np.freq")]
  ## Calculate dbar
  strat = aggregate(psu$dbar, by = agg.by, FUN = mean)
  names(strat)[length(names(strat))] = "dbar"
  ## Calculate mbar
  strat$mbar = aggregate(psu$m, by = agg.by, FUN = mean)$x
  ## Calculate n
  strat$n = aggregate(psu$m, by = agg.by, FUN = length)$x
  ## Calculate v1
  strat$v1 = aggregate(psu$dbar, by = agg.by, FUN = var)$x
  ## Calculate nm, v2, and np
  strat$nm = aggregate(psu$m, by = agg.by, FUN = sum)$x
  np = aggregate(psu$np.freq, by = agg.by, FUN = sum)$x
  v2 = aggregate(psu$vari, by = agg.by, FUN = sum)$x
  strat$v2 = ifelse(np>0, v2/np, 0)
  rm(v2)
  
  ## Cast stratObj to list 
  class(stratObj) = "list"
  ## Merge stratObj and strat
  strat2 = merge(stratObj, strat)
  
  ## Calculate MTOT
  MTOT = round(psu.area/ssu.area, 0)
  ## Calculate variance weights, variance, and NMTOT
  fn = strat2$n/strat2$NTOT
  fm = strat2$mbar/MTOT
  strat2$vbar = with(strat2, ((1-fn)*v1/n)+((fn*(1-fm)*v2)/nm))
  strat2$NMTOT = strat2$NTOT*MTOT
  
return(strat2)
}
## Returns: Stratum level occurence, total stratum variance (vbar)
## variance among PSUs (v1), variance among SSUs (v2), 
## avg. SSUs per PSU (mbar), number of PSUs (n), number of SSUs (nm),
## total number of possible PSUs (NTOT), and total number of possible
## SSUs (NMTOT) per Stratum
stratOccurrence = function(sample.data, stratum.data, species, years = "all",
                        strata = "all", includes.protected = FALSE){
  r = rvcData(sample.data, species, years, strata, includes.protected)
  s = stratData(stratum.data, years, strata, includes.protected)
  st = strat(r,s, calculate.density = FALSE)
  names(st)[names(st) == "yi"] = "occurence"
  return(st)
}
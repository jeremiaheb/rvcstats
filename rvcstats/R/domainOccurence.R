## Returns: domain level average frequency of occurence,
## variance in occurrence, standard error,
## coeffiecient of variation, number of PSUs (n), number of SSUs(m), and number 
## of possible SSUs (NMTOT) for the sampling domain
domainOccurrence = function(sample.data, stratum.data, species, years = "all",
                         strata = "all", includes.protected = FALSE){
  r = rvcData(sample.data, species, years, strata, includes.protected)
  s = stratData(stratum.data, years, strata, includes.protected)
  d = domain(r,s, calculate.density = FALSE)
  names(d)[names(d) == "yi"] = "occurrence"
  return(d)
}
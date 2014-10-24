## Returns: domain level average density, variance in density, standard error,
## coeffiecient of variation, number of PSUs (n), number of SSUs(m), and number 
## of possible SSUs (NMTOT) for the sampling domain
domainDensity = function(sample.data, stratum.data, species, years = "all",
                         strata = "all", includes.protected = FALSE){
  r = rvcData(sample.data, species, years, strata, includes.protected)
  s = stratData(stratum.data, years, strata, includes.protected)
  d = domain(r,s)
  names(d)[names(d) == "yi"] = "density"
  return(d)
}
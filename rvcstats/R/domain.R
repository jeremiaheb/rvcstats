## Returns: The average density/occurence (yi) per SSU (177m^2), variance, SE, and CV
## and total number of samples nm for the entire sampling domain
## Given: An RVC object, a STRAT object, and optional parameters passed
## to stratDensity
domain = function(rvcObj, stratObj, calculate.density = TRUE, ...){
  strat = strat(rvcObj, stratObj, calculate.density, ...)
  
  ## Select aggregate by variables
  agg.by = as.list(strat[names(strat) %w/o% c("NTOT","STRAT", "wh", "yi", "mbar", "n",
                                      "v1", "v2", "nm", "v2", "vbar", "NMTOT")])
  ## Calculate density, variance, SE, CV, and nm
  domain = with(strat, aggregate(wh*yi, by = agg.by, FUN = sum))
  names(domain)[length(names(domain))] = "yi"
  domain$variance = with(strat, aggregate(wh^2*vbar, by = agg.by, FUN = sum)$x)
  domain$se = sqrt(domain$variance)
  domain$cv = with(domain, (se/yi)*100)
  domain$n = with(strat, aggregate(n, by = agg.by, FUN = sum)$x)
  domain$nm = with(strat, aggregate(nm, by = agg.by, FUN = sum)$x)
  domain$NMTOT = with(strat, aggregate(NMTOT, by = agg.by, FUN = sum)$x)
  
  return(domain)
}
## Returns: A data.frame of  
## The average density/occurence (yi) per SSU (177m^2), variance, SE, and CV
## and total number of samples nm for the entire sampling domain
## Given: An RVC object, and calc, a character 'd' for density (default)
## or 'p' for occurrence
domain  <-  function(rvcObj, calc = "d"){
  strat  <-  strat(rvcObj, calc)
  
  ## Select aggregate by variables
  agg_by  <- c("SPECIES_CD", "YEAR");
  ## If includes_protected is TRUE, add to agg_by vars
  if (attr(rvcObj, "includes_protected")){
    agg_by  <- c(agg_by, "PROT")
  }
  agg_by = as.list(strat[agg_by])
  ## Calculate density/occurrence, variance, SE, CV, and nm
  domain = with(strat, aggregate(list(yi = wh*yi), by = agg_by, FUN = sum))
  domain$variance = with(strat, aggregate(wh^2*vbar, by = agg_by, FUN = sum)$x)
  domain$se = sqrt(domain$variance)
  domain$cv = with(domain, (se/yi)*100)
  domain$n = with(strat, aggregate(n, by = agg_by, FUN = sum)$x)
  domain$nm = with(strat, aggregate(nm, by = agg_by, FUN = sum)$x)
  domain$NMTOT = with(strat, aggregate(NMTOT, by = agg_by, FUN = sum)$x)
  
  return(domain)
}
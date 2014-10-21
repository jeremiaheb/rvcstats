## Returns: The average density/occurence (yi) per SSU (177m^2), variance, SE, and CV
## and total number of samples nm for the entire sampling domain
## Given: An RVC object, a STRAT object, and optional parameters passed
## to stratDensity
domain = function(rvcObj, stratObj, ...){
  strat = strat(rvcObj, stratObj, ...)
  ## If strat includes protected areas, weight strata by year and protected status,
  ## otherwise weight only by year
  if ("PROT" %in% names(strat)){
    dat = unique(strat[c("NTOT","YEAR","PROT")])
    f = formula(NTOT ~ YEAR + PROT)
    by = c("YEAR", "PROT")
  } else {
    dat = unique(strat[c("NTOT","YEAR")])
    f = formula(NTOT ~ YEAR)
    by = "YEAR"
  }
  xx = aggregate(f, data = dat, FUN = sum)
  strat$id = 1:nrow(strat) #save order of strat
  xx = merge(strat,xx, by = by)
  xx = xx[order(xx$id),] ## Retrieve order of of strat
  strat$wh = xx$NTOT.x/xx$NTOT.y
  ## Clean Up
  rm(xx)
  strat = strat[names(strat) %w/o% "id"]
  
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
  
  return(domain)
}
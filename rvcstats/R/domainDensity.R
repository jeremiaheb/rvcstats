## Returns: The average density per SSU (177m^2), variance, SE, and CV
## and total number of samples nm for the entire sampling domain
## Given: An RVC object, a STRAT object, and optional parameters passed
## to stratDensity
domainDensity = function(rvcObj, stratObj, ...){
  strat = stratDensity(rvcObj, stratObj, ...)
  ## If strat density includes protected areas, reweight by protected status
  if ("PROT" %in% names(strat)){
    xx = aggregate(NTOT ~ YEAR + PROT, data = unique(strat[c("NTOT","YEAR","PROT")]), FUN = sum)
    strat$id = 1:nrow(strat) #save order of strat
    xx = merge(strat,xx, by = c("YEAR","PROT"))
    xx = xx[order(xx$id),] ## Retrieve order of of strat
    strat$wh = xx$NTOT.x/xx$NTOT.y
    ## Clean Up
    strat = strat[names(strat) %w/o% "id"]
  }
  ## Select aggregate by variables
  agg.by = as.list(strat[names(strat) %w/o% c("NTOT","STRAT", "wh", "dbar", "mbar", "n",
                                      "v1", "v2", "nm", "v2", "vbar", "NMTOT")])
  ## Calculate density, variance, SE, CV, and nm
  domain = with(strat, aggregate(wh*dbar, by = agg.by, FUN = sum))
  names(domain)[length(names(domain))] = "density"
  domain$variance = with(strat, aggregate(wh^2*vbar, by = agg.by, FUN = sum)$x)
  domain$se = sqrt(domain$variance)
  domain$cv = with(domain, (se/density)*100)
  domain$nm = with(strat, aggregate(nm, by = agg.by, FUN = sum)$x)
  
  return(domain)
}
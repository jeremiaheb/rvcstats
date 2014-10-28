## Returns: The optimum number of primary sample units per stratum given:
## a target coefficient of variance (cv in %), an RVC object, and a 
## STRAT object
## optionally, the optimum number of SSUs per PSU (default = 2)
## whether n* should be calculated per stratum or for the entire 
## domain (default = TRUE)
nStar = function(cv, rvcObj, stratObj, ..., m=2, per.stratum = TRUE){
  ## Make sure rvcObj and stratObj do not contain protected
  if (!is.null(rvcObj$PROT) | !is.null(stratObj$PROT)){
    stop("make sure includes.protected = FALSE for rvcObj and stratObj.
         see ?rvcData and ?stratData for more details")
  }
  ## n* = sum(wh*suh * (sum(wh*suh) + sum(wh^2*s2h^2/m*wh*suh)))/
  ## (vstar + sum(wh^2*s1h^2/NTOT))
  s = strat(rvcObj, stratObj, ...)
  ## wsh = sum(wh*suh)
  wsh = aggregate(wh*sqrt(vbar) ~ YEAR + SPECIES_CD, data = s, FUN = sum)
  names(wsh)[length(wsh)] = "wsh"
  ## wss = sum(wh^2*s2h^2/(m*wh*suh))
  wss = aggregate((wh^2*v2)/(m*wh*sqrt(vbar)) ~ YEAR + SPECIES_CD, data = s, FUN = sum)[,3]
  ## wsp = sum(wh^2*s1^2/NTOT)
  wsp = aggregate(wh^2*v1/NTOT ~ YEAR + SPECIES_CD, data = s, FUN = sum)[,3]
  ## vstar = (cv/100)^2*yi^2
  vstar = ((cv/100)*weighted.mean(s$yi, s$wh))^2
  ## Optimal n per year
  nstar = data.frame(YEAR = wsh$YEAR, SPECIES_CD = wsh$SPECIES_CD,  wsh = wsh$wsh, cv = cv,
                     nstar = (wsh$wsh*(wsh$wsh+wss))/(vstar+wsp))
  if (!per.stratum){
    nstar = nstar[,-3]
    return(nstar)
  } else {
  ## Merge with original to calculate nstar allocation per stratum 
  ## nstarh = nstar*(wh*suh/wsh)
  xx = merge(s, nstar, by = c("YEAR", "SPECIES_CD"))
  xx$nstarh = with(xx,nstar*(wh*sqrt(vbar)/wsh))
#   
#   ## Clean Up Returned Data
  r = data.frame(YEAR = xx$YEAR, SPECIES_CD = xx$SPECIES_CD, STRAT = xx$STRAT, cv = cv, nstar = ceiling(xx$nstarh))
  return(r)  
}
}

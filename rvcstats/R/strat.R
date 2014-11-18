## Returns: a data.frame of avg. counts/ occurence (yi), total stratum variance (vbar)
## variance among PSUs (v1), variance among SSUs (v2), 
## avg. SSUs per PSU (mbar), number of PSUs (n), number of SSUs (nm),
## total number of possible PSUs (NTOT), and total number of possible
## SSUs (NMTOT) per Stratum
## Given an RVC object and which parameter to calculate
## 'd' for density (default) and 'p' for occurrence
strat <- function(rvcObj, calc = "d") {
  ## Calculate PSU densities/occurrences
  psu <- .psu(rvcObj, calc);
  ## Set the variables by which to aggregate
  agg_by <- c("SPECIES_CD", "YEAR", "STRAT");
  ## If includes_protected is TRUE add to
  ## aggregate by variables
  if (attr(rvcObj, "includes_protected")){
    agg_by  <- c(agg_by, "PROT");
  }
  ## Make agg_by into a list
  agg_by  <- as.list(psu[agg_by]);
  ## Calculate average density/occurrence
  samp <- aggregate(list(yi = psu$yi), by = agg_by, FUN = mean);
  ## Calculate mbar
  samp$mbar <- aggregate(psu$m, by = agg_by, FUN = mean)$x;
  ## Calculate n
  samp$n <- aggregate(psu$m, by = agg_by, FUN = length)$x;
  ## Calculate v1
  samp$v1 <- aggregate(psu$yi, by = agg_by, FUN = var)$x;
  ## Calculate nm, v2, and np
  samp$nm <- aggregate(psu$m, by = agg_by, FUN = sum)$x;
  np <- aggregate(psu$np.freq, by = agg_by, FUN = sum)$x;
  v2 <- aggregate(psu$vari, by = agg_by, FUN = sum)$x;
  samp$v2 <- ifelse(np>0, v2/np, 0);
  rm(v2)
  
  ## Get stratum data
  strat  <- rvcObj$stratum_data;
  
  ## Merge strat and samp
  strat2 <- merge(strat, samp)
  
  ## Calculate MTOT
  MTOT <- with(strat,round(GRID_SIZE^2/(pi*7.5^2), 0));
  ## Calculate variance weights, variance, and NMTOT
  fn <- with(strat2, n/NTOT);
  fm <- with(strat2, mbar/MTOT);
  strat2$vbar <- with(strat2, ((1-fn)*v1/n)+((fn*(1-fm)*v2)/nm));
  strat2$NMTOT <- with(strat2, NTOT*MTOT);
  
return(strat2)
}
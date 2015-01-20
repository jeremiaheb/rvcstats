## Returns: a data.frame of the avg. counts or occurence (yi), 
## variance in counts or occurrence (vari), 
## number of SSUs (m), and replicate status (np.freq) for each PSU.
## Given an RVC object and calc, a code for whether density or occurrence
## should be calculated
.psu = function(rvcObj, calc = "d"){
  ## get the ssu data
  ssu  <- .ssu(rvcObj, calc);
  ## Set the variables by which to aggregate
  agg_by  <- c("SPECIES_CD", "YEAR", "REGION", "STRAT", "PRIMARY_SAMPLE_UNIT");
  ## If merge_protected is FALSE add to agg_by vars
  if (!attr(rvcObj, "merge_protected")){
    agg_by  <- c(agg_by, "PROT");
  }
  ## Number of SSUs per PSU
  psu  <- with(
    ssu,
    aggregate(list(m = STATION_NR), by = as.list(ssu[agg_by]), FUN = length)
    );

  ## Avg. counts/occurence in SSU by PSU
  psu$yi = aggregate(ssu$yi, by = as.list(ssu[agg_by]), FUN = mean)$x
  
  ## If calc == 'd' calculate variance for 
  ## continuous distribution, else for binomial distribution
  if (calc == "d"){
    ## Variance in counts of each SSU by PSU
    psu$vari = aggregate(ssu$yi, by = as.list(ssu[agg_by]),
                         FUN = function(x){ifelse(is.na(var(x)),0,var(x))})$x;
    
  } else {
    psu$vari = ifelse(psu$m==1, 0, psu$m/(psu$m-1)*psu$yi*(1-psu$yi));
  }
  
  ## Replicate status
  psu$np.freq = ifelse(psu$m>1,1,0)
  
  return(psu)
}
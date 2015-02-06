## Returns: A dataframe with the weighting for each stratum provided
addWeighting  <- function(x, merge_protected, when_present){
  ## Set the variables by which to aggregate 
  if (merge_protected){
    by  <- alist(YEAR = YEAR, REGION = REGION, SPECIES_CD = SPECIES_CD);
  } else {
    by  <- alist(YEAR = YEAR, REGION = REGION, PROT = PROT, SPECIES_CD = SPECIES_CD); 
  }
  ## If when_present is TRUE, drop any strata
  ## where species was not present
  if (when_present){
    x  <- subset(x, yi != 0);
  }
  ## Calculate weighting
  # Calculate total NTOT per year, region, species
  TOT  <- with(x, aggregate(list(TOT = NTOT), lapply(by, eval.parent), sum));
  # Merge TOT with x
  out  <- merge(x, TOT);
  # Calculate weighting 
  out$wh  <- out$NTOT/out$TOT
  # Remove TOT from output
  c  <- which(names(out) == "TOT");
  out  <- out[-c];
  # Return
  return(out)
}
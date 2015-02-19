## Returns: Domain level length-frequency given,
## x, a data.frame of strat data, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
domainLengthFrequency  <- function(x, merge_protected){
  ## Arguments
  args1  <- alist(x = list(yi = wh*yi),
                  by = aggBy("domain", "length_frequency", merge_protected=FALSE),
                  FUN= sum, na.rm = TRUE);
  args2  <- alist(x = list(sum_yi = wh*yi),
                  by = NULL,
                  FUN= sum, na.rm = TRUE);
  ## Cases
  # If merge protected is true, sum by year, region and species
  # else by year, region, species, and protected status
  if (merge_protected){
    args2$by  <- with(x,list(YEAR = YEAR, REGION = REGION,
                             SPECIES_CD = SPECIES_CD));
  } else {
    args2$by  <- with(x,list(YEAR = YEAR, REGION = REGION,
                             PROT = PROT, 
                             SPECIES_CD = SPECIES_CD));
  }

  ## Evaluation
  out  <- with(x,merge(
    do.call(aggregate, args1),
    do.call(aggregate, args2)
    ));
  out$yi  <- with(out, yi/sum_yi);
  # Remove scaling factor
  c  <- which(names(out) == "sum_yi");
  out  <- out[-c];
  
  ## If merge protected merge protected and unprotected areas
  if (merge_protected){
    out  <- with(out,
                 aggregate(
                   list(yi = yi),
                   by = aggBy("domain", "length_frequency", merge_protected),
                   FUN = sum, na.rm = TRUE
                   )
                 );
  }
  return(out)
}
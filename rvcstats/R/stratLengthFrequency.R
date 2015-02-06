## Returns: Stratum level length_frequency given,
## x, a psu object, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
stratLengthFrequency  <- function(x, merge_protected){
  ## Arguments
  args1  <- alist(x = list(yi = yi), by = aggBy("stratum", "length_frequency", merge_protected),
                  FUN = sum);
  args2  <- alist(x = list(TOT = yi), by = aggBy("stratum", "abundance", merge_protected),
                  FUN = function(x){ifelse(sum(x)==0,NA,sum(x))});
  ## Evaluation
  byLen  <- with(x$sample_data,do.call(aggregate, args1));
  byStrat  <- with(x$sample_data,do.call(aggregate, args2));
  #Merge the two
  out  <- merge(byLen, byStrat);
  # Calculate frequencies
  out$yi  <- with(out, yi/TOT);
  # Remove TOT column
  c  <- which(names(out) == "TOT");
  out  <- out[-c];
  # Add in stratum info
  stratum_data  <- x$stratum_data;
  # If merge protected is TRUE, merge protected and unprotected NTOTs
  if (merge_protected){
    stratum_data  <- aggregate(NTOT ~ YEAR + REGION + STRAT + GRID_SIZE,
                               data = stratum_data, FUN = sum);
  }
  # Merge with output
  out  <- merge(stratum_data, out);
  # Return
  return(out)
}
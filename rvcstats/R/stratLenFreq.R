## Returns: data.frame of stratum level length frequency 
## given an RVC object
stratLenFreq <- function(rvcObj){
  ## get length and stratum data
  len  <- rvcObj$sample_data;
  strat  <- rvcObj$stratum_data;
  ## set aggregate by variables
  byStrat  <- c("SPECIES_CD", "YEAR", "STRAT");
  byLen  <- c("SPECIES_CD", "YEAR", "STRAT","LEN");
  ## If includes_protected is TRUE add to aggregate vars
  if (attr(rvcObj, "includes_protected")){
    byStrat  <- c(byStrat, "PROT");
    byLen  <- c(byLen, "PROT");
  }
  ## Make aggregate by vars into lists 
  byStrat  <- as.list(len[byStrat]);
  byLen  <- as.list(len[byLen]);
  ## Get totals per stratum and total number at 
  ## length per stratum
  x  <- aggregate(list(NUM = len$NUM), byLen, sum);
  y  <- aggregate(list(TOT = len$NUM), byStrat, sum);
  ## Merge x and y
  out  <- merge(x,y);
  ## Calculate frequency
  out$freq  <- with(out, NUM/TOT);
  ## Turn 0/0 into 0
  out$freq[is.nan(out$freq)]  <- 0; 
  # TODO: Figure out how to make it so
  # frequencies add up to one despite
  # factors
  ## Clean up output
  out  <- out[names(out) %w/o% c("NUM","TOT")];
  
  return(out)
}
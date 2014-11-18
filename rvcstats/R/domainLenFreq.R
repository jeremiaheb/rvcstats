## Returns: A data.frame of the domain level length
## frequency given an RVC object
domainLenFreq  <- function(rvcObj){
  ## Get the stratum level frequencies and
  ## stratum data
  len  <- stratLenFreq(rvcObj);
  strat  <- rvcObj$stratum_data;
  ## Merge len and strat
  merged  <- merge(strat, len);
  ## Set agg_by vars
  agg_by  <- c("SPECIES_CD", "YEAR", "LEN");
  ## If includes_protected is TRUE add to agg_by
  if (attr(rvcObj, "includes_protected")){
    agg_by  <- c(agg_by, "PROT")
  }
  ## Turn agg_by into a list
  agg_by  <- as.list(merged[agg_by]);

  ## Get weighted frequencies
  frwh  <- with(merged, wh*freq);
  ## Aggregate by domain
  out  <- aggregate(list(freq = frwh),
              by = agg_by, FUN = sum);
  
  return(out)
}
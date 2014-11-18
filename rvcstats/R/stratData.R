## Returns: A data.frame with the weightings for each stratum
.stratData  <-  function(stratum_data, includes_protected){
  ## Select variables to aggregate by
  agg_by  <-  c("YEAR", "STRAT", "GRID_SIZE");
  byYear  <- c("YEAR");
  ## If includes_protected is TRUE add includes protected to agg by vars
  if (includes_protected){
    agg_by  <-  c(agg_by, "PROT");
    byYear  <- c(byYear, "PROT");
  }
  ## Turn aggregate by variables into lists
  agg_by  <-  as.list(stratum_data[agg_by]);
  byYear  <- as.list(stratum_data[byYear]);
  ## Aggregate by year and stratum
  year  <- aggregate(list(TOT = stratum_data$NTOT), by = byYear, FUN = sum);
  strat  <-  aggregate(list(NTOT = stratum_data$NTOT), by = agg_by, FUN = sum);
  ## Merge year and stratum
  out  <- merge(strat, year);
  ## Calculate weighting
  out$wh  <- with(out, NTOT/TOT);
  ## Remove TOT from output
  out  <- out[names(out) %w/o% "TOT"]
  return(out)
}
## Returns: A data.frame with the weightings for each stratum
.stratData = function(stratum_data, includes_protected){
  ## Select variables to aggregate by
  agg_by = c("YEAR", "STRAT", "GRID_SIZE")
  ## If includes_protected is TRUE add includes protected to agg_by
  if (includes_protected){
    agg_by = c(agg_by, "PROT")
  }
  ## Subset and aggregate (if neccessary) by agg_by variables
  agg_by = as.list(stratum_data[agg_by])
  out = aggregate(list(NTOT = stratum_data$NTOT), by = agg_by, FUN = sum)
  return(out)
}
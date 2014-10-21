## Returns: The length frequency for each stratum for a given species and 
## RVC data, years, and strata
.lengthFreq = function(data, includes.protected){
  
  ## Set agg.by variables
  agg.by = c("SPECIES_CD", "YEAR", "STRAT", "LEN")
  
  ## If includes.protected is TRUE aggregate by that as well
  if (includes.protected){
    agg.by = c("PROT", agg.by)
  }
  
  ## Total number counted per length class
  lenf = aggregate(data$NUM, by = as.list(data[agg.by]), FUN = sum)
  names(lenf)[length(names(lenf))] = "COUNT"
  
  agg.by = agg.by[-length(agg.by)] # Change agg.by to not include length
  ## Total number counted for all length classes
  tot = aggregate(data$NUM, by = as.list(data[agg.by]), FUN = sum)
  names(tot)[length(names(tot))] = "TOTAL"
  
  ## merge 
  lenf = merge(lenf, tot, by = agg.by)
  
  ## Calculate frequency
  lenf$frequency = ifelse(lenf$TOTAL == 0, 0, lenf$COUNT/lenf$TOTAL)
  
  return(lenf[names(lenf) %w/o% c("TOTAL","COUNT")])
}
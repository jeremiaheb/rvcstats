## Returns: The length frequency for each stratum for a given species and 
## RVC data, years, and strata
.lengthFreq = function(data, species, years = "all", strata = "all", includes.protected){
  ## Make sure data names are uppercase
  names(data) = toupper(names(data))
  ## subset by years in years
  if (years != "all") {
    data = subset(data, YEAR %in% years)
  }
  ## Subset by strata in strata
  if (strata != "all") {
    data = subset(data, STRAT %in% strata)
  }
  ## Subset by species in species
  data = subset(data, SPECIES_CD %in% species)
  
  ## Set agg.by variables
  agg.by = c("SPECIES_CD", "YEAR", "STRAT", "LEN")
  
  ## If includes.protected is TRUE aggregate by that as well
  if (includes.protected){
    data$PROT = ifelse(data$MPA_NR > 0, 1,0)
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
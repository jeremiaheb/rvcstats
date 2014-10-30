## Returns: Length Frequency data aggregated by species 
## and agg.by variables (default = "YEAR"), 
## Possible agg.by variables include "YEAR", "STRAT", and "PROT"
lenFreq = function(sample.data, stratum.data, species, years = "all", strata = "all",
                   includes.protected = FALSE, by.stratum = FALSE){
  ## Check LEN variable in data
  names(sample.data) = toupper(names(sample.data))
  .inList("required variable", "LEN", names(sample.data))
  
  ## If years != all, subset by selected years
  if (all(years != "all")){
    ## check that selected years are in data
    .inList("years", years, unique(sample.data$YEAR))
    sample.data = subset(sample.data, YEAR %in% years)
  }
  ## If strata != "all", subset by selected strata
  if (all(strata != "all")){
    ## Make strata uppercase
    strata = toupper(strata)
    ## check that selected strata are in data
    .inList("strata", strata, unique(sample.data$STRAT))
  }
  ## Subset by species
  species = .toSpcCd(species)
  sample.data = subset(sample.data, SPECIES_CD %in% species)
  
  ## Get Stratum Weighting info
  s = strat(
    rvcData(sample.data, species, years, strata, includes.protected),
    stratData(stratum.data, years, strata, includes.protected)
    )
  
  ## Set agg.by variables
  agg.by = c("SPECIES_CD", "YEAR", "STRAT")
  
  ## If PROT includes.protected, add to agg.by variables
  ## And add to sample.data
  if (includes.protected){
    ## Check that MPA_NR is available
    .inList("required variable", "MPA_NR", names(sample.data))
    sample.data$PROT = ifelse(sample.data$MPA_NR > 0, 1, 0)
    agg.by = c(agg.by, "PROT")
  }
  
  ## Total for each grouping
  xx = aggregate(sample.data$NUM, by = as.list(sample.data[agg.by]), FUN = sum)
  names(xx)[length(names(xx))] = "TOTAL"

  ## Add LEN to agg.by variables
  agg.by = c(agg.by, "LEN")
  
  ## Total for each length class within each grouping
  yy = aggregate(sample.data$NUM, by = as.list(sample.data[agg.by]), FUN = sum)
  names(yy)[length(names(yy))] = "COUNT"
  
  ## Merge by original agg.by variables
  agg.by = agg.by[-length(agg.by)]
  zz = merge(xx,yy,by = agg.by)
  rm(xx,yy)
  
  ## Calculate length frequencies
  zz$frequency = ifelse(zz$TOTAL !=0, zz$COUNT/zz$TOTAL,0)
  zz = zz[names(zz) %w/o% c("COUNT", "TOTAL")] 

  if (by.stratum){
    return(zz)
  } else {
  
  ## Remove LEN from agg.by
  agg.by = agg.by %w/o% "LEN"
  
  ## Merge with stratum data
  ww = merge(s, zz, by = names(zz) %w/o% c("LEN","frequency"))
  
  ## Remove STRAT from agg.by
  agg.by = agg.by %w/o% "STRAT"
  
  
  sum_fwh = aggregate(ww$wh*ww$frequency, by = as.list(ww[agg.by]), FUN = sum)
  names(sum_fwh)[length(names(sum_fwh))] = "sum_fwh"
  
  ## Merge weighted freuencies with length frequency data
  rr = merge(ww,sum_fwh, by = agg.by) 
  rm(ww)
  
  ## Calculate final weighted frequencies normalized to sum to one
  rr$freq = with(rr, wh*frequency/sum_fwh)
  
  
  # Add LEN back to agg.by
  agg.by = c(agg.by, "LEN")
  
  ss = aggregate(list(frequency = rr$freq), by =as.list(rr[agg.by]), FUN = sum)
  
  return(ss)
  }
}
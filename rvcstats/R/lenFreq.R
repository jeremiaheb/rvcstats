## Returns: Length Frequency data aggregated by species 
## and agg.by variables (default = "YEAR"), 
## Possible agg.by variables include "YEAR", "STRAT", and "PROT"
lenFreq = function(data, species, years = "all", strata = "all", 
                agg.by = c("YEAR")){
  ## Check to make sure variable names are correct in data
  names(data) = toupper(names(data))
  reqd = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT",
           "STATION_NR", "NUM", "LEN")
  .inList("required variables", reqd, names(data))
  
  ## If years != all, subset by selected years
  if (years != "all"){
    ## check that selected years are in data
    .inList("years", years, unique(data$YEAR))
    data = subset(data, YEAR %in% years)
  }
  ## If strata != "all", subset by selected strata
  if (strata != "all"){
    ## Make strata uppercase
    strata = toupper(strata)
    ## check that selected strata are in data
    .inList("strata", strata, unique(data$STRAT))
  }
  ## If PROT is an agg.by variable, code for PROT
  if ("PROT" %in% agg.by){
    ## Check that MPA_NR is available
    .inList("required variable", "MPA_NR", names(data))
    data$PROT = ifelse(data$MPA_NR > 0, 1, 0)
  }
  ## Set species to species codes
  species = .toSpcCd(species)
  ## Subset by species
  data = subset(data, SPECIES_CD %in% species)
  
  ## Add species to grouping
  agg.by = c("SPECIES_CD", agg.by)
  
  ## Total for each grouping
  xx = aggregate(data$NUM, by = as.list(data[agg.by]), FUN = sum)
  names(xx)[length(names(xx))] = "TOTAL"

  ## Add LEN to agg.by variables
  agg.by = c(agg.by, "LEN")
  ## Total for each length class within each grouping
  yy = aggregate(data$NUM, by = as.list(data[agg.by]), FUN = sum)
  names(yy)[length(names(yy))] = "COUNT"
  
  ## Merge by original agg.by variables
  agg.by = agg.by[-length(agg.by)]
  zz = merge(xx,yy,by = agg.by)
  rm(xx,yy)
  
  ## Calculate and return length frequencies
  zz$frequency = ifelse(zz$TOTAL !=0, zz$COUNT/zz$TOTAL,0)
  zz = zz[names(zz) %w/o% c("COUNT", "TOTAL")]
  #class(zz) <- "LFRQ"
  return(zz)
  
}
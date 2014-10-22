## Returns: Length Frequency information aggregated by species, year,
## stratum and, if includes.protected = TRUE, protected status
lenf = function(data, species, years = "all", strata = "all", 
                includes.protected = FALSE){
  ## Check to make sure variable names are correct in data
  names(data) = toupper(names(data))
  reqd = c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR", "NUM", "LEN")
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
}
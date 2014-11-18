## Returns: an RVC object from data subsetted by species, years, and strata.
## if length_class != "all" it should be a numeric vector of length 2 with the
## minimum length as the first element and the maximum length as the second element
## inclusive of both. If includes_protected is TRUE column of protected status
## will be added to sample_data output
rvcData = function(sample_data, stratum_data, species, 
                   length_class = "all", when_present = FALSE, 
                   years = "all", strata = "all",
                   includes_protected = FALSE){  
  ## Check to make sure variable names are correct in data
  names(sample_data) <- toupper(names(sample_data));
  names(stratum_data) <- toupper(names(stratum_data));
  reqd1 <- c("SPECIES_CD", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR",
            "NUM");
  reqd2 <- c("YEAR","STRAT", "NTOT", "GRID_SIZE");
  .inList("required variables", reqd1, names(sample_data));
  .inList("required variables", reqd2, names(stratum_data));
  
  ##Parse full scientific names are trucated to SPECIES_CD
  species <- .toSpcCd(species)
  
  ## If years is not "all", check that years are in data and subset by years
  if (all(years != "all")){
    .inList("year(s)", years, sample_data$YEAR);
    .inList("year(s)", years, stratum_data$YEAR);
    sample_data <- subset(sample_data, YEAR %in% years);
    stratum_data <- subset(stratum_data, YEAR %in% years);
  }
  ## If strata is not "all" check that strata are in data and subset by strata
  if (all(strata != "all")){
    strata <- toupper(strata);
    .inList("strata", strata, sample_data$STRAT);
    .inList("strata", strata, stratum_data$STRAT);
    sample_data <- subset(sample_data, STRAT %in% strata);
    stratum_data <- subset(stratum_data, STRAT %in% strata);
  }
  ## If length_class != "all" recode NUM so that only 
  ## any individuals outside the range provided are 0
  ## e.g. output is inclusive of left and right range
  if (all(length_class != "all")){
    sample_data$NUM  <- with(
      sample_data,
      ifelse(LEN < length_class[1] | LEN > length_class[2],
             0, NUM)
    );
  }
  ## If when_present is true subset to only include rows where 
  ## NUM > 0
  if (when_present){
    sample_data <- subset(sample_data, NUM > 0);
  }
  ## If includes_protected is TRUE add to vars and code for protected status
  if (includes_protected){
    .inList("required variable", "MPA_NR", names(sample_data));
    .inList("required variable", "PROT", names(stratum_data));
    sample_data$PROT = ifelse(sample_data$MPA_NR > 0, 1,0);
  }
  ## Check that species are in data, and subset by species
  .inList("species", species, sample_data$SPECIES_CD)
  sample_data  <- subset(sample_data, SPECIES_CD %in% species)
  ## If includes protected is FALSE aggregate protected and unprotected 
  ## strata
  stratum_data  <- .stratData(stratum_data, includes_protected);
  ## Prepare output and return
  out  <- list(sample_data = sample_data, stratum_data = stratum_data);
  class(out)  <- "RVC"; #set class
  attr(out, "includes_protected")  <- includes_protected; #add protected status attribute
  return(out)
}
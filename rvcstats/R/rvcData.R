#' An RVC data object
#' @export
#' @description Creates an RVC data object from Reef Visual Census
#' sample and stratum data
#' @name rvcData
#' @param sample_data 
#' A data.frame or list containing the Reef Visual Census
#' sample data. Must include variables named "SPECIES_CD", "YEAR",
#'  "STRAT", "PRIMARY_SAMPLE_UNIT", "STATION_NR", "NUM"
#'  (not case-sensitive).
#' @param stratum_data 
#' A data.frame or list containing the stratum information. 
#' Must include variables names "YEAR", "STRAT", "NTOT"
#' (not case-sensitive).
#' @param species
#' A character vector of scientific names or species codes,
#' e.g. 'Lutjanus griseus' or 'LUT GRIS' (not case-sensitive).
#' @param length_class
#' A numeric vector of length two, with the first value the minimum length and
#' the second the maximum length (inclusive) to include in RVC object.
#' Default value of 'all' selects for all lengths.
#' @param when_present 
#' A boolean: FALSE (default) to include stations where species 
#' is present and absent, and TRUE to select only stations
#' where species is present.
#' @param years
#' A numeric vector of the years to select from data. 
#' Default value 'all' selects for all years present in data.
#' @param strata
#' A character vector of the strata to select from data.
#' Default value of 'all' selects for all strata in data.
#' @param includes_protected
#' A boolean: FALSE (default) does not differentiate between
#' protected and unprotected areas within strata, TRUE does.
#' @return Returns an RVC object with two elements:
#' \item{sample_data}{Contains the original sample data subsetted by
#' input arguments}
#' \item{stratum_data}{Contains original stratum data subsetted by
#' input arguments}
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
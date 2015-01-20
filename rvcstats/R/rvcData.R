#' An RVC data object
#' @export
#' @description Creates an RVC data object from Reef Visual Census
#' sample and stratum data
#' @name rvcData
#' @param species
#' A character vector of scientific names or species codes,
#' e.g. 'Lutjanus griseus' or 'LUT GRIS' (not case-sensitive).
#' @param year
#' A numeric vector of the years to select from data. 
#' Default value NULL selects for all years present in data.
#' @param region
#' A character vector of the region code(s) to select from 
#' data. Default value of NULL selects for all regions 
#' present in the data. 
#' @param stratum
#' A character vector of the strata codes to select from data.
#' Default value of NULL selects for all strata in data.
#' @param protected
#' A boolean indicating whether only protected areas should be 
#' selected. Default value of NULL selects both protected and 
#' unprotected areas.
#' @param length_class
#' A numeric vector of length two, with the first value the minimum length (exclusive) and
#' the second the maximum length (inclusive) to include in RVC object. 
#' e.g. length_class = c(x,y) indicates lengths greater than but not 
#' including x up to and including y.
#' Default value of NULL selects for all lengths.
#' @param when_present 
#'  A boolean indicating whether only stations where the selected species
#'  were seen should be selected. Default of FALSE selects for all stations, whether
#'  or not the selected species were seen. NOTE: Only works when one species 
#'  selected in species argument.  
#' @param merge_protected
#' A boolean indicating whether protected and unprotected areas should be merged
#' in the results. Default value of TRUE does not differentiate between protected and
#' unprotected areas. 
#' @return Returns an RVC object with two elements:
#' \item{sample_data}{Contains the original sample data subsetted by
#' input arguments}
#' \item{stratum_data}{Contains original stratum data subsetted by
#' input arguments}
rvcData = function(species, year, region = NULL, stratum = NULL,
                   protected = NULL, length_class = NULL,
                   when_present = FALSE, merge_protected = TRUE,
                   server = '128.0.0.1'){  
  ## Parse full scientific names are trucated to SPECIES_CD
  species <- .toSpcCd(species);
  ## Make stratum codes upper case if not already
  stratum  <- toupper(stratum);
  
  ## Get Data from server
  sample_data  <- .getSampleData(species, year, region, stratum,
                                as.numeric(protected), as.numeric(when_present), 
                                server)
  stratum_data  <- .getStratumData(year, region, stratum, 
                                   as.numeric(protected), server)
  
  ## If length_class != NULL recode NUM so that only 
  ## any individuals outside the range provided are 0
  ## Output is inclusive of left range and exclusive of right
  ## e.g. [0,x) includes 0 but not x
  if (all(!is.null(length_class))){
    sample_data$NUM  <- with(
      sample_data,
      ifelse(LEN < length_class[1] | LEN >= length_class[2],
             0, NUM)
    );
  }

  ## If merge_protected is FALSE add to vars and code for protected status
  if (!merge_protected){
    sample_data$PROT = ifelse(sample_data$MPA_NR > 0, 1,0);
  }
  
  ## If includes protected is FALSE aggregate protected and unprotected 
  ## strata
  stratum_data  <- .stratData(stratum_data, merge_protected);
  
  ## Prepare output and return
  out  <- list(sample_data = sample_data, stratum_data = stratum_data);
  class(out)  <- "RVC"; #set class
  attr(out, "merge_protected")  <- merge_protected; #add merge_protected attribute
  return(out)
}
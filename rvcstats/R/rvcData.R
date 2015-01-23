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
#' data. 
#' @param ...
#' Optional parameters passed to rvcData, e.g. server
#' @return Returns an RVC object with two elements:
#' \item{sample_data}{Contains the original sample data subsetted by
#' input arguments}
#' \item{stratum_data}{Contains original stratum data subsetted by
#' input arguments}
rvcData = function(species, year, region,
                   server = 'http://localhost:3000'){  
  ## Parse full scientific names are trucated to SPECIES_CD
  species <- .toSpcCd(species);
  ## Make region codes upper case if not already
  region  <- toupper(region);
  ## Get Data from server
  sample_data  <- .getSampleData(species, year, region, server=server);
  stratum_data  <- .getStratumData(year, region, server=server);
  ## Add weighting to stratum data
  stratum_data  <- .stratData(stratum_data, merge_protected = FALSE);
  ## Prepare output and return
  out  <- list(sample_data = sample_data, stratum_data = stratum_data);
  class(out)  <- "RVC"; #set class
  attr(out, "merge_protected") <- FALSE;
  return(out)
}
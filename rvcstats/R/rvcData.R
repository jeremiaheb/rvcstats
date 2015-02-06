#' Get RVC data from server
#' @export
#' @description Creates an RVC data object from Reef Visual Census
#' sample and stratum data
#' @name rvcData
#' @param species
#' A character vector of scientific names or species codes,
#' e.g. 'Lutjanus griseus' or 'LUT GRIS' (not case-sensitive).
#' @param year
#' A numeric vector of the years to select from data. 
#' @param region
#' A string of the region code to select from 
#' data. 
#' @seealso \code{\link{select}} \code{\link{getStat}}
#' @return Returns an RVC object with two elements:
#' \item{sample_data}{Contains the original sample data subsetted by
#' input arguments}
#' \item{stratum_data}{Contains original stratum data subsetted by
#' input arguments}
#' @examples
#' ## Names not case-sensitive
#' rvcData(species = 'Epinephelus morio', year = 2012, region = 'FLA KEYS')
#' ## Can pass multiple species and years
#' rvcData(c('LUT GRIS', 'LUT ANAL'), year = c(2010, 2012), region = 'FLA KEYS',
#' server = '127.0.0.1:3000')
rvcData = function(species, year, region,
                   server = 'http://localhost:3000'){  
  ## Parse full scientific names are trucated to SPECIES_CD
  species <- toSpcCd(species);
  ## Make region codes upper case if not already
  region  <- toupper(region);
  ## If more than one region raise error
  if (length(region)>1){
    stop('only one region can be selected at a time')
  }
  ## Get Data from server
  sample_data  <- getSampleData(species, year, region, server=server);
  stratum_data  <- getStratumData(year, region, server=server);
  ## Create output, set class to RVC, and return
  out  <- structure(list(sample_data = sample_data, stratum_data = stratum_data),
                    class="RVC");
  return(out)
}
#' Returns life history parameter data
#' @export
#' @description Returns a table of life history parameters given a single
#' or several species and a server location
#' @inheritParams rvcData
#' @return Returns a data.frame with:
#' \item{SPECIES_CD}{The species code: the first three 
#' letters of the genus name and the first four of the 
#' species name}
#' \item{LC}{The minimum length at capture in centimeters.
#' Generally corresponds to the minimum size limit}
#' \item{LM}{The median length at maturity in 
#' centimeters}
#' \item{WLEN_A}{The alpha coefficient of the allometric
#' growth equation in kg/cm}
#' \item{WLEN_B}{The beta coefficient of the allometric 
#' growth equation}
#' @note
#' The allometric growth equation:
#' \deqn{W(kg) = \alpha L(cm)^\beta }
#' @seealso \code{\link{rvcData}} \code{\link{getStratumData}}
#' \code{\link{getSampleData}}
getLhp  <- function(species, server='http://localhost:3000'){
  # Convert species to species code
  species = toSpcCd(species)
  # Put together URL and request
  url  <- paste(server, '/api/parameters.json', 
                toQuery(species = species),
                sep='');
  # Get data and convert JSON to list
  j  <- RJSONIO::fromJSON(RCurl::getURL(url));
  # Turn list into data.frame 
  out  <- do.call(rbind, lapply(j, as.data.frame));
  return(out)
}
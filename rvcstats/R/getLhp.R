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
#' growth equation in g ~ mm}
#' \item{WLEN_B}{The beta coefficient of the allometric 
#' growth equation in g ~ mm}
#' @note
#' The allometric growth equation:
#' \deqn{W(g) = \alpha L(mm)^\beta }
#' @seealso \code{\link{rvcData}} \code{\link{getStratumData}}
#' \code{\link{getSampleData}}
#' @examples
#' ## Retrieves life history parameters for Black Grouper
#' bg  <- getLhp(species = "Myc Bona")
getLhp  <- function(species, server='http://www.sefsc.noaa.gov/rvc_analysis/'){
  # Convert species to species code
  species = toSpcCd(species)
  # Put together URL and request
  url  <- paste(server, '/api/parameters.json', 
                toQuery(species = species),
                sep='');
  # Get data and convert JSON to list, 
  # if not connected return error
  j  <- getData(url);
  # If nothing is returned, raise warning
  if (length(j)==0){stop("provided species life history parameters not found on server")}
  # Turn list into data.frame 
  out  <- toDataFrame(j);
  # If not all species found return warning
  if (length(out$SPECIES_CD) != length(species)){
    warning("not all species life history parameters found on server")
  }
  # find "NA" and turn to NA
  # cast factor to numeric 
  # sometimes R can be a pain
  out[-1]  <- apply(out[-1], 2, 
                    function(x){
                      as.numeric(ifelse(x=="NA",NA,x))
                      });
  return(out)
}
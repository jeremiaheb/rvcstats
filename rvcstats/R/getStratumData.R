#' Retrieves stratum data from server
#' @export
#' @description Returns a data frame of stratum data pulled from the
#' server. Useful for writing your own function using the RVC data.
#' @inheritParams getSampleData
#' @seealso \code{\link{rvcData}} \code{\link{getSampleData}}
getStratumData  <- function(year, region, stratum=NULL,
                               protected=NULL, 
                            server = "http://localhost:3000") { 
 # Reformat parameters
  region = toupper(region);
  stratum = if(!is.null(stratum)){
    toupper(stratum);
  }
  protected = if(!is.null(protected)){
    as.numeric(protected);
  }
 # Put together URL and request
  url  <- paste(server, '/api/strats.json', 
                toQuery(year = year, region = region,
                         strat = stratum, prot = protected),
                sep='');
  # Get data and convert JSON to list, 
  # if not connected return error
  j  <- getData(url)
  ## Check that data was returned
  if(length(j)==0){stop("no stratum data returned from server")}
  # Turn list into data.frame 
  out  <- toDataFrame(j);
  return(out)
}
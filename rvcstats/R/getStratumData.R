#' Retrieves stratum data from server
#' @export
#' @description Returns a data frame of stratum data pulled from the
#' server. Useful for writing your own function using the RVC data.
#' @inheritParams getSampleData
#' @seealso \code{\link{rvcData}} \code{\link{getSampleData}}
getStratumData  <- function(year, region, stratum=NULL,
                               protected=NULL, server) {                     
 # Put together URL and request
  url  <- paste(server, '/api/strats.json', 
                toQuery(year = year, region = region,
                         strat = stratum, prot = protected),
                sep='');
  # Get data and convert JSON to list, 
  # if not connected return error
  j  <- tryCatch({RJSONIO::fromJSON(RCurl::getURL(url))},
                 error = function(cond){
                   message("the following error occurred:")
                   message(cond)
                   stop("make sure you are connected to the 
                        server and try again")
                 });
  ## Check that data was returned
  if(length(j)==0){stop("no stratum data returned from server")}
  # Turn list into data.frame 
  out  <- do.call(rbind, lapply(j, as.data.frame));
  return(out)
}
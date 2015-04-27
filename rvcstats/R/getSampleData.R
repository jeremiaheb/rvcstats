#' Retrieves RVC sample data from server
#' @export 
#' @description 
#' Returns a data frame of the sample data pulled from the server. Useful for 
#' analyzing the analysis ready data using custom functions not included
#' in this package.
#' @inheritParams rvcData
#' @param region
#' A character vector of the region(s) from which to get sample data.
#' \emph{Multiple regions may be selected}.
#' @inheritParams select
#' @param when_present
#' A boolean indicating whether only samples where 
#' individuals were seen should be selected. \cr
#' \emph{Multiple species may be selected}
#' @seealso \code{\link{rvcData}} \code{\link{getStratumData}}
#' @examples
#' ## Retrieve sample data for Red Grouper in 2012
#' ## In the Florida Keys
#' rg  <- getSampleData(species = "Epi Mori", year = 2012,
#' region = "FLA KEYS");
#' ## Retrieve sample data for Barraccuda in FLA KEYS 
#' ## in 2012 excluding all non-observations
#' bc  <- getSampleData(species = 'sph barr', year = 2012,
#' region = 'FLA KEYS', when_present = TRUE);
#' ## Retrieve sample data for Hogfish in FLA KEYS
#' ## in 2010-2012 for protected areas only
#' hf  <- getSampleData("lac maxi", 2010:2012, 
#' 'fla keys', protected = TRUE)
getSampleData  <- function(species, year, region, stratum=NULL,
                           protected=NULL, when_present=NULL, 
                           server = "http://localhost:3000"){
  ## Reformat all parameters
  species = toSpcCd(species);
  region = toupper(region);
  stratum = if(!is.null(stratum)){
    toupper(stratum);
  }
  protected = if(!is.null(protected)){
    as.numeric(protected);
  }
  when_present = if(!is.null(when_present)){
    as.numeric(protected);
  }
  # Put together URL and request
  url  <- paste(server, '/api/samples.json', 
          toQuery(species = species, year = year, region = region,
                   stratum = stratum, prot = protected, 
                   present = when_present),
          sep='');
  # Get data and convert JSON to list, 
  # if not connected return error
  message("starting to retrieve data from server, this could
          take a few minutes ... ")
  j  <- getData(url);
  message("... completed retrieving data")
  ## Check that data was returned
  if(length(j)==0){stop("no sample data returned from server")}
  # Turn list into data.frame 
  out  <- toDataFrame(j);
  return(out)
}
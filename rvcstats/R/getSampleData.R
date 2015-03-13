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
  j  <- getData(url);
  ## Check that data was returned
  if(length(j)==0){stop("no sample data returned from server")}
  # Turn list into data.frame 
  out  <- toDataFrame(j);
  return(out)
}
#' Retrieves Benthic data from the server 
#' @export
#' @description 
#' Returns a dataframe of benthic data per secondary sampling 
#' unit for the provided year and region
#' @inheritParams rvcData
getBenthicData  <- function(year, region, stratum = NULL, 
                              server = "http://www.sefsc.noaa.gov/rvc_analysis/"){
  # Reformat parameters
  region = toupper(region);
  stratum = if(!is.null(stratum)){
    toupper(stratum);
  }
  
  # Put together URL and request
  url  <- paste(server, '/api/benthic.json', 
                toQuery(year = year, region = region,
                        stratum = stratum),
                sep='');
  
  # Get data and convert JSON to list, 
  # if not connected return error
  j  <- getData(url);
  ## Check that data was returned
  if(length(j)==0){stop("no benthic data returned from server")}
  # Turn list into data.frame 
  out  <- toDataFrame(j);
  return(out)
}
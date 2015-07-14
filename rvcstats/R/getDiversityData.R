#' Retrieves Diversity data from the server 
#' @export
#' @description 
#' Returns a dataframe of species richness data per secondary sampling 
#' unit for the provided year and region
#' @inheritParams rvcData
getDiversityData  <- function(year, region, stratum = NULL, 
                            server = "http://localhost:3000"){
  # Reformat parameters
  region = toupper(region);
  stratum = if(!is.null(stratum)){
    toupper(stratum);
  }
  
  # Put together URL and request
  url  <- paste(server, '/api/diversities.json', 
                toQuery(year = year, region = region,
                        stratum = stratum),
                sep='');
  
  # Get data and convert JSON to list, 
  # if not connected return error
  message("starting to retrieve data from server, this could
          take a few minutes ... ")
  j  <- getData(url);
  message("... completed retrieving data")
  ## Check that data was returned
  if(length(j)==0){stop("no diversity data returned from server")}
  # Turn list into data.frame 
  out  <- toDataFrame(j);
  return(out)
}
getStratumData  <- function(year, region, stratum=NULL,
                               protected=NULL, server) {                     
 # Put together URL and request
  url  <- paste(server, '/api/strats.json', 
                toQuery(year = year, region = region,
                         strat = stratum, prot = protected),
                sep='');
  # Get data and convert JSON to list
  j  <- RJSONIO::fromJSON(RCurl::getURL(url));
  # Turn list into data.frame 
  out  <- do.call(rbind, lapply(j, as.data.frame));
  return(out)
}
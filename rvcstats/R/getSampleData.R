## Returns: A data frame of the sample data given a set of parameters
## species, year, region, stratum, protected, and when_present
.getSampleData  <- function(species, year, region, stratum,
                           protected, when_present, 
                           server){
  # Put together URL and request
  url  <- paste(server, '/api/samples.json', 
          .toQuery(species = species, year = year, region = region,
                   stratum = stratum, prot = protected, 
                   present = when_present),
          sep='');
  # Get data and convert JSON to list
  j  <- RJSONIO::fromJSON(RCurl::getURL(url));
  # Turn list into data.frame 
  out  <- do.call(rbind, lapply(j, as.data.frame));
  return(out)
}
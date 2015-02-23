## Helper: Retrieve a URL from server, spit out error if connection 
## refused
getData  <- function(url){
  # Try to get data from server, if not connected, return 
  # error
  data  <- tryCatch(
    {RCurl::getURL(url)},
           error = function(cond){
             message("the following error occurred:")
             message(cond)
             stop("make sure you are connected to the server and try again")
           }
    );
  # Return data as a list
  return(RJSONIO::fromJSON(data));
}
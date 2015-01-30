## Returns: A string in CGI query format given
## A set of parameters and values belonging to 
## those parameters
toQuery <- function(...){
  # Get the parameters as a list
  dots  <- list(...);
  # Get the names of the parameters
  n = names(dots);
  # Make each parameter value pair into a string of the form
  # par[]=value
  # TODO replace this with an apply function
  p  <- NULL;
  for (i in seq_along(dots)){
    for (j in seq_along(dots[[i]])){
      p = c(p, paste(n[i], dots[[i]][j], sep='[]='))
    }
  }
  #Put all the parameter value pairs into one string 
  # seperated by ampersands, and replace all spaces with plus signs
  out <- gsub(' ','+',paste('?',paste(p, collapse='&'), sep=''))
  return(out)
}
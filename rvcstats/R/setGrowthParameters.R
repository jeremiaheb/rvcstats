## Helper: sets growth parameters if not provided
## Takes an RVC object x and a list of growth_parameters
## Returns: the original gps if not NULL, or the appropriate gps from
## the RVC object if NULL
setGrowthParameters  <- function(x, growth_parameters){
  # And no growth parameters are provided
  # try to pull growth parameters off of the server
  if (is.null(growth_parameters)){
    a = x$lhp_data[["WLEN_A"]];
    b = x$lhp_data[["WLEN_B"]];
    if (isBlank(a) | isBlank(b)){
      stop("growth parameters not found, please enter them manually")
    } else{
      growth_parameters  <- list(a = a, b = b);
    }
  }
  return(growth_parameters)
}

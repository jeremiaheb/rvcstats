#' Calculates the optimal number of secondary sample units per stratum
#' @export
#' @description 
#' Calculates the optimal number of secondary sample units per
#' primary sample unit per stratum
#' 
#' @inheritParams domainNStar
#' 
#' @seealso \code{\link{domainNStar}} \code{\link{stratNStar}}
mStar  <- function(rvcObj){
  ## Get stratum data
  s  <- strat(rvcObj, calc = "d");
  ## Calculate mstar
  s$mstar  <- with(s, sqrt(v2)/s);
  s$mstar[is.nan(s$mstar)]  <- 0;
  ## Return
  return(s)
}
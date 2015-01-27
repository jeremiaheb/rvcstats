mStar  <- function(rvcObj){
  ## Get stratum data
  s  <- strat(rvcObj, calc = "d");
  ## Calculate mstar
  s$mstar  <- with(s, sqrt(v2)/s);
  s$mstar[is.nan(s$mstar)]  <- 0;
  ## Return
  return(s)
}
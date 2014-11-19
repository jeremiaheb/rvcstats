#' The optimal number of primary sampling units
#' @export
#' @description Outputs a data.frame of the optimal
#' number of primary sampling units per sampling domain
#' (n*)
#' @param cv 
#' A single integer representing the target coefficient variance
#' as a percent
#' @inheritParams strat
domainNStar  <- function(cv, rvcObj){
  ## Get stratum level estimates of density
  strat  <- strat(rvcObj, calc = "d");
  ## Split data by year, species
  spl  <- split(strat, strat[c("SPECIES_CD","YEAR")]);
  # Function to calculate nstar
  nstar  <- function(x){
    ## Pull out parts to use in function
    s <- sqrt(x$vbar); v1  <- x$v1; v2  <- x$v2;
    wh  <- x$wh; N  <- x$NTOT; mu  <- x$yi
    ## Calculate commonly used sums
    whs  <- sum(wh*s);
    ## Fix /0 problem
    wss  <- wh*v2/(2*s);
    wss[is.nan(wss)]  <- 0;
    ## Function to calculate nstar
    ns  <- whs*(whs + sum(wss))/((cv/100)^2*sum(wh*mu)^2 + sum(wh^2*v1/N));
    ns  <- ceiling(ns);
    ## Get the species and year of this current iteration
    spc  <- x$SPECIES_CD[1];
    yr  <- x$YEAR[1];
    ## Return data.frame with species, year, nstar
    return(data.frame(SPECIES_CD = spc, YEAR = yr, nstar = ns))
  }
  # Apply function to split data
  l  <- lapply(spl, nstar);
  ## Rbind the pieces back together
  out  <- NULL
  for (i in seq_along(l)){
    out <- rbind(out, l[[i]])
  }
  return(out)
  ## TODO: Restructure code so it is a bit more elegant
  ## TODO: Allow for a vector of CVs
} 
#' The optimal number of primary sampling units
#' @export
#' @description Outputs a data.frame of the optimal
#' number of primary sampling units per sampling domain
#' (n*)
#' @param cv 
#' The coefficient of variance as a percent
#' @inheritParams strat
domainNStar  <- function(cv, rvcObj){
  ## Get stratum level estimates of density
  strat  <- strat(rvcObj, calc = "d");
  ## split by year, species
  ## calculate nstar for each year, species
  ## unsplit and return
} 
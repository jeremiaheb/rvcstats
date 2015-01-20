#' Domain level estimates of density/occurrence
#' @export
#' @description Outputs the domain level estimates of density or 
#' occurrence given an RVC object
#' @inheritParams strat
#' @return A data.frame with the species, year, and stratum 
#' information as well as:
#' \item{yi}{The average density/occurrence}
#' \item{variance}{The variance in density/occurrence}
#' \item{se}{The standard error of density/occurrence}
#' \item{cv}{The coeficient of variation (as a percent) in density/occurrence}
#' \item{n}{The total number of primary samples per sampling domain}
#' \item{nm}{The total number of secondary samples per sampling domain}
#' \item{NMTOT}{The total possible number of secondary samples per sampling domain}
#' @seealso \code{\link{rvcData}} \code{\link{strat}}
domain  <-  function(rvcObj, calc = "d"){
  strat  <-  strat(rvcObj, calc)
  
  ## Select aggregate by variables
  agg_by  <- c("SPECIES_CD", "YEAR");
  ## If merge_protected is FALSE, add to agg_by vars
  if (!attr(rvcObj, "merge_protected")){
    agg_by  <- c(agg_by, "PROT")
  }
  agg_by = as.list(strat[agg_by])
  ## Calculate density/occurrence, variance, SE, CV, and nm
  domain = with(strat, aggregate(list(yi = wh*yi), by = agg_by, FUN = sum))
  domain$variance = with(strat, aggregate(wh^2*vbar, by = agg_by, FUN = sum)$x)
  domain$se = sqrt(domain$variance)
  domain$cv = with(domain, (se/yi)*100)
  domain$n = with(strat, aggregate(n, by = agg_by, FUN = sum)$x)
  domain$nm = with(strat, aggregate(nm, by = agg_by, FUN = sum)$x)
  domain$NMTOT = with(strat, aggregate(NMTOT, by = agg_by, FUN = sum)$x)
  
  return(domain)
}
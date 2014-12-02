#' Calculates stratum level indices of abundance
#' @export
#' @description Calculates the stratum level index of abundance
#' based on the density per secondary sample unit, and the number
#' of possible secondary sampling units per stratum. 
#' @inheritParams strat
#' @note
#' Indices of abundance produced by this function assume 
#' homogeneity of density within strata, and should not be 
#' used naively for assessment.
#' @return A data.frame with 
#' \item{wh}{The weighting factor for a particular stratum}
#'  \item{yt}{The average abundance in each stratum}
#'  \item{vbar}{Variance in mean abundance in each stratum}
#'  @seealso \code{\link{rvcData}} \code{\link{strat}} \code{\link{domainAbun}}
stratAbun  <- function(r){
  s  <- strat(r, calc = "d")
  out  <- s[names(s) %in% c("SPECIES_CD", "YEAR", "PROT", "STRAT")];
  out$yt  <- with(s, round(yi*NMTOT,0));
  out$vbar  <- with(s, NMTOT^2*vbar);
  return(out)
}
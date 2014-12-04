#' Calculate sampling domain level index of abundance
#' @export
#' @description Calculates domain level indices of abundance
#' based on the density per secondary sampling unit, and the 
#' number of sampling units throughout the domain
#' @inheritParams strat
#' @return A data.frame with the species, year, and protected
#' status (if applicable) as well as
#' \item{yt}{Index of abundance}
#' \item{vbar}{The variance associated with the abundance}
#' \item{se}{Standard error associated with the abundance}
#' @seealso \code{\link{rvcData}} \code{\link{stratAbun}} \code{\link{domain}}
domainAbun  <- function(rvcObj){
  s  <- stratAbun(rvcObj);
  ## Aggregate by Year and protected status (if applicable)
  ## and calculate index of abundance and variance
  d  <- with(
    s,
    aggregate(
      list(yt = yt, vbar = vbar),
      by = as.list(s[names(s) %in% c("SPECIES_CD", "YEAR", "PROT")]),
      FUN = sum
                   )
    );
  ## Calculate SE
  d$se  <- sqrt(d$vbar);
  return(d)
}
#' Calculate occurrence of fish species at the sampling domain
#' level
#' @export
#' @description
#' Returns a data.frame with the sampling domain level occurrence (per 177m^2)
#' for the given species, years, and strata
#' @inheritParams rvcData
#' @inheritParams domain
#' @return A data.frame with the average occurrence, sample variance, standard error (se), 
#' and coefficient of variance (cv), number of samples (nm), and number
#' of possible samples (NMTOT) per species, per year
#' @note This is a higher level version of the \code{\link{domain}} 
#' function
#' @seealso \code{\link{domain}} \code{\link{stratOccurrence}} \code{\link{domainDensity}}
domainOccurrence  <- function(sample_data, stratum_data,
                           species, years = "all",
                           strata = "all", includes_protected = FALSE){
  r  <- rvcData(sample_data = sample_data, stratum_data = stratum_data, 
                species, years = years,
                strata = strata, 
                includes_protected = includes_protected);
  d  <- domain(r, calc = "p");
  names(d)[names(d)=="yi"]  <- "occurrence";
  return(d)
}
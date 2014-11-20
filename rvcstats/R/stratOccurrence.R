#' Calculate occurrence of fish at the stratum level
#' @export
#' @description 
#' Returns a data.frame with the stratum level average occurrence (per 176m^2),
#' for the given species per species per year
#' @inheritParams domainOccurrence
#' @return A data.frame with the average occurrence, sample variance,
#' number of primary sample units (n), number of secondary sample units (nm),
#' number of possible primary sample units (NTOT), and number of possible
#' secondary sample units (NMTOT)
#' @note A higher level version of the \code{\link{strat}} function
#' @seealso \code{\link{domainOccurrence}} \code{\link{strat}} \code{\link{stratDensity}}
stratOccurrence  <- function(sample_data, stratum_data, species,
                          years = "all", strata = "all",
                          includes_protected = FALSE){
  r  <- rvcData(sample_data = sample_data, 
                stratum_data = stratum_data,
                species = species, years = years,
                strata = strata, 
                includes_protected = includes_protected);
  s  <- strat(r, calc = "p");
  
  out  <- s[names(s) %in% c("SPECIES_CD", "YEAR", "PROT", "STRAT", "NTOT", "NMTOT",
                           "yi", "n", "nm", "vbar")]
  names(out)[names(out) == "yi"]  <- "occurrence";
  names(out)[names(out) == "vbar"]  <- "variance";
  return(out)
}
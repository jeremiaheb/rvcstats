#' Calculate density of fish at the stratum level
#' @export
#' @description 
#' Returns a data.frame with the stratum level average densities (per 176m^2),
#' for the given species per species per year
#' @inheritParams domainDensity
#' @return A data.frame with the average density, sample variance,
#' number of primary sample units (n), number of secondary sample units (nm),
#' number of possible primary sample units (NTOT), and number of possible
#' secondary sample units (NMTOT)
#' @note A higher level version of the \code{\link{strat}} function
#' @seealso \code{\link{domainDensity}} \code{\link{strat}}
stratDensity  <- function(sample_data, stratum_data, species,
                          years = "all", strata = "all",
                          includes_protected = FALSE){
  r  <- rvcData(sample_data = sample_data, 
                stratum_data = stratum_data,
                species = species, years = years,
                strata = strata, 
                includes_protected = includes_protected);
  s  <- strat(r, calc = "d");
  
  out  <- s[names(s) %in% c("SPECIES_CD", "YEAR", "PROT", "STRAT", "NTOT", "NMTOT",
                           "yi", "n", "nm", "vbar")]
  names(out)[names(out) == "yi"]  <- "density";
  names(out)[names(out) == "vbar"]  <- "variance";
  return(out)
}
#' Returns summary statistics 
#' @export
#' @description Returns summary statistic 'stat' at level 'level' 
#' for RVC object x
#' @inheritParams select
#' @param level
#' Keyword, either "stratum" or "domain" indicating at which level the 
#' summary statistic should be calculated
#' @param stat
#' Keyword, indicating which summary statistic to calculate. Options are
#' "density", "occurrence", "abundance", "length_frequency", and "biomass"
#' @param growth_parameters
#' Optional: a list of allometric growth parameters named a (the linear coefficient)
#'  and b (the exponent)
#'  @param ...
#'  Optional parameters to pass to the select method (see \code{\link{select}})
#'  @return A data frame of the summary statistics
#'  @seealso \code{\link{rvcData}} \code{\link{select}}
getStat  <- function(x=NULL, level, stat, growth_parameters = NULL, ...){
  # Select based on option, if neccessary
  x = select(x, ...)
  # If level == "stratum" use stratum level functions
  # if level == "domain" use domain level functions
  # else return error
  if (level == "stratum"){
    # Use the appropriate function given the stat selected
    switch(stat,
           density = strat(x, stat),
           occurrence = strat(x, occurrence),
           length_frequency = stratLenFreq(x),
           abundance = stratAbun(x),
           biomass = NULL
           )
  } else if (level == "domain") {
    switch(stat,
           density = domain(x, stat),
           occurrence = domain(x, stat),
           length_frequency = domainLenFreq(x),
           abundance = domainAbun(x),
           biomass = NULL
           )
  } else {stop("level must be 'stratum' or 'domain'")}
}
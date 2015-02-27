#' Returns summary statistics
#' @export
#' @description Returns a data.frame of summary statistics given an RVC object
#' @inheritParams select
#' @param level
#' Keyword: either "stratum" or "domain" indicating at which level the 
#' summary statistic should be calculated
#' @param stat
#' Keyword: indicating which summary statistic to calculate. Options are
#' "density", "occurrence", "abundance", "length_frequency", and "biomass"
#' @param growth_parameters
#'  A list of allometric growth parameters named 'a' (the linear coefficient)
#'  and 'b' (the exponent).
#'  If no growth parameters are provided (NULL), 
#'  function will attempt to retrieve them from RVC object.
#'  \strong{NOTE:} Units for growth parameters are in mm not cm 
#' @param merge_protected
#'  Boolean: Indicates whether protected and unprotected areas are merged together in calculating
#'  the statistic. Default value is FALSE. 
#' @param when_present
#'  Boolean: Indicates whether statistic is to be calculated for non-zero data, when the species
#'  was present. NOTE: Can only be used for density and with only one species. 
#' @param length_class
#'  Number or Keyword: indicating a break point between two length classes, such as the breakpoint between 
#'  immature and mature individuals or non-exploitable and exploitable individuals. The recognized
#'  keywords are "LM" for median length-at-maturity and "LC" for minimum length-at-capture. If keywords
#'  are provided, getStat will attempt to retrieve the breakpoint values from the RVC object, otherwise it will
#'  use the provided breakpoint. 
#'  Break is non-inclusive for the lower interval and inclusive for the upper (i.e. lower > break >= upper).
#' @param ...
#'  Optional parameters to pass to the select method (see \code{\link{select}})
#' @return Returns: a data frame of the summary statistics
#' @examples
#' x  <- rvcData(species = 'EPI MORI', year = 2012, region = 'FLA KEYS')
#' ## Calculate Domain-Level Density
#' getStat(x, level = "domain", stat = "density")
#' ## Calculate Stratum Level biomass 
#' ## merging both protected and unprotected areas
#' getStat(x, level = "stratum", stat = "biomass",
#'  growth_parameters = list(a = 0.061, b = 2.2),
#'  merge_protected = TRUE)
#'## Calculate domain level density for individuals above and below 
#'## 40cm
#'getStat(x, level = "domain", stat = "density", length_class = 40)
#' @seealso \code{\link{rvcData}} \code{\link{select}}
getStat  <- function(x, level, stat, growth_parameters = NULL, merge_protected = FALSE, when_present = FALSE,
                     length_class = NULL, ...){
  # Make sure stat is valid
  if(!any(stat %in% c("abundance", "biomass", "density",
                     "occurrence", "length_frequency"))){
    stop('stat must be one of the following: "abundance", "biomass", "density",
                     "occurrence", "length_frequency"')
  }
  # Select based on option, if neccessary
  x  <- select(x, ...);
  # if stat is biomass...  
  if (stat == "biomass"){
    # Make sure only one species present
    if (!hasOneSpecies(x$sample_data)){
      stop("only one species can be selected if stat='biomass'");
    }
    # And no growth parameters are provided
    # try to pull growth parameters off of the server
    if (is.null(growth_parameters)){
      a = x$lhp_data$WLEN_A;
      b = x$lhp_data$WLEN_B;
      if (isBlank(a) | isBlank(b)){
        stop("growth parameters not found, please enter them manually")
      } else{
      growth_parameters  <- list(a = a, b = b);
      }
    }
  }
  # If when_present, check that stat=="density", only one species and 
  # and subset by NUM > 0
  if (when_present){
    # Check that stat == "density
    if (!any(stat %in% c("density", "abundance"))){
      stop("stat must be 'density' or 'abundance' if
           when_present is TRUE")
    }
    # Check that there is only one species
    if (!hasOneSpecies(x$sample_data)){
      stop("only one species can be selected if when_present is TRUE")
    }
    # Subset by when_present
    x$sample_data  <- subset(x$sample_data, NUM > 0);
  }
  # If length_class, add length_class and run once on each
  if (!is.null(length_class)){
    return(lengthClass(x, length_class, level, stat, growth_parameters,
                merge_protected, when_present));
  }
  # If level == "stratum" use stratum level functions
  # if level == "domain" use domain level functions
  # else return error
  if (level == "stratum"){
    out  <- strat(x, stat, growth_parameters, merge_protected);
  } else if (level == "domain") {
    out  <- domain(x, stat, growth_parameters, merge_protected, when_present)
  } else {stop("level must be 'stratum' or 'domain'")}
  # Set name and return
  names(out)[names(out) == "yi"] = stat;
  return(out)
}
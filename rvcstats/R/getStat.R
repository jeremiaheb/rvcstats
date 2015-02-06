#' Returns summary statistics 
#' @export
#' @description Returns summary statistic 'stat' at level 'level' 
#' for RVC object 'x'
#' @inheritParams select
#' @param level
#' Keyword, either "stratum" or "domain" indicating at which level the 
#' summary statistic should be calculated
#' @param stat
#' Keyword, indicating which summary statistic to calculate. Options are
#' "density", "occurrence", "abundance", "length_frequency", and "biomass"
#' @param growth_parameters
#'  A list of allometric growth parameters named a (the linear coefficient)
#'  and b (the exponent). Only needed if stat = "biomass". Defualt value is NULL
#'  @param merge_protected
#'  Boolean: Indicates whether protected and unprotected areas are merged together in calculating
#'  the statistic. Default value is FALSE. 
#'  @param when_present
#'  Boolean: Indicates whether statistic is to be calculated for non-zero data, when the species
#'  was present. NOTE: Can only be used for density and with only one species. 
#'  @param length_class
#'  Number: A breakpoint indiating the length about which to calculate the statistic.  
#'  @param ...
#'  Optional parameters to pass to the select method (see \code{\link{select}})
#'  @return A data frame of the summary statistics
#'  @seealso \code{\link{rvcData}} \code{\link{select}}
getStat  <- function(x, level, stat, growth_parameters = NULL, merge_protected = FALSE, when_present = FALSE,
                     length_class = NULL, ...){
  # Select based on option, if neccessary
  x  <- select(x, ...);
  # If when_present, check that stat=="density", only one species and 
  # and subset by NUM > 0
  if (when_present){
    # Check that stat == "density
    if (stat != "density"){
      stop("stat must be 'density' if when_present is TRUE")
    }
    # Check that there is only one species
    if (length(unique(x$sample_data$SPECIES_CD)) != 1){
      stop("only one species can be selected if when_present is TRUE")
    }
    # Subset by when_present
    x <- onlyPresent(x);
  }
  # If length_class, add length_class and run once on each
  if (!is.null(length_class)){
    # Check that there is only one species
    if (length(unique(x$sample_data$SPECIES_CD)) != 1){
      stop("only one species can be selected if length_class != NULL")
    }
    lwr  <- x;
    upr  <- x;
    lwr$sample_data$NUM  <- with(x$sample_data, ifelse(LEN < length_class, NUM, 0));
    upr$sample_data$NUM  <- with(x$sample_data, ifelse(LEN >= length_class, NUM, 0));
    l  <- list(lwr, upr);
    lout  <- lapply(l, function(z){
      getStat(z, level, stat, growth_parameters, merge_protected,
              when_present, length_class = NULL)
      });
    lout[[1]]$length_class  <- rep(paste("<", length_class, sep = ""), 
                                nrow(lout[[1]]));
    lout[[2]]$length_class  <- rep(paste(">=", length_class, sep = ""), 
                                nrow(lout[[2]]));
    out  <- do.call(rbind, lout)
    return(out)
  }
  # If level == "stratum" use stratum level functions
  # if level == "domain" use domain level functions
  # else return error
  if (level == "stratum"){
    return(strat(x, stat, growth_paramters, merge_protected));
  } else if (level == "domain") {
    return(domain(x, stat, growth_parameters, merge_protected, when_present))
  } else {stop("level must be 'stratum' or 'domain'")}
}
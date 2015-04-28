#' Summary Statistics for RVC data
#' @description Returns a data.frame of summary statistics given an RVC object
#' @export
#' @inheritParams select
#' @param level
#' Keyword: either "stratum" or "domain" indicating at which level the 
#' summary statistic should be calculated
#' @param stat
#' Keyword: indicating which summary statistic to calculate. Options are
#' "density", "occurrence", "abundance", "length_frequency", and "biomass"
#' @param growth_parameters \cr
#' \describe{
#'    \item{If x contains a single species:}{
#'    A list of allometric growth parameters named 'a' (the linear coefficient)
#'    and 'b' (the exponent).
#'    If no growth parameters are provided (NULL), 
#'    function will attempt to retrieve them from RVC object.}
#'    \item{If x contains multiple species:}{
#'    A list of lists, with each key a species code with underscores instead of spaces and 
#'    each value a list of growth parameters in the same format as for a single species. \cr 
#'    e.g. \code{growth_parameters = list(EPI_MORI = list(a=1.2e-5, b=2.88), MYC_BONA = list(a=1.88e-5, b=3))}. \cr
#'    If a species is not listed or value is NULL, function will attempt to retrieve growth_parameters
#'    from RVC object.}
#'  }
#'  \strong{NOTE:} Argument format is dependent on number of species in RVC object x. If
#'  x contains multiple species, but only one species is selected via the optional ... parameter
#'  the multispecies form must still be used. Also, multispecies form cannot be used for
#'  single species.  \cr 
#'  \strong{NOTE:} Units for growth parameters are in mm not cm 
#' @param merge_protected
#'  Boolean: Indicates whether protected and unprotected areas are merged together in calculating
#'  the statistic. Default value is TRUE. 
#' @param when_present
#'  Boolean: Indicates whether statistic is to be calculated for non-zero data, when the species
#'  was present. 
#' @param length_class \cr
#' \describe{
#'  \item{If x contains a single species:}{
#'    Number or Keyword: indicating a break point between two length classes, such as the breakpoint between 
#'    immature and mature individuals or non-exploitable and exploitable individuals. The recognized
#'    keywords are "LM" for median length-at-maturity and "LC" for minimum length-at-capture. If keywords
#'    are provided, getStat will attempt to retrieve the breakpoint values from the RVC object, otherwise it will
#'    use the provided breakpoint. }
#'    \item{if x contains multiple species}{
#'    A list, with each key a species code with underscores instead of spaces and 
#'    each value a number or keyword in the same format as for a single species. \cr 
#'    e.g. \code{length_class = list(EPI_MORI = "LC", MYC_BONA = 62)}. \cr
#'    If a species is not listed or value is NULL, function will calculate statistic for
#'    all length classes combined.
#'    }
#'  }
#'    \strong{NOTE:} Break is non-inclusive for the lower interval and inclusive for the upper (i.e. lower > break >= upper).
#' @param bin_width
#' A number indicating the width of each length bin is stat="length_frequency".
#' If NULL (default) lengths will not be binned. \cr 
#' \strong{NOTE:} In output, bins will be labelled by their midpoints.
#' @param ...
#'  Optional parameters to pass to the select method (see \code{\link{select}})
#' @return Returns: a data frame of the summary statistics
#' @examples
#' x  <- rvcData(species = 'EPI MORI', year = 2012, region = 'FLA KEYS')
#' ## Calculate Domain-Level Density
#' getStat(x, level = "domain", stat = "density")
#' ## Calculate Stratum Level biomass 
#' ## with protected and unprotected areas listed separately
#' getStat(x, level = "stratum", stat = "biomass",
#'  growth_parameters = list(a = 0.061, b = 2.2),
#'  merge_protected = FALSE)
#'## Calculate domain level density for individuals above and below 
#'## 40cm
#'getStat(x, level = "domain", stat = "density", length_class = 40)
#' @seealso \code{\link{rvcData}} \code{\link{select}}
getStat  <- function(x, level, stat, growth_parameters = NULL, merge_protected = TRUE, when_present = FALSE,
                            length_class = NULL, bin_width = NULL, ...){
  # Make sure stat is valid
  if(!any(stat %in% c("abundance", "biomass", "density",
                      "occurrence", "length_frequency"))){
    stop('stat must be one of the following: "abundance", "biomass", "density",
                     "occurrence", "length_frequency"')
  }
  # Select based on option, if neccessary
  x  <- select(x, ...)
  ## Set up output
  out  <- NULL;
  ## If x has only one species or (stat != biomass & length_class == NULL
  ## and when_present == FALSE) do single species case
  ## else do multispecies
  if ((stat!="biomass" & is.null(length_class) & !when_present) | hasOneSpecies(x$sample_data)){
    out  <- getStatSingle(x, level, stat, growth_parameters, merge_protected, when_present,
            length_class, ...);
  } else {
    ## Make a list of species
    species_list  <- as.character(unique(x$sample_data$SPECIES_CD));
    ## Make names of growth_parameters and length_class uppercase
    if(!is.null(length_class)){
      names(length_class)  <- toupper(names(length_class));
      if (!is.list(length_class)){stop("length_class must be a list")}
    }
    if(!is.null(growth_parameters)){
      names(growth_parameters)  <- toupper(names(growth_parameters));
      if (!is.list(growth_parameters)){stop("growth_parameters must be a list")}
      if(!(all(species_list %in% gsub("_"," ", names(growth_parameters))))){
        msg = paste("all species must be included in growth_parameters," ,
                    " see ?getStat for more information", sep = "")
        stop(msg)
      }
    }
    ## Run single species case for each species
    lout  <- list();
    for (i in seq_along(species_list)){
      ## Species name with underscore instead of space
      spc  <- gsub(" ","_", species_list[i]);
      ## Growth paramters for species i
      gp  <- growth_parameters[[spc]];
      ## Length class for species i
      lc  <- length_class[[spc]];
      ## The single-species case for species i
      lout[[i]]  <- getStatSingle(x, level, stat, growth_parameters = gp, merge_protected, when_present,
                          length_class = lc, species = species_list[i])
    }
    ## If length_class is in some but not all data.frames in lout, add to
    ## data frames where it is missing with "all" as the level
    has_length_class  <- unlist(lapply(lout, function(x){"length_class" %in% names(x)}));
    if (any(has_length_class) & !all(has_length_class)){
      lout[!has_length_class]  <- lapply(lout[!has_length_class], 
                                         function(x){cbind(x,length_class = rep("all",nrow(x)))})
    }
    ## Rbind all data.frames together and return
    out  <- do.call(rbind, lout);
  }
  ## Handle bin_width
  if (stat == "length_frequency" & !is.null(bin_width)){
    if (!is.numeric(bin_width) | length(bin_width)!=1){
      stop("bin width must be a number")
    }
    out  <- binnedLength(out, bin_width, level, merge_protected);
  }
  return(out)
}
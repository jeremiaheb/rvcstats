#' Creates a MAT object
#' @export
#' @description Creates a MAT object from RVC sample data and stratum data
#' @inheritParams rvcData
#' @param species 
#' A single species name
#' @param lm
#' Length-at-maturity for the given species
#' @param \dots
#' Optional arguments that can be passed to \code{\link{rvcData}}
#' @return A MAT object containing two RVC objects, one for mature individuals
#' and one for juveniles (see \code{\link{rvcData}} for more on RVC objects)
#' @seealso \code{\link{rvcData}}
maturityData  <- function(sample_data, stratum_data, species, lm,  ...){
  if (length(species) != 1){
    stop("species must contain exactly one species name");
  }
  if (length(lm) != 1){
    stop("lm must contain exactly one number")
  }
  # Create RVC objects for juveniles and adults
  j <- rvcData(sample_data, stratum_data, species, length_class = c(0, lm),...);
  m <- rvcData(sample_data, stratum_data, species, length_class = c(lm, Inf), ...);
  # Create MAT object
  out  <- list(m=m, j=j);
  class(out)  <- "MAT"
  return(out)
}
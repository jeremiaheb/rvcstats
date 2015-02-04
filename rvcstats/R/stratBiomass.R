#' @export
## Returns: Stratum level biomass given,
## x, a psu object, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
stratBiomass  <- function(x, merge_protected){
  ## Basically just a wrapper for stratAbundance
  ## Only here in case someone wants to expand upon it
  return(stratAbundance(x, merge_protected))
}
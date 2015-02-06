## Returns: Domain level biomass given,
## x, a data.frame of strat data, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
domainBiomass  <- function(x, merge_protected){
  ## A wrapper for abundance
  return(domainAbundance(x, merge_protected))
}
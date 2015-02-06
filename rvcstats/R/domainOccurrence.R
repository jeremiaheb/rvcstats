## Returns: Domain level density given,
## x, a data.frame of strat data, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
domainOccurrence  <- function(x, merge_protected){
  ## Just a wrapper for density
  return(domainDensity(x, merge_protected))
}
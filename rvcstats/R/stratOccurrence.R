## Returns: Stratum level occurrence given,
## x, a psu object, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
stratOccurrence  <- function(x, merge_protected){
  ## Basically just a wrapper for stratDensity
  ## Only here in case someone wants to expand upon it
  return(stratDensity(x, merge_protected));
}
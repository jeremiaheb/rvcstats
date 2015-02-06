## Returns: Stratum level abundance given,
## x, a psu object, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
stratAbundance  <- function(x, merge_protected){
  out  <- stratDensity(x, merge_protected);
  out$yi  <- with(out, round(yi*NMTOT,0));
  out$var  <- with(out, NMTOT^2*var);
  return(out)
}
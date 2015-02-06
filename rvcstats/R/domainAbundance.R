## Returns Domain level abundance estimates given,
## x, a data.frame of stratum-level estimates
## merge_protected, a boolean indicating whether
## protected and unportected areas should be merged together
domainAbundance  <- function(x, merge_protected){
  ## Arguments
  args1  <- alist(x = list(NTOT = NTOT, NMTOT = NMTOT, yi = yi, var = var, n = n, nm = nm),
                  aggBy("domain", "density", merge_protected),
                  FUN = sum);
  ## Evaluation
  out  <- with(x,do.call(aggregate, args1));
  return(out)
}
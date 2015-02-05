#' @export
## Returns: Domain level density given,
## x, a psu object, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
domainDensity  <- function(x, merge_protected){
  ## Arguments
  args1  <- alist(x = list(NTOT = NTOT), aggBy("domain", "density", merge_protected),
                  FUN = sum);
  args2  <- alist(x = list(NMTOT = NMTOT), aggBy("domain", "density", merge_protected),
                  FUN = sum);
  args3  <- alist(x = list(yi = weighted_yi), aggBy("domain", "density", merge_protected),
                  FUN = sum);
  args4  <- alist(x = list(var = weighted_var), aggBy("domain", "density", merge_protected),
                  FUN = sum);
  args5  <- alist(x = list(n = n), aggBy("domain", "density", merge_protected), 
                  FUN = sum);
  args6  <- alist(x = list(nm = nm), aggBy("domain", "density", merge_protected), 
                  FUN = sum);
  ## Evaluation
  weighted_yi  <- with(x, wh*yi);
  weighted_var  <- with(x, wh^2*var);
  out  <- with(x, do.call(aggregate, args1));
  out$NMTOT <- with(x, do.call(aggregate, args2)$NMTOT);
  out$yi <- with(x, do.call(aggregate, args3)$yi);
  out$var <- with(x, do.call(aggregate, args4)$var);
  out$n <- with(x, do.call(aggregate, args5)$n);
  out$nm <- with(x, do.call(aggregate, args6)$nm);
  
  return(out)
}
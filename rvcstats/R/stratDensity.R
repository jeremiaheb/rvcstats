#' @export
## Returns: Stratum level abundance given,
## x, a psu object, and
## merge_protected, a boolean indicating whether protected
## and unprotected areas should be merged together
stratDensity  <- function(x, merge_protected){
  
  # Set up arguments
  args1  <- alist(x = list(yi = yi), by = aggBy("stratum", "density", merge_protected),
                  FUN = mean);
  args2  <- alist(x = list(n=yi), by = aggBy("stratum", "density", merge_protected),
                  FUN = length);
  args3  <- alist(x = list(nm=m), by = aggBy("stratum", "density", merge_protected),
                  FUN = sum);
  args4  <- alist(x = list(v1 = yi), by = aggBy("stratum", "density", merge_protected),
                  FUN = function(x){var(x, na.rm = TRUE)});
  args5  <- alist(x = list(np = m), by = aggBy("stratum", "density", merge_protected),
                  FUN = function(x){sum(ifelse(x>1,1,0))});
  args6  <- alist(x = list(mbar = m), by = aggBy("stratum", "density", merge_protected),
                  FUN = mean);
  args7  <- alist(x = list(v2 = var), by = aggBy("stratum", "density", merge_protected),
                  FUN = function(x){sum(x, na.rm = TRUE)});
  
  #Evaluations
  # Density
  out  <- with(x$sample_data, do.call(aggregate, args1));
  # Get stratum_data from x
  stratum_data  <- x$stratum_data
  # If merge protected is TRUE, merge protected and unprotected NTOTs
  if (merge_protected){
    stratum_data  <- aggregate(NTOT ~ YEAR + REGION + STRAT + GRID_SIZE,
                               data = stratum_data, FUN = sum)
  }
  # Merge
  out  <- merge(stratum_data, out);
  # n
  n  <- with(x$sample_data, do.call(aggregate, args2)$n);
  #nm 
  nm  <- with(x$sample_data, do.call(aggregate, args3)$nm);
  # Variance
  #v1 - Between PSU variance 
  v1  <- with(x$sample_data,do.call(aggregate, args4)$v1);
  #np - Number of replicates 
  np  <- with(x$sample_data,do.call(aggregate, args5)$np);
  #mbar - Average number of SSUs per PSU
  mbar  <- with(x$sample_data, do.call(aggregate, args6)$mbar);
  #v2 - Between SSU variance
  v2  <- with(x$sample_data,do.call(aggregate, args7)$v2/np);
  #var - Overall Variance 
  MTOT  <- with(out, round(GRID_SIZE^2/(pi*7.5^2),0));
  fn  <- with(out, n/NTOT);
  fm  <- with(out, mbar/MTOT);
  var  <- (1-fn)*v1/n+(fn*(1-fm)*v2)/nm;
  #NMTOT - Number of possible SSUs
  NMTOT  <- with(out, MTOT*NTOT);
  
  ## Append desired variables to output and return
  colN  <- which(names(out)=="NTOT"); #get index of NTOT column
  out  <- cbind(out[1:colN], NMTOT, out[(colN+1):ncol(out)], var, n, nm);
  return(out)
}
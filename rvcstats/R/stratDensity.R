## Returns: Stratum level density given,
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
  args7  <- alist(x = list(v2_s = var), by = aggBy("stratum", "density", merge_protected),
                  FUN = function(x){sum(x, na.rm = TRUE)});
  
  #Evaluations
  # Density
  temp  <- with(x$sample_data, do.call(aggregate, args1));
  # Get stratum_data from x
  stratum_data  <- x$stratum_data
  # If merge protected is TRUE, merge protected and unprotected NTOTs
  if (merge_protected){
    stratum_data  <- aggregate(NTOT ~ YEAR + REGION + STRAT + GRID_SIZE,
                               data = stratum_data, FUN = sum)
  }
  # Merge
  temp  <- merge(stratum_data, temp);
  # n
  n  <- with(x$sample_data, do.call(aggregate, args2));
  #nm 
  nm  <- with(x$sample_data, do.call(aggregate, args3));
  # Variance
  #v1 - Between PSU variance 
  v1  <- with(x$sample_data,do.call(aggregate, args4));
  #np - Number of replicates 
  np  <- with(x$sample_data,do.call(aggregate, args5));
  #mbar - Average number of SSUs per PSU
  mbar  <- with(x$sample_data, do.call(aggregate, args6));
  #v2 - Between SSU variance
  v2_s  <- with(x$sample_data,do.call(aggregate, args7));
  # Merge all the tables
  temp  <- Reduce(merge, list(temp, n, nm, mbar, np, v1, v2_s));
  # Calculate v2
  temp$v2  <- with(temp, ifelse(np != 0, v2_s/np, NA));
  #var - Overall Variance 
  MTOT  <- with(temp, round(GRID_SIZE^2/(pi*7.5^2),0));
  fn  <- with(temp, n/NTOT);
  fm  <- with(temp, mbar/MTOT);
  temp$var  <- with(temp, (1-fn)*v1/n+(fn*(1-fm)*v2)/nm);
  #NMTOT - Number of possible SSUs
  temp$NMTOT  <- with(temp, MTOT*NTOT);
  
  ## Fix the number and order of the variables
  vars  <- c("NMTOT","yi","var","n","nm");
  # Find which column is the NTOT column (before all the calculated vars)
  n  <- which(names(temp)=="NTOT");
  out  <- cbind(temp[1:n],temp[vars]);
  
  
  return(out)
}
#' Stratum level estimates of density/occurrence
#' @export
#' @description Outputs the stratum level estimates of
#' density or occurrence from an RVC object as a data.frame
#' @param rvcObj
#' An RVC object (see \code{\link{rvcData}})
#' @param calc
#' A character: 'd' to calculate density  estimates(default),
#'  or 'p' for occurrence estimates
#'  @return A data.frame containing the year, species, and stratum info as 
#'  well as:
#'  \item{wh}{The weighting factor for a particular stratum}
#'  \item{yi}{The average density/occurrence}
#'  \item{mbar}{The average number of secondary sample units per stratum}
#'  \item{n}{The number of primary sample units per stratum}
#'  \item{v1}{The variance between primary sample units in density/occurrence}
#'  \item{v2}{The stratum-level variance between secondary sample units in density/occurrence}
#'  \item{s}{Sample standard deviation of density/occurrence in each stratum}
#'  \item{vbar}{Variance in mean density/occurrence in each stratum}
#'  \item{nm}{The total number of secondary sample units per stratum}
#'  \item{NMTOT}{The total possible number of secondary samples per stratum}
#'  @seealso \code{\link{rvcData}} \code{\link{domain}}
strat <- function(rvcObj, calc = "d") {
  ## Calculate PSU densities/occurrences
  psu <- .psu(rvcObj, calc);
  ## Set the variables by which to aggregate
  agg_by <- c("SPECIES_CD", "YEAR", "STRAT");
  ## If includes_protected is TRUE add to
  ## aggregate by variables
  if (attr(rvcObj, "includes_protected")){
    agg_by  <- c(agg_by, "PROT");
  }
  ## Make agg_by into a list
  agg_by  <- as.list(psu[agg_by]);
  ## Calculate average density/occurrence
  samp <- aggregate(list(yi = psu$yi), by = agg_by, FUN = mean);
  ## Calculate mbar
  samp$mbar <- aggregate(psu$m, by = agg_by, FUN = mean)$x;
  ## Calculate n
  samp$n <- aggregate(psu$m, by = agg_by, FUN = length)$x;
  ## Calculate v1
  samp$v1 <- aggregate(psu$yi, by = agg_by, 
                       FUN = function(x){ifelse(is.na(var(x)),0,var(x))})$x;
  ## Calculate nm, v2, and np
  samp$nm <- aggregate(psu$m, by = agg_by, FUN = sum)$x;
  np <- aggregate(psu$np.freq, by = agg_by, FUN = sum)$x;
  v2 <- aggregate(psu$vari, by = agg_by, FUN = sum)$x;
  samp$v2 <- ifelse(np>0, v2/np, 0);
  rm(v2)
  
  ## Get stratum data
  strat  <- rvcObj$stratum_data;
  
  ## Merge strat and samp
  strat2 <- merge(strat, samp)
  
   ## Calculate MTOT
   MTOT <- with(strat2,round(GRID_SIZE^2/(pi*7.5^2), 0));
   ## Calculate variance weights, variance, and NMTOT
   fn <- with(strat2, n/NTOT);
   fm <- with(strat2, mbar/MTOT);
  strat2$s  <- with(strat2, sqrt(v1 - v2/MTOT));
  strat2$vbar <- with(strat2, ((1-fn)*v1/n)+((fn*(1-fm)*v2)/nm));
  strat2$NMTOT <- with(strat2, NTOT*MTOT);
  
return(strat2)
}
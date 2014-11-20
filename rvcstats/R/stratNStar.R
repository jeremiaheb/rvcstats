#' The optimal number of primary sampling units per stratum
#' @export
#' @description Outputs a data.frame the optimal number of sampling units 
#' per stratum for a given coeeficient of variance
#' @inheritParams domainNStar
#' @return A data.frame including the species code, year,
#' stratum, and nstar for the target cv
stratNStar  <- function(cv, rvcObj){
  ## Get domain nstar and stratum data
  d  <- domainNStar(cv, rvcObj);
  s  <- strat(rvcObj, calc = "d");
  ## merge d and s
  ds  <- merge(d,s);
  ## calculate stratum nstar weights
  swh  <- with(ds, wh*sqrt(vbar));
  sum_swh  <- aggregate(list(sum_swh = swh),
                        by = as.list(ds[c("SPECIES_CD","YEAR")]),
                        FUN = sum);
  ## Merge sum_swh with ds
  dsw  <- merge(ds, sum_swh);
  ## Calculate stratum nstar
  out  <- ds[c("SPECIES_CD", "YEAR", "STRAT")];
  out$nstar  <- with(dsw, round(nstar*(wh*sqrt(vbar)/sum_swh),0));
  return(out)
}
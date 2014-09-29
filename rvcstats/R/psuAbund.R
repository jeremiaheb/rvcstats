## Returns: the avg. counts, variance in counts, number of SSUs, and replicate status 
## (np.freq) for each PSU, given an RVC object
psuAbund = function(rvcObj){
  ## Check type
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC. Type ?rvcData for more information")
  }
  ## Convert rvc obj to list
  class(rvcObj) = "list"
  ## Set the variables by which to aggregate
  agg.by = rvcObj[names(rvcObj) %w/o% c("STATION_NR", "NUM")]
  ## Avg. counts by PSU
  psu = aggregate(rvcObj$NUM, by = agg.by, FUN = mean)
  names(psu)[length(names(psu))] = "avg.abun"
  ## Variance in counts by PSU
  psu$vari = aggregate(rvcObj$NUM, by = agg.by,
                      FUN = function(x){
                        ifelse(is.na(var(x)),0,var(x))
                      })$x
  ## Number of SSUs per PSU
  psu$m = aggregate(rvcObj$NUM, by = agg.by, FUN = length)$x
  ## Replicate status
  psu$np.freq = ifelse(psu$m>1,1,0)
  
  return(psu)
}
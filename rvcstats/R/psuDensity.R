## Returns: the avg. counts (dbar), variance in counts (vari), 
## number of SSUs (m), and replicate status (np.freq) for each PSU.
## Given an RVC object
.psuDensity = function(rvcObj){
  ## Check type
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC. Type ?rvcData for more information")
  }
  ## Convert rvc obj to list
  class(rvcObj) = "list"
  ## Set the variables by which to aggregate
  agg.by = rvcObj[names(rvcObj) %w/o% c("STATION_NR", "NUM")]
  
  ## Avg. counts in SSU by PSU
  psu = aggregate(rvcObj$NUM, by = agg.by, FUN = mean)
  names(psu)[length(names(psu))] = "dbar"
  
  ## Variance in counts of each SSU by PSU
  psu$vari = aggregate(rvcObj$NUM, by = agg.by,
                      FUN = function(x){
                        ifelse(is.na(var(x)),0,var(x))
                      })$x
  
  ## Number of SSUs per PSU
  psu$m = aggregate(rvcObj$STATION_NR, by = agg.by, FUN = max)$x
  
  ## Replicate status
  psu$np.freq = ifelse(psu$m>1,1,0)
  
  return(psu)
}
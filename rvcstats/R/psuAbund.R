## Returns: the avg. counts, variance in counts, number of SSUs, and replicate status 
## (np.freq) for each PSU, given an RVC object
psuAbund = function(rvcObj){
  ## Check type
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC. Type ?rvcData for more information")
  }
  ## Convert rvc obj to data.frame
  class(rvcObj) = "list"
  rvcObj = as.data.frame(rvcObj)
  ## Avg. counts by PSU
  psu = aggregate(NUM ~ SPECIES_CD + YEAR + STRAT + PRIMARY_SAMPLE_UNIT,
                  data = rvcObj, FUN = mean)
  names(psu)[length(names(psu))] = "avg.abun"
  ## Variance in counts by PSU
  psu$vari = aggregate(NUM ~ SPECIES_CD + YEAR + STRAT + PRIMARY_SAMPLE_UNIT,
                      data = rvcObj,
                      FUN = function(x){
                        ifelse(is.na(var(x)),0,var(x))
                      })$NUM
  ## Number of SSUs per PSU
  psu$m = aggregate(NUM ~ SPECIES_CD + YEAR + STRAT + PRIMARY_SAMPLE_UNIT,
                    data = rvcObj, FUN = length)$NUM
  ## Replicate status
  psu$np.freq = ifelse(psu$m>1,1,0)
  
  return(psu)
}
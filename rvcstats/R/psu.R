## Returns: the avg. counts or occurence (yi), 
## variance in counts or occurrence (vari), 
## number of SSUs (m), and replicate status (np.freq) for each PSU.
## Given an RVC object
.psu = function(rvcObj, calculate.density = TRUE){
  ## Check type
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC. Type ?rvcData for more information")
  }
  
  ## Convert rvc obj to list
  class(rvcObj) = "list"
  
  ## Set the variables by which to aggregate
  agg.by = rvcObj[names(rvcObj) %w/o% c("STATION_NR", "NUM")]
  
  ## Number of SSUs per PSU
  psu= aggregate(rvcObj$STATION_NR, by = agg.by, FUN = length)# these two functions
  ## should produce the same results, but they don't
  names(psu)[length(names(psu))] = "m"
  
  ## Change to discrete dist. if calculate.density is FALSE
  if (!calculate.density){
    rvcObj$NUM = ifelse(rvcObj$NUM > 0, 1, 0)
  }

  ## Avg. counts/occurence in SSU by PSU
  psu$yi = aggregate(rvcObj$NUM, by = agg.by, FUN = mean)$x
  
  ## If calculate density is TRUE calculate variance for 
  ## continuous distribution, else for binomial distribution
  if (calculate.density){
    ## Variance in counts of each SSU by PSU
    psu$vari = aggregate(rvcObj$NUM, by = agg.by,
                         FUN = function(x){
                           ifelse(is.na(var(x)),0,var(x))
                         })$x
    
  } else {
    psu$vari = ifelse(psu$m==1, 0, psu$m/(psu$m-1)*psu$yi*(1-psu$yi))
  }
  
  ## Replicate status
  psu$np.freq = ifelse(psu$m>1,1,0)
  
  return(psu)
}
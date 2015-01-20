## Returns the density or percent occurrence for the secondary sampling
## unit as a data.frame, given an RVC object and what should be 
## calculated
.ssu  <- function(rvcObj, calc = "d"){
  ## Check type
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC. Type ?rvcData for more information")
  }
  if (calc != "p" & calc != "d" ){
    stop("calc must be either 'p' to for occurrence or 'd' for density")
  }
  ## Set the variables by which to aggregate
  agg_by  <- c("SPECIES_CD", "REGION", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT",
               "STATION_NR");
  ## If merge_protected is false, add to agg_by vars
  if (!attr(rvcObj, "merge_protected")){
    agg_by  <- c(agg_by, "PROT");
  }
  ## If calc is 'p' change the function to be applied to aggregate
  ## to produce discrete variable
  if(calc == 'p'){
    f  <- function(x){ifelse(sum(x)>0,1,0)};
  } else {
    f  <- sum;
  }
  ## Aggregate and return data
  out  <- with(
    rvcObj,
    aggregate(list(yi = sample_data$NUM), by = as.list(sample_data[agg_by]),
              FUN = f)
    );
  return(out)
}
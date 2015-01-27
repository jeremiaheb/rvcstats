## Returns the density or percent occurrence for the secondary sampling
## unit as a data.frame, given an RVC object and what should be 
## calculated
.ssu  <- function(rvcObj, stat="density"){
  ## Check type
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC. Type ?rvcData for more information")
  }
  if (stat != "occurrence" & stat != "density" ){
    stop("stat must be either 'occurrence' to for occurrence or 'density' for density")
  }
  ## Set the variables by which to aggregate
  agg_by  <- c("SPECIES_CD", "REGION", "YEAR", "STRAT", "PRIMARY_SAMPLE_UNIT",
               "STATION_NR");
  ## If merge_protected is false, add to agg_by vars
  if (!attr(rvcObj, "merge_protected")){
    agg_by  <- c(agg_by, "PROT");
  }
  ## If stat is "occurrence" change the function to be applied to aggregate
  ## to produce discrete variable
  if(stat == "occurrence"){
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
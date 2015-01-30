## Returns: A list of the variables in the
## Anaylsis Ready data by which to aggregate
aggBy  <- function(level, stat, merge_protected=FALSE){
  # Starting list of all variables 
  # Uses alist instead of list so that the values are
  # not evaluated until later, see return statement
  agg_by  <- alist(YEAR, REGION, SPECIES_CD, STRAT, PRIMARY_SAMPLE_UNIT,
                   STATION_NR);
  # Set names same as symbols
  names(agg_by)  <- lapply(agg_by, toString);
  # Select subset of agg_by based on level
  agg_by  <- switch(level,
                    ssu = agg_by,
                    psu = agg_by[-6],
                    stratum = agg_by[-c(5:6)],
                    domain = agg_by[-c(4:6)]
                    );
  # Add PROT if merge_protected is FALSE
  if (!merge_protected){
    agg_by  <- c(agg_by, alist(PROT = PROT));
  }
  # Add LEN if stat is "length_frequency"
  if (stat == "length_frequency"){
    agg_by  <- c(agg_by, alist(LEN = LEN));
  }
  # Evaluate the alist items outside parent function
  #(i.e. outside aggBy)
  # requires all variables to be defined in that environment
  # This 'trick' means that I do not need to pass
  # any data to the aggBy function
  return(lapply(agg_by, eval.parent, n=2))
}
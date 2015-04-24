## Handles the single species case for getStat, can handle multi-species
## if stat != biomass, length_class == NULL, or when_present == FALSE
getStatSingle  <- function(x, level, stat, growth_parameters, merge_protected, when_present,
                     length_class, ...){
  # Handle ... argument with select function
  # suppress warnings already handled in getStat main function
  x  <- suppressWarnings(select(x, ...));
  # If stat is length_frequency or biomass, drop unlengthed fish (LEN == -9)
  if (stat == "length_frequency" | stat == "biomass"){
    x$sample_data  <- subset(x$sample_data, LEN >= 0);
  }
  # if stat is biomass set growth parameters appropriately
  if (stat == "biomass"){
    growth_parameters  <- setGrowthParameters(x, growth_parameters);
  }
  # If when_present subset by NUM > 0
  if (when_present){
    # Subset by when_present
    x$sample_data  <- subset(x$sample_data, NUM > 0);
  }
  # If length_class, add length_class and run once on each
  # else run base case
  if (!is.null(length_class)){
    out  <- lengthClass(x, length_class, level, stat, growth_parameters,
                merge_protected, when_present);
  } else {
    out  <- getStatBase(x, level, stat, growth_parameters,
                     merge_protected, when_present)
  }
  return(out)
}
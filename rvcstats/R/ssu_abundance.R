ssu_abundance  <- function(x, stat, merge_protected, growth_parameters){
  # Convernt NUM to biomass if stat is biomass
  if (stat == "biomass"){
    x  <- toBiomass(x, growth_parameters);
  }
  # Covert NUM to occurrence if stat is occurrence
  if (stat == "occurrence"){
    x  <- toOccurrence(x);
  }
  x$sample_data  <- aggregate(x, list(abundance = NUM), aggBy("ssu",stat));
  class(x)  <- "SSU";
  return(x)
}
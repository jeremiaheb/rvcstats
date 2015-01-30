#' @export
ssu  <- function(x, stat, merge_protected, growth_parameters){
  # Convernt NUM to biomass if stat is biomass
  if (stat == "biomass"){
    x  <- toBiomass(x, growth_parameters);
  }
  # Covert NUM to occurrence if stat is occurrence
  if (stat == "occurrence"){
    x  <- toOccurrence(x);
  }
  # Calculate statistic at the SSU level
  x$sample_data  <- with(x$sample_data, 
                         aggregate(list(yi = NUM), aggBy("ssu",stat), sum)
                         );
  class(x)  <- "SSU";
  return(x)
}
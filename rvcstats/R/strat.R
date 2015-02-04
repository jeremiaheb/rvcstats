#' @export
strat  <- function(x, stat, growth_parameters, merge_protected){
  # Get PSU data
  x  <- psu(x, stat, growth_parameters);
  # Set up cases
  x  <- switch(
    stat,
    density = stratDensity(x, merge_protected),
    occurrence = stratOccurrence(x, merge_protected),
    abundance = stratAbundance(x, merge_protected),
    length_frequency = stratLengthFrequency(x, merge_protected),
    biomass = stratBiomass(x, merge_protected)
    )
  return(x)
}
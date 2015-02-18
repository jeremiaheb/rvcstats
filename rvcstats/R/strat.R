## Returns domain-level summary statistics given,
## x, and rvc object
## stat, the requested statistics
## growth_parameters, a list of the allometric growth parameters
## a and b, if biomass is selected
## merge_protected, a boolean indicated whether protected
## and unprotected areas should be merged together
strat  <- function(x, stat, growth_parameters, merge_protected){
  # Get PSU data
  x  <- psu(x, stat, growth_parameters);
  # Set up cases
  out  <- switch(
    stat,
    density = stratDensity(x, merge_protected),
    occurrence = stratOccurrence(x, merge_protected),
    abundance = stratAbundance(x, merge_protected),
    length_frequency = stratLengthFrequency(x, merge_protected),
    biomass = stratBiomass(x, merge_protected)
    );
  if (stat != "length_frequency"){
    out  <- with(out,
                 aggregate(
                   list(NTOT = NTOT, NMTOT = NMTOT,
                        yi = yi, var = var, n = n, nm = nm),
                   by = aggBy("stratum", stat, merge_protected),
                   FUN = sum)
    );
  }
  return(out)
}
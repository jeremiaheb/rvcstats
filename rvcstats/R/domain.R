## Returns domain-level summary statistics given,
## x, and rvc object
## stat, the requested statistics
## growth_parameters, a list of the allometric growth parameters
## a and b, if biomass is selected
## merge_protected, a boolean indicated whether protected
## and unprotected areas should be merged together
## when_present, a boolean indicating whether statistic
## is to be calculated only when species is present
domain  <- function(x, stat, growth_parameters, merge_protected, when_present){
  x  <- strat(x, stat, growth_parameters, merge_protected=FALSE);
  x <- addWeighting(x, merge_protected, when_present);
  out  <- switch(
    stat,
    abundance = domainAbundance(x, merge_protected=FALSE),
    density = domainDensity(x, merge_protected=FALSE),
    occurrence = domainOccurrence(x, merge_protected=FALSE),
    length_frequency = domainLengthFrequency(x, merge_protected),
    biomass = domainAbundance(x, merge_protected=FALSE)
    );
  ## Merge protected and unprotected areas if relevent
  if (stat != "length_frequency"){
    out  <- with(out,
                 aggregate(
                   list(NTOT = NTOT, NMTOT = NMTOT,
                        yi = yi, var = var, n = n, nm = nm),
                   by = aggBy("domain", stat, merge_protected),
                   FUN = sum)
                 );
  }
  return(out)
}
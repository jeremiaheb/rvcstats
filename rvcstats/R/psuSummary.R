## Returns: data.frame with number of secondary samples (m), avg density (avg.dens),
## variance in density (s2), and if there was a replicate (rp: 1 if TRUE),
## for  species in given species, years, and strata, from
## provided sample.data
psuSummary = function(species, years, strata, sample.data, ssu.area = 177){
  ## ToDO: Implement so strata can be calculated w/o
    ## STRAT variable (i.e. recode based on zone and Habitat)
  ##ToDO: Make sure vars for sample.data are recognized
  ##ToDo Make sure vars for stratum.data are recognized
  ##ToDo: Check for valid species
  ##ToDo: Check for valid strata
  ##ToDo: Check for valid years
  ## ToDo: Add options for all years
  ## ToDo: Add options for all data
  
  ## Subset of Data based on arguments 
  sample.data = subset(
    sample.data,
    subset = YEAR %in% years & SPECIES_CD %in% species & STRAT %in% strata
    )
  
 ## The number of stations per PSU (m)
  psu = aggregate(
    STATION_NR ~ YEAR + SPECIES_CD + STRAT + PRIMARY_SAMPLE_UNIT,
    data = sample.data,
    FUN = max
  )
  names(psu)[length(names(psu))] = "m"
  
  ## Codes for whether there are replicates in each psu
  psu$rp = ifelse(psu$m > 1, 1, 0)
  
  ## The sum of counts in each PSU
  sum.counts = aggregate(
    NUM ~ YEAR + SPECIES_CD + STRAT + PRIMARY_SAMPLE_UNIT,
    data = sample.data,
    FUN = sum
  )$NUM
  
  ## avg.density for each PSU
  psu$avg.dens = (1/psu$m)*(sum.counts/ssu.area) #1/m * sum(F/T)
 
 ## List of counts for each PSU
 counts = aggregate(
   NUM ~ YEAR + SPECIES_CD + STRAT + PRIMARY_SAMPLE_UNIT,
   data = sample.data,
   FUN = list
 )$NUM
 
 ## Calculate variance among SSUs 
 s2 = NULL
 for (i in 1:length(counts)){
   s2[i] = sum((counts[[i]]-psu$avg.dens[i])^2)/(psu$m[i]-1)
 }
 
 ## Code to correct for divide by zeroes
 psu$s2 = ifelse(is.nan(s2) | is.infinite(s2),0,s2)
 

  return(psu)
}
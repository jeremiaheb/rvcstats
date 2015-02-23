## Helper: Returns true if data.frame x has only one unique species
## in column SPECIES_CD
hasOneSpecies  <- function(x){
  spc  <- unique(x$SPECIES_CD);
  return(length(spc) == 1)
}
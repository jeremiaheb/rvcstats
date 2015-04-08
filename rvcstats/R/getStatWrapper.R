#' @export
## A multispecies wrapper for getStat
getStatWrapper  <- function(x, level, stat, growth_parameters = NULL, merge_protected = TRUE, when_present = FALSE,
                            length_class = NULL, ...){
  # Make sure stat is valid
  if(!any(stat %in% c("abundance", "biomass", "density",
                      "occurrence", "length_frequency"))){
    stop('stat must be one of the following: "abundance", "biomass", "density",
                     "occurrence", "length_frequency"')
  }
  # Select based on option, if neccessary
  x  <- select(x, ...);
  ## Set up output
  out  <- NULL;
  ## If x has only one species or (growth_paramters == NULL & length_class == NULL
  ## and when_present == FALSE) do single species case
  ## else do multispecies
  if ((is.null(growth_parameters) & is.null(length_class) & !when_present) | hasOneSpecies(x$sample_data)){
    out  <- getStat(x, level, stat, growth_parameters, merge_protected, when_present,
            length_class, ...);
  } else {
    ## Make a list of species
    species_list  <- as.character(unique(x$sample_data$SPECIES_CD));
    ## Run single species case for each species
    lout  <- list();
    for (i in seq_along(species_list)){
      ## Species name with underscore instead of space
      spc  <- gsub(" ","_", species_list[i]);
      ## Growth paramters for species i
      gp  <- growth_parameters[[spc]];
      ## Length class for species i
      lc  <- length_class[[spc]];
      ## The single-species case for species i
      lout[[i]]  <- getStat(x, level, stat, growth_parameters = gp, merge_protected, when_present,
                          length_class = lc, species = species_list[i])
    }
    ## If length_class is in some but not all data.frames in lout, add to
    ## data frames where it is missing with "all" as the level
    has_length_class  <- unlist(lapply(lout, function(x){"length_class" %in% names(x)}));
    if (any(has_length_class) & !all(has_length_class)){
      lout[!has_length_class]  <- lapply(lout[!has_length_class], 
                                         function(x){cbind(x,length_class = rep("all",nrow(x)))})
    }
    ## Rbind all data.frames together and return
    out  <- do.call(rbind, lout);
  }
  return(out)
}
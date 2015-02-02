#' @export
## Returns: the sample data as SSU level statistics given 
## x, an RVC object
## stat, the statistic to be calculated
## growth_parameters, a list of allometric growth parameters (if
## stat == "biomass")
ssu  <- function(x, stat, growth_parameters){
  ## Make sure x is an RVC object
  if (!inherits(x, "RVC")){
    stop("x must be of type RVC")
  }
  ## Arguments to use for each stat
  # alist ensures arguments not evaluated until needed (lazy evaluation)
  # General Case:
  args  <- alist(x = list(yi = NUM), by = aggBy("ssu",stat),FUN = NULL);
  # For each stat:
  if (stat == "biomass"){
    # Set NUM to Biomass for each record
    x  <- toBiomass(x, growth_parameters);
    # Sum biomass for each SSU
    args$FUN  <- sum;
  } else if(stat=="occurrence"){
    # If occurrence, get occurrence for each SSU
    args$FUN  <- function(x)ifelse(sum(x)>0,1,0);
  } else {
    # For density, abundance, and length_frequency
    # Use sum as the function to apply
    args$FUN  <- sum;
  }
 
  # Calculate statistic at the SSU level
  x$sample_data  <- with(x$sample_data, do.call(aggregate, args));
  class(x)  <- "SSU"
  return(x)
}
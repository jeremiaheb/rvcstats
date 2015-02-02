#' @export
ssu  <- function(x, stat, merge_protected, growth_parameters){
  # Make sure x is an RVC object
  if (!inherits(x, "RVC")){
    stop("x must be of type RVC")
  }
  # Recalculate NUM (if neccessary) and pick the function
  # to use in the aggregate statement for each stat
  if (stat == "biomass"){
    x  <- toBiomass(x, growth_parameters); #Turn num to biomass
    f  <- sum; 
  } else if (stat == "occurrence") {
    f  <- function(x)ifelse(sum(x)>0,1,0); #Calc. occurrence for each SSU
  } else {
    f  <- sum; 
  }
  # Calculate statistic at the SSU level
  x$sample_data  <- with(x$sample_data, 
                         aggregate(list(yi = NUM), aggBy("ssu",stat, merge_protected), f)
                         );
  # Set class to SSU
  class(x)  <- "SSU";
  return(x)
}
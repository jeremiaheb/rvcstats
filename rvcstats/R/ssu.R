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
  ## Arguments:
  args  <- alist(x = list(yi = NUM), by = aggBy("ssu",stat),FUN = NULL);
  
  ## Cases:
  if (stat == "biomass"){
    # Set NUM to Biomass for each record
    x  <- toBiomass(x, growth_parameters);
    args$FUN  <- sum;
  } else if(stat=="occurrence"){
    args$FUN  <- function(x)ifelse(sum(x)>0,1,0); #Calculates occurrence
  } else {
    args$FUN  <- sum;
  }
 
  ## Evaluation:
  x$sample_data  <- with(x$sample_data, do.call(aggregate, args));
  
  ## Set class to SSU and return
  class(x)  <- "SSU"
  return(x)
}
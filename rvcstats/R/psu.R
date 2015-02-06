## Returns: the sample data as a PSU level statistic (yi) 
## variance (var) and number of SSUs (m), given
## x, an RVC object
## stat, the statistic to be calculated
## growth_parameters, a list of allometric growth parameters (if
## stat == "biomass")
psu  <- function(x, stat, growth_parameters){
  ## Run ssu on x
  x  <- ssu(x, stat, growth_parameters);
  
  ## Arguments:
  # For summary statistic:
  args1  <- alist(x = list(yi = yi), by = aggBy("psu", stat), FUN = NULL);
  # For variance:
  args2  <- alist(x = list(var = yi), by = aggBy("psu", stat), FUN = NULL);
  # For m:
  args3  <- alist(x = list(m = STATION_NR), by = aggBy("psu", stat), FUN = NULL);
  
  ## Cases:
  # For statistic
  if (stat == "length_frequency"){
    args1$FUN  <- sum;
  } else {
    args1$FUN  <- mean;
  }
  # For variance:
  if (stat == "occurrence"){
    pvar  <- function(x){mean(x)*(1-mean(x))}; # Discrete variance
    args2$FUN  <-  function(x){ifelse(length(x)>1,length(x)/(length(x)-1)*pvar(x), NA)} # Produces NAs if m == 1
  } else {
    args2$FUN  <- var; ## Produces NAs if m == 1
  }
  # For m (all the same)
  args3$FUN  <- length;
  
  ## Evaluation: 
  # Clone x$stratum_data into a list called out
  out  <- list();
  out$stratum_data  <- x$stratum_data;
  # If summary statistic is length_frequency, only calculate statistic value
  # else calculate value, variance, and m
  out$sample_data  <- with(x$sample_data, do.call(aggregate, args1));
  if (stat!="length_frequency"){
    out$sample_data$var  <- with(x$sample_data, do.call(aggregate, args2)$var);
    out$sample_data$m  <- with(x$sample_data, do.call(aggregate, args3)$m);
  }
  
  ## Set class to PSU and return
  class(out)  <- "PSU"
  return(out)
}
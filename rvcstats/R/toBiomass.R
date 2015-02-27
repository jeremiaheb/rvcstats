toBiomass  <- function(x, growth_parameters){
  if (!all(c("a","b") %in% names(growth_parameters))){
    stop('growth_paramters must be a list containing allometric growth 
        parameters named "a" and "b"');
  }
  # Get allometric growth parameters
  a  <- growth_parameters[['a']]; b  <- growth_parameters[['b']];
  # Convert NUM into biomass in kg
  x$sample_data$NUM  <- with(x$sample_data, (NUM*a*(LEN*10)^b)/1000);
  # Return modified data
  return(x)
}
toBiomass  <- function(x, growth_parameters){
  # Get allometric growth parameters
  a  <- growth_parameters[['a']]; b  <- growth_parameters[['b']];
  # Convert NUM into biomass
  x$sample_data$NUM  <- with(x$sample_data, NUM*a*LEN^b);
  # Return modified data
  return(x)
}
toOccurrence  <- function(x){
  #Recode NUM to reflect occurrence
  x$sample_data$NUM  <- ifelse(x$sample_data$NUM > 0, 1, 0);
  return(x)
}
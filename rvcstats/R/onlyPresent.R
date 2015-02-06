## Helper: Subsets data by when present
onlyPresent  <- function(x){
  x$sample_data  <- subset(x$sample_data, NUM > 0);
  return(x)
}
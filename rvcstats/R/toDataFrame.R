toDataFrame  <- function(l){
  ## Figure out which elements are numeric
  isNum  <- sapply(l[[1]], is.numeric);
  ## Cbind and Rbind everything
  df  <-  do.call(rbind,lapply(l, function(x){do.call(cbind,as.list(x))}));
  ## Cast to data.frame
  df  <- as.data.frame(df);
  ## Cast numeric cols to numeric
  df[isNum]  <- apply(df[isNum],2,as.numeric);
  
  return(df)
}
## Turns the list output by fromJSON 
## into an appropriately formatted data.frame
toDataFrame  <- function(list){
  ## inner do.call formts each list item into
  ## a data.frame like thing
  ## outer do call rbinds them together
  df  <- do.call(rbind,
                 lapply(list, function(x){do.call(cbind,x)})
                 )
  return(as.data.frame(df))
}
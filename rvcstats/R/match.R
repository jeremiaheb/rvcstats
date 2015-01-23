'%match%'  <- function(x,y){
  if (is.null(y)){
    return(rep(TRUE, length(x)))
  } else {
    return(x %in% y)
  }
}
## Helper: checks is x is NA or NULL
isBlank  <- function(x){
  if (!is.null(x)){
    return(is.na(x))
  } else {
    return(TRUE)
  }
}
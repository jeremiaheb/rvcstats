## Helper function to produce errors if parameter par composed of x is not in list y
inList = function(par,x,y){
  d = setdiff(x,y)
  if (length(d)>0){
    diff = paste(d, collapse = ", ")
    stop(paste(par,diff, "not found in data"))
  }
}
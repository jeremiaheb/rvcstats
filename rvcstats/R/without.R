## Helper Function: Returns items in x that are not in y
"%w/o%" = function(x,y){
  x[!x %in% y]
}
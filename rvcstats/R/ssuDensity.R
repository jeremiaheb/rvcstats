## Returns: a data.frame with densities for each seconday sample unit added
ssuDensity = function(rvcObj, ssu.area = 177){
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC")
  }
  ## Calculate Densities
  rvcObj$DENS = rvcObj$NUM/ssu.area
  ## Reclasiify so it can be coerced to data.frame
  class(rvcObj) = "list"
  return(as.data.frame(rvcObj))
}
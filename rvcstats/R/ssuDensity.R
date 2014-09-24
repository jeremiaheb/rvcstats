## Returns: an RVC object with densities for each seconday sample unit added
ssuDensity = function(rvcObj, ssu.area = 177){
  if (!inherits(rvcObj, "RVC")){
    stop("rvcObj must be of class RVC")
  }
  rvcObj$DENS = rvcObj$NUM/ssu.area
  return(rvcObj)
}
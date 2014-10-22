## Calculate qth quantile from 0-1, exclusive of 0 and 1
## given a vector of probabilities p, and a corresponding
## vector of x values
.quantile = function(q, p, x){
  ## Order p by x
  px = cbind(p,x)
  px = px[order(x),]
  
  s = 0
  i = 0
  while (s < q){
    i = i+1
    s = px[i,1] + s
  }
  up = px[i,2]
  
  s = 0
  i = length(x)+1
  while(s < (1-q)){
    i = i-1
    s = s + px[i,1]
  }
  down = px[i,2]
  
  return(as.vector((up+down)/2))
}
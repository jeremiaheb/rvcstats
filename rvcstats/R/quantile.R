## Helper Function: Returns the qth quantile, given a numeric vector, x,
## and their corresponding probabilities, p
.quantile = function(q,x,p){
  xp = data.frame(x,p)
  xp = xp[order(x),]
  
  s=0
  i=1
  while(s<=q){
    s = s+xp$p[i]
    i = i+1
  }
  up = xp$x[i-1]
  
  s=0
  i=length(x)
  while(s<=(1-q)){
    s = s+xp$p[i]
    i = i-1
  }
  down = xp$x[i+1]
  
  return((up+down)/2)
}
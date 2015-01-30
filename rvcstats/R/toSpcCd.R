## Helper Function to create a species code from a scientific name
toSpcCd = function(s){
  x = sapply(s, FUN = function(s){
    spl = strsplit(s, " ")
    f = substring(spl[[1]][1],1,3)
    l = substring(spl[[1]][2],1,4)
    return(toupper(paste(f,l,sep = " ")))
  })
  return(as.vector(x))
}
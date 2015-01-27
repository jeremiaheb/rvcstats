domainAbun  <- function(rvcObj){
  s  <- stratAbun(rvcObj);
  ## Aggregate by Year and protected status (if applicable)
  ## and calculate index of abundance and variance
  d  <- with(
    s,
    aggregate(
      list(yt = yt, vbar = vbar),
      by = as.list(s[names(s) %in% c("SPECIES_CD", "YEAR", "PROT")]),
      FUN = sum
                   )
    );
  ## Calculate SE
  d$se  <- sqrt(d$vbar);
  return(d)
}
stratAbun  <- function(rvcObj){
  s  <- strat(rvcObj, stat = "density")
  out  <- s[names(s) %in% c("SPECIES_CD", "YEAR", "PROT", "STRAT")];
  out$yt  <- with(s, round(yi*NMTOT,0));
  out$vbar  <- with(s, NMTOT^2*vbar);
  return(out)
}
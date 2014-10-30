## Returns: Summary statistics of lenFrequency data
## Min, 1st quartile, mean, median, 3rd quartile, max
lengthFrequency = function(sample.data, stratum.data, species, years = "all", strata = "all",
                           includes.protected = FALSE, by.stratum = FALSE){
  L = lenFreq(sample.data, stratum.data, species, years, strata,
              includes.protected, by.stratum)
  ## Set aggregate by factors, and drop unused levels
  agg.by = lapply(as.list(L[names(L) %w/o% c("LEN", "frequency")]), as.character)
  
  summary = by(list(LEN = L$LEN,frequency = L$frequency), 
              agg.by,
              FUN = function(x){return(list(
                "Min" = min(x$LEN),
                "First Quartile" = .quantile(0.25, x$LEN, x$frequency),
                Mean = sum(x$LEN*x$frequency),
                Median = .quantile(0.5, x$LEN, x$frequency),
                "Third Quartile" = .quantile(0.75, x$LEN, x$frequency),
                Max = max(x$LEN)
              ))}
              )
  return(summary)
  
}
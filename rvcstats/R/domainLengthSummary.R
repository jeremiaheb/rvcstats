#' Summarizes Length Frequency Data for the sampling domain
#' @export
#' @description Produces a data.frame with summary statistics
#' of length split by species, year, and protected status 
#' (if applicable)
#' @inheritParams stratLenFreq
#' @return A data.frame with SPECIES_CD, YEAR, PROT (if applicable), and:
#' \item{min}{A numeric vector of the minimum length}
#' \item{first.quartile}{A numeric vecotr of the first quartile of length}
#' \item{mean}{A numeric vector of the mean length}
#' \item{median}{A numeric vector of the median length}
#' \item{third.quartile}{A numeric vector of the third quartile of length}
#' \item{max}{A numeric vector of the maximum length}
#' @seealso \code{\link{domainLenFreq}}
domainLengthSummary  <- function(rvcObj){
  ## Get length frequency data
  l  <- domainLenFreq(rvcObj);
  ## Select only data where frequency is greater than 0
  l  <- with(l, l[freq > 0,]);
  ## Split by species, year, and protected status (if applicable)
  by  <- names(l) %in% c("SPECIES_CD", "YEAR", "PROT");
  spl  <- split(l, l[by], drop = TRUE);
  ## Define a function to compute summary statistics
  summarize  <- function(x){
    # Get length and frequency
    len  <- x$LEN; freq  <- x$freq;
    # Summary statistics
    min  <- min(len); max  <- max(len);
    mean  <- sum(len*freq);
    median  <- .quantile(0.5, len, freq);
    first  <- .quantile(0.25, len, freq);
    third  <- .quantile(0.75, len, freq);
    # Get associated factors
    spc  <- x$SPECIES_CD[1];
    yr  <- x$YEAR[1];
    # Place in data frame
    smry  <- data.frame(SPECIES_CD = spc, YEAR = yr, min = min, 
                        first.quantile = first, median = median, 
                        mean = mean, third.quantile = third,
                        max = max);
    # Add protected if applicable
    if (!attr(rvcObj, "merge_protected")){
      PROT  <- x$PROT[1]
      smry  <- cbind(smry[1:2],PROT , smry[3:ncol(smry)]);
    }
    return(smry)
  }
  ## Apply function to each element 
  s  <- lapply(spl, summarize);
  ## Put the data back together
  out  <-  NULL;
  for (i in seq_along(s)){
    out  <- rbind(out, s[[i]]);
  }
  return(out)
}
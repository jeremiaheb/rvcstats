#' Summarizes Length Frequency Data for each Stratum
#' @export
#' @description Produces a data.frame with summary statistics
#' of length split by species, year, and protected status 
#' (if applicable)
#' @inheritParams stratLenFreq
#' @return A data.frame with SPECIES_CD, YEAR, STRAT, PROT (if applicable), and:
#' \item{min}{A numeric vector of the minimum length}
#' \item{first.quartile}{A numeric vecotr of the first quartile of length}
#' \item{mean}{A numeric vector of the mean length}
#' \item{median}{A numeric vector of the median length}
#' \item{third.quartile}{A numeric vector of the third quartile of length}
#' \item{max}{A numeric vector of the maximum length}
#' @seealso \code{\link{stratLenFreq}}
stratLengthSummary <- function(rvcObj){
  ## Get length frequency data
  l  <- stratLenFreq(rvcObj);
  ## Split by species, year, stratum, and protected status (if applicable)
  by  <- c("SPECIES_CD", "YEAR", "STRAT", "PROT");
  spl  <- split(l, l[by], drop = TRUE);
  ## Apply min, quantile, max, expected to split data
  #Function to summarize each stratum
  sumry  <- function(x){
    # Length vector
    len  <- x$LEN;
    #Apply summary functions
    min  <- ifelse(length(len)>1,min(len[len!=0]),0); 
    max  <- ifelse(length(len)>1,max(len),0);
    first  <- .quantile(0.25, len, x$freq);
    median  <- .quantile(0.5, len, x$freq);
    mean  <- len*x$freq; third  <- .quantile(0.75, len, x$freq);
    ## Pull out factors
    spc  <- x$SPECIES_CD[1]; yr  <- x$YEAR[1]; str  <- x$STRAT[1];
    ## Generate output
    out  <- data.frame(SPECIES_CD = spc, YEAR = yr,
                       STRAT  = str, min = min, first.quartile = first,
                       median = median, mean = mean, third.quartile = third,
                       max = max);
    ## if includes_protected, add as column
    if (attr(rvcObj, "includes_protected")){
      PROT <- x$PROT[1]
      out  <- c(out[1:2], PROT, out[3:ncol(out)]);
    }
  }
  # Apply to list
  s  <- lapply(spl, FUN = sumry);
  ## Unsplit data and return
  outp  <- NULL;
  for (i in 1:seq_along(s)){
    outp  <- rbind(outp, s[[i]]);
  }
  return(outp)
}
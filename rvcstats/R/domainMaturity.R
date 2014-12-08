#' Calculates domain level estimates of density or
#' occurrence for juveniles/adults
#' @export
#' @inheritParams stratMaturity
#' @return A data.frame with the species, year, and stratum 
#' information as well as:
#' \item{yi.m}{The average density/occurrence for adults}
#' \item{yi.j}{The average density/occurrence for juveniles}
#' \item{variance.m}{The variance in density/occurrence for adults}
#' \item{variance.j}{The variance in density/occurrence for juveniles}
#' \item{se.m}{The standard error of density/occurrence for adults}
#' \item{se.j}{The standard error of density/occurrence for juveniles}
#' \item{cv.m}{The coeficient of variation (as a percent) in density/occurrence for adults}
#' \item{n}{The total number of primary samples per sampling domain}
#' \item{nm}{The total number of secondary samples per sampling domain}
#' \item{NMTOT}{The total possible number of secondary samples per sampling domain}
#' @seealso \code{\link{stratMaturity}} \code{\link{maturityData}}
domainMaturity  <- function(matObj, calc = 'd'){
  ## Type checking
  if (!inherits(matObj, "MAT")){
    stop('matObj must be of type MAT, type ?maturityData for help');
  }
  ## Get juvenile and adult domain estimates
  j  <- domain(matObj$j, calc);
  m  <- domain(matObj$m, calc);
  ## Set the variables by which to merge
  by  <- names(j)[names(j) %in%
         c("SPECIES_CD", "YEAR", "PROT", "n", "nm", "NMTOT")];
  ## Merge and return
  out  <- merge(m, j, by, suffixes = c(".m", ".j"));
  return(out)
}
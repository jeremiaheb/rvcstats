#' Calculates density or occurrence of mature/juvenile individuals on a 
#' stratum-level
#' @export
#' @param matObj
#' @inheritParams strat
#' A MAT object, see \code{\link{maturityData}} for more details.
#' @return
#' A data.frame with the species, year, stratum, protected status (if applicable)
#' and:
#' \item{wh}{The weighting factor for a particular stratum}
#'  \item{yi.m}{The average density/occurrence of mature individuals}
#'  \item{yi.j}{The average density/occurrence of juvenile individuals}
#'  \item{mbar}{The average number of secondary sample units per stratum}
#'  \item{n}{The number of primary sample units per stratum}
#'  \item{v1.m}{The variance between primary sample units in density/occurrence
#'  for mature individuals}
#'  \item{v1.j}{The variance between primary sample units in density/occurrence for 
#'  immature individuals}
#'  \item{v2.m}{The stratum-level variance between secondary sample units in density/occurrence
#'  for mature individuals}
#'  \item{v2.j}{The stratum-level variance between secondary sample units in density/occurrence
#'  for immature individuals}
#'  \item{s.m}{Sample standard deviation of density/occurrence 
#'  for mature individuals in each stratum}
#'  \item{s.j}{Sample standard deviation of density/occurrence
#'  for immature individuals in each stratum}
#'  \item{vbar}{Variance in mean density/occurrence in each stratum}
#'  \item{nm}{The total number of secondary sample units per stratum}
#'  \item{NMTOT}{The total possible number of secondary samples per stratum}
#'  @seealso \code{\link{maturityData}} \code{\link{domainMaturity}}
stratMaturity <- function(matObj, calc = 'd'){
  ## Check that matObj is a MAT object
  if (!inherits(matObj, 'MAT')){
    stop("matObj must be a MAT object, type ?maturityData for help")
  }
  ## Get juvenile and adult stratum-level estimates
  j  <- strat(matObj$j, calc);
  m  <- strat(matObj$m, calc);
  ## Set up merge by variables
  by  <- names(j)[names(j) %in%
                    c("YEAR", "SPECIES_CD",
                      "STRAT","NTOT",
                      "PROT", "GRID_SIZE", 
                "wh", "mbar", "n", "nm", 
                "NMTOT")];
  ## Merge and return
  out  <- merge(m,j,by, suffixes = c(".m",".j"));
  return(out)
}
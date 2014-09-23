\name{epimori2012}
\alias{epimori2012}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
2012 Data for Red Grouper \emph{Epinephelus morio}
}
\description{
Data from 2012 RVC on Red Grouper. 
}
\usage{data(epimori2012)}
\format{
  A data frame with 930 observations on the following 23 variables.
  \describe{
    \item{\code{PSUID}}{a factor with levels }
    \item{\code{YEAR}}{a numeric vector indicating the year}
    \item{\code{MONTH}}{a numeric vector indicating the month}
    \item{\code{DAY}}{a numeric vector indicating the day of the week}
    \item{\code{PRIMARY_SAMPLE_UNIT}}{a factor with levels }
    \item{\code{STATION_NR}}{a numeric vector indicating the secondary sampling unit station at a given primary sampling unit}
    \item{\code{LAT_DEGREES}}{a numeric vector indicating the latitude in decimal degreed}
    \item{\code{LON_DEGREES}}{a numeric vector indicating the longitude in decimal degrees}
    \item{\code{UNDERWATER_VISIBILITY}}{a numeric vector indicating the underwater visibility in meters}
    \item{\code{MAPGRID_NR}}{a numeric vector indicating the mapgrid number}
    \item{\code{HABITAT_CD}}{a factor with levels \code{CONT_LR} \code{ISOL_LR} \code{ISOL_MR} \code{RUBB_LR} \code{SPGR_HR} \code{SPGR_LR} } %ToDo: get metadata on this
    \item{\code{ZONE_NR}}{a numeric vector} %ToDo: Get metadata on this
    \item{\code{SUBREGION_NR}}{a numeric vector} %ToDo: get metadata on this
    \item{\code{MPA_NR}}{a numeric vector} %ToDo get metadata on this
    \item{\code{SPECIES_NR}}{a numeric vector indicating the coded number for a given species}
    \item{\code{SPECIES_CD}}{a factor with levels indicating the species code. Represented as the first three letters of the genus name and the first four letters of the species name}
    \item{\code{LEN}}{a numeric vector indicating the length class of a species at a station}
    \item{\code{NUM}}{a numeric vector indicating the number of individuals seen at a station}
    \item{\code{TIME_SEEN}}{a numeric vector indicating the time code. 1: within 5 min. 2: 5-10 min. 3: After 10 min.}
    \item{\code{PSU_DEPTH}}{a numeric vector indicating the depth in meters}
    \item{\code{FOREDEP}}{a numeric vector} %ToDo: ?????
    \item{\code{PROT}}{a numeric vector} %ToDo: ?????
    \item{\code{STRAT}}{a factor with 8 levels \code{FDLR}: Forereef deep low-relief \code{FMLR}: Forereef mid-depth low-relief,  \code{FSLR}: Forereef shallow low-relief \code{HRRF}: High-relief reef, \code{INPR}: Inshore patch reef, \code{MCPR}: Mid-channel patch reef \code{OFPR}: offshore patch reef}
  }
}

\examples{
data(epimori2012)
## maybe str(epimori2012) ; plot(epimori2012) ...
}
\keyword{datasets}

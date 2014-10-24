\name{stratOccurrence}
\alias{stratOccurrence}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Calculate Stratum Level Frequency of Occurrence
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Calculates stratum level occurrence for RVC data, given a data.frame of RVC sample data and a data.frame of stratum data.
}
\usage{
stratOccurrence(sample.data, stratum.data, species, years = "all", strata = "all", includes.protected = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sample.data}{
%%     ~~Describe \code{sample.data} here~~
A data.frame or list containing analysis ready data. Data must include columns for species code (SPECIES_CD), year (YEAR), primary sample unit (PRIMARY_SAMPLE_UNIT), station (STATION_NR), stratum (STRAT), and number counted (NUM). Other variables such as protected status (MPA_NR) is needed if includes.protected is TRUE.
}
  \item{stratum.data}{
%%     ~~Describe \code{stratum.data} here~~
A data.frame or list containing the columns for the year (YEAR), stratum (STRAT), and total number of possible primary sample units per stratum (NTOT). If includes.protected is set to TRUE, then it must also include a column for protected status (PROT)
}
  \item{species}{
%%     ~~Describe \code{species} here~~
A string or vector of strings containing the species codes (first three letters of the genus and first four of the species) or the full scientific names of the species the user is interested in analyzing.
}
  \item{years}{
%%     ~~Describe \code{years} here~~
A number or numeric vector containing the years the user is interested in analyzing. Default value of "all" selects for all available years.
}
  \item{strata}{
%%     ~~Describe \code{strata} here~~
A character vector of the four letter designations indicating the stratum or strata the user is interested in analyzing. Strata codes are: INPR - inshore patch reef, MCPR - mid-channel patch reef, OFPR - offshore patch reef, FSLR - forereef shallow low relief, FMLR - forereef medium depth low relief, FDLR - forereef deep low relief, HRRF - High relief reef. Default value of "all" selects for all available strata.
}
  \item{includes.protected}{
%%     ~~Describe \code{includes.protected} here~~
A boolean indicating whether or not to analyze protected areas separately from unprotected areas. Default value is FALSE.
}
}
\value{
Outputs a data.frame with:
\item{occurrence}{A numeric vector of the average frequency of occurrence in a stratum}
\item{mbar}{
A numeric vector of the average number of secondary units per primary unit within each stratum
}
\item{n}{
A numeric vector of the number of primary units in each stratum
}
\item{v1}{
A numeric vector of the variance in density/occurrence between primary units in each stratum
}
\item{nm}{
A numeric vector of the total number of secondary units in each stratum
}
\item{v2}{
A numeric vector of the variance in density/occurrence between secondary units in each stratum
}
\item{vbar}{
A numeric vector of the overall stratum level variance in density/occurrence
}
\item{NMTOT}{
A numeric vector of the total number of possible secondary units in each stratum
}
}
\note{
%%  ~~further notes~~
stratOccurrence is a high-level wrapper for the \code{\link{strat}} function
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{domainOccurrence}}
\code{\link{stratDensity}}
\code{\link{lenFreq}}
}
\examples{
## Import rvc and strat data
data(rvc2)
data(strat2)

## Calculate the stratum occurrences for Epinephelus morio in 2011
## for protected and unprotected areas combined
stratOccurrence(sample.data = rvc2, stratum.data = strat2, species = "epi mori",
years = 2011)

## Calculate the stratum occurrence of Lutjanus griseus on patch reefs
## from 2011-2013, with protected areas calculated separately
stratOccurrence(rvc2, strat2, "lut gris", years = c(2011:2013),
  strata = c("INPR", "MCPR", "OFPR"), includes.protected = TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

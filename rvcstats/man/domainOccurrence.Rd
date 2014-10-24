\name{domainOccurrence}
\alias{domainOccurrence}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Estimate Sample Domain Level Frequency of Occurrence
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Estimates the frequency of occurrence per secondary sampling unit (\eqn{177m^2}) for a given species or set of species
}
\usage{
domainOccurrence(sample.data, stratum.data, species, years = "all", strata = "all", includes.protected = FALSE)
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
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Returns a data.frame with:
\item{occurrence}{
A numeric vector of the average domain level frequency of occurrence.
}
\item{variance}{
A numeric vector of the domain level variance in average density/frequency of occurrence.
}
\item{se}{
A numeric vector of the domain level standard error in average density/frequency of occurrence.
}
\item{cv}{
A numeric vector of the domain level coefficient of variation in average density/frequency of occurrence.
}
\item{n}{
A numeric vector of the number of primary sampling units in the sampling domain
}
\item{nm}{
A numeric vector of the number of secondary sampling units in the sampling domain
}
\item{NMTOT}{
A numeric vector of the total number of possible sampling units in the sampling domain
}
}

\note{
%%  ~~further notes~~
domainOccurrence is a high-level wrapper for the \code{\link{domain}} function
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{domainDensity}}
\code{\link{lenFreq}}
}
\examples{
## Import rvc and stratum data
data(rvc2)
data(strat2)

## Domain Occurrence for Epinephelus morio and Lutjanus griseus for all
## three years in the data, with protected and non protected areas grouped
## together
domainOccurrence(sample.data = rvc2, stratum.data = strat2,
  species = c("EPI MORI","Lutjanus griseus"))
  
## Same as above, but protected areas calculated seperately
domainOccurrence(rvc2, strat2, species = c("EPI MORI", "LUT GRIS"),
  includes.protected = TRUE)

## Domain occurrence only for only Lutjanus griseus in 2011 and 
## only on patch reefs inshore, midchannel, and offshore
pr = c("INPR", "MCPR", "OFPR")
domainOccurrence(rvc2, strat2, species = "LUT GRIS", years = 2011, strata = pr)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

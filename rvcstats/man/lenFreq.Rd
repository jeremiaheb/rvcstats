\name{lenFreq}
\alias{lenFreq}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Calculate length frequency
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Calculates the length frequencies for each species aggreagated by the input agg.by vairables
}
\usage{
lenFreq(data, species, years = "all", strata = "all", agg.by = c("YEAR"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
A data.frame or list containing analysis ready data. Data must include columns for species code (SPECIES_CD), year (YEAR), primary sample unit (PRIMARY_SAMPLE_UNIT), station (STATION_NR), stratum (STRAT), length in centimeter (LEN), and number counted (NUM)
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
  \item{agg.by}{
%%     ~~Describe \code{agg.by} here~~
A character vector of the variables by which to aggregate the length frequency. By default set to "YEAR"", but can aggregate by stratum, "STRAT", and protected status "PROT", as well.  
}
}

\value{
A data.frame with the aggregate by variables and:
\item{LEN}{a numeric vector of lengths, in centimeters}
\item{frequancy}{A numeric vector of frequency, corresponding to the lengths}
}
\note{
%%  ~~further notes~~
lenFreq does not summarize the length frequency data, but outputs all the length frequencies in the analysis ready data, and their frequencies. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{domainDensity}}
}
\examples{
## Import sample data
data(rvc2)
## Calculate length frequencies of Epinephelus morio for each year
l1 = lenFreq(data = rvc2, species = "EPI MORI")
## Length frequencies for each stratum in 2011
l2 = lenFreq(data = rvc2, species = "EPI MORI", agg.by = c("STRAT"))
## Aggregate by year and protected status
l3 = lenFreq(data = rvc2, species = "EPI MORI", agg.by = c("YEAR", "PROT"))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

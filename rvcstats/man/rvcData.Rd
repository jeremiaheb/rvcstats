\name{rvcData}
\alias{rvcData}
\alias{psuDensity}
\alias{ssuDensity}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
rvcData
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Makes a subset of Reef Visual Census data based on selected species, years, strata, and data
}
\usage{
rvcData(species, years, strata, data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{species}{
A character vector of species codes (first three letters of generic name and first four of specific names) to be selected from data. Not case sensitive.}
\item{years}{
A numeric vector of years to be selected from data}
\item{strata}{
The names of the strata to be selected from data. Examples are: INPR, MCPR, OFPR for inshore mid-channel and offshore patch reef, respectively; FSLR, FMLR, FDLR for fore-reef shallow, mid-depth, and deep low-relief reef respectively; and, HRRF for high relief reef.}
\item{data}{
A data.frame of analysis ready data (available from the SEFSC). Must include (at least) variables indicating: species code, primary sample unit, year, station number, stratum, and counts at each station.}
}

\details{
}
\value{
Returns an RVC object of data subsetted by the selected parameters
\item{SPECIES_CD}{
  The species code: first three leters of the generic name and first four of the specific name
}
\item{YEAR}{
  The year(s) in which the data was collected
}
\item{STRAT}{
  The stratum, see arguments above for more details
}
\item{PRIMARY_SAMPLE_UNIT}{
  The primary sample unit code for the primary sample unit in which the data was collected
}
\item{STATION_NR}{
The station in the primary sample unit in which the data was collected
}
\item{NUM}{
The number of fish seen at the station of a given species
}
}
\author{
%%  ~~who you are~~
Harry Ganz
}
\note{
Intended to be used as part of other functions within the package, but can be useful as a base for user-defined functions. Within s3 class "RVC"
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{psuDensity}}
\code{\link{ssuDensity}}

}
\examples{
## Grey Snapper for one year and high relief reef
#LutGris2012 = rvcData(species = "lut gris", years = 2012, strata = "HRRF", data = fk2012)
## Red and Black grouper for years between 2010 and 2014, for all patch-reef strata
#Grouper2010to2014 = rvcData(c("EPI MORI", "MYC BONA"), 2010:2014, c("INPR", "MCPR", "OFPR"), rbind(fk2010,fk2011,fk2012,fk2013,fk2014))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ rvcData }
\keyword{ RVC }% __ONLY ONE__ keyword per line
%% ToDO: Update if function updates
%% ToDo: Details
%% ToDO: See also when other functions completed

\name{psuSummary}
\alias{psuSummary}
\title{
Summary of fish density statistics for Primary Sample Units (PSU)
}
\description{
Produces summary statitics as a data.frame for fish density in each primary sample unit in the provided species, years, and strata.
}
\usage{
psuSummary(species, years, strata, sample.data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{species}{
%%     ~~Describe \code{species} here~~
Species codes as a string for single species, or character vector for multiple species. Species codes are the first three letters of the genus name and the first four letters of the species name, and are not case sensitive. 
%% ToDO: Add "all", and "combined" options 
}
  \item{years}{
%%     ~~Describe \code{years} here~~
A number or numeric vector indicating the years or years for which summary statistics should be calculated.
%% ToDo: Add "all" option
}
  \item{strata}{
%%     ~~Describe \code{strata} here~~
Stratum codes as character vector or string. Stratum Codes are: INPR, MCPR, OFPR = inshore, midchannel, and offshore patch reef, respectively; HRRF = high relief reef; FSLR, FMLR, FDLR = forereef shallow, mid-depth, and deep low relief reef, respectively 
}
  \item{sample.data}{
%%     ~~Describe \code{sample.data} here~~
A data.frame containing the analysis ready sample data. Should include as columns (at least) SPECIES_CD (species code), YEAR, STATION_NR (station numbers), and STRAT (stratum code) 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
%% ToDo: Details
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
A data.frame with columns corresponding to the year (YEAR), species code (SPECIES_CD), primary sample unit (PRIMARY_SAMPLE_UNIT), stratum (STRAT), the number of stations within the primary sampling unit (m), whether there was a replicate secondary sampling unit within the primary sampling unit (rp = 1 if TRUE and 0 if FALSE), the average density within each primary sampling unit (avg.dens), and the standard deviation amongst secondary sampling units (s2) within each primary unit. 
}

\author{
%%  ~~who you are~~
Harry Ganz
}

\note{
%%  ~~further notes~~
% ToDo: Note
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%% ToDo: See also
}
\examples{
## ToDo: Examples
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{psuSummary}
\keyword{psu}% __ONLY ONE__ keyword per line

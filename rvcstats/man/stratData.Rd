\name{stratData}
\alias{stratData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Stratum Data for Reef Visual Census
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Produces a "STRAT" object constaining information about the strata (e.g. Total possible primary sampling units, NTOT), which can be used by other functions in the rvcstats package
}
\usage{
stratData(data, years = "all", strata = "all", includes.protected = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
A data.frame or list containing the columns for the year (YEAR), stratum (STRAT), and total number of possible primary sample units per stratum (NTOT). If includes.protected is set to TRUE, then it must also include a column for protected status (PROT)
}
  \item{years}{
%%     ~~Describe \code{years} here~~
A numeric vector of years to select from data. By default set to "all", so that all available years are selected.
}
  \item{strata}{
%%     ~~Describe \code{strata} here~~
A character vector of the four letter designations indicating the stratum or strata the user wishes to select. Strata codes are: INPR - inshore patch reef, MCPR - mid-channel patch reef, OFPR - offshore patch reef, FSLR - forereef shallow low relif, FMLR - forereef medium depth low relief, FDLR - forereef deep low relief, HRRF - High relief reef. Default value of "all" selects for all available strata.
}

  \item{includes.protected}{
%%     ~~Describe \code{includes.protected} here~~
A boolean indicating Whether or not to include protected status as substrata by which to aggregate densities. False by default. Requires a column indicating protected status if set to TRUE. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
The output from the stratData function is intended to be used  as input into the other functions in this package. The output from the stratData function itself only gives the input data plus weighing factors for each stratum.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{YEAR}{
A numeric vector of the years for which the NTOTs of each stratum apply
}
\item{STRAT}{
A character vector of four letter codes indicating the stratum
}
\item{NTOT}{
A numeric vector of the total number of possible primary sample units per stratum
}
\item{PROT}{
A numeric vector with the value 1 for indicating a protected area and zero for an unprotected area. Only output when PROT column present in data, and when includes.protected is set to TRUE
}
\item{wh}{
A numeric vector of weighting factors for each stratum. Calculated from the NTOT for a given stratum divided by the total per year. 
}
}

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{rvcData}}
\code{\link{stratDensity}}
\code{\link{domainDensity}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
## ToDo: Make example
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

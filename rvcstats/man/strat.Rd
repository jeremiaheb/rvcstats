\name{strat}
\alias{strat}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Stratum Level Density/Frequency of Occurrence
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Outputs a data.frame of stratum level densities/frequencies of occurrence, variances, number of primary sampling units, and number of secondary sampling units. 
}
\usage{
strat(rvcObj, stratObj, ssu.area = 177, psu.area = 40000, calculate.density = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rvcObj}{
%%     ~~Describe \code{rvcObj} here~~
An "RVC" object containing sampling data. See \code{\link{rvcData}} for more details.
}
  \item{stratObj}{
%%     ~~Describe \code{stratObj} here~~
A "STRAT" object containing stratum data. See \code{\link{stratData}} for more details
}
  \item{ssu.area}{
%%     ~~Describe \code{ssu.area} here~~
A number indicating the area of the secondary sampling unit in \eqn{m^2}. 177 by default.
}
  \item{psu.area}{
%%     ~~Describe \code{psu.area} here~~
A number indicating the area of the primary sampling unit in \eqn{m^2}. 40000 by default.
}
  \item{calculate.density}{
  A boolean indicating that density should be calculated (TRUE by default). If false, calculates frequency of occurrence instead.
  }
}
\details{
strat is a lower-level function, which does not have some of the same conveniences of the high level wrappers \code{\link{stratDensity}} and \code{\link{stratOccurrence}}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Outputs a data.frame with:
\item{yi}{
A numeric vector with the average stratum level density (if calculate.density = TRUE), or the frequency of occurrence (if calculate.density = FALSE)
}
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
A numeric vector of the overall stratum level variance in density/occurence
}
\item{NMTOT}{
A numeric vector of the total number of possible secondary units in each stratum
}
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{domain}}
\code{\link{stratDensity}}
\code{\link{stratOccurrence}}
}
\examples{
## Import simulated data
data(rvc2)
data(strat2)

## stratum and domain density estimates for Lutjanus griseus and 
## Epinephelus morio without estimating protected areas separately
sample = rvcData(rvc2, c("LUT GRIS", "Epinephelus morio"), years = 2011)
strata = stratData(strat2, years = 2011)

## Stratum estimates of density
strat(sample, strata)

## Stratum estimates of frequency of occurrence
strat(sample, strata, calculate.density = FALSE)

## If the secondary or primary unit areas change, those can also be set
## NOT RECCOMMENDED for most end-users
strat(sample, strata, psu.area = 10000, ssu.area = 175)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
\name{psuDensity}
\alias{psuDensity}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Primary Sample Unit Density
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Returns a data.frame of average densities at each primary sample unit, given an RVC object
}
\usage{
psuDensity(rvcObject, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rvcObject}{
%%     ~~Describe \code{rvcObject} here~~
A reef visual census object, see \code{\link{rvcData}}
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
Optional arguments which can be passed to lower-level functions (e.g. the ssu.area)
}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Returns a data frame with the same variables as in \code{\link{rvcData}} as well as:
\item{m}{
The number of secondary sampling units (stations) at the primary sampling unit
}
\item{DENS}{
The average fish density for each primary sampling unit
}
\item{VAR}{
The variance in density for each primary sampling unit
}
}
\author{
%%  ~~who you are~~
Harry Ganz
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{rvcData}}
}
\examples{
## First make an RVC object
#LutGris2012 = rvcData(species = "lut gris", years = 2012, strata = "HRRF", data = fk2012)

## Then run psuDensity on the object
#psuDensity(LutGris2012)

## Can also pass optional parameters to set SSU area
#psuDensity(LutGris2012, ssu.area = 176.7146)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{psuDensity}
% __ONLY ONE__ keyword per line

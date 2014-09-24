\name{ssuDensity}
\alias{ssuDensity}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
ssuDensity
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Adds the density of fish encountered at each secondary sampling station to an RVC object and returns the ammended RVC object
}
\usage{
ssuDensity(rvcObj, ssu.area = 177)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rvcObj}{
An RVC object
}
  \item{ssu.area}{
  The area of secondary sampling units in meters-squared, 177 meters-squared by default. 
  }
}

\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
An RVC object with the same values as \code{\link{rvcData}} and one extra one DENS
\item{DENS}{
The observed density of fish at a secondary sampling unit
}
}

\author{
%%  ~~who you are~~
Harry Ganz
}
\note{
%%  ~~further notes~~
A lower level function. Intended to be called by other functions in the rvcstats package.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{rvcData}}
}
\examples{
## First create an RVC object with rvcData
#LutGris2012 = rvcData(species = "lut gris", years = 2012, strata = "HRRF", data = fk2012)

## Then use in ssuDensity to add density variable
## ssuDensity(LutGris2012)
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

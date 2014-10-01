\name{stratDensity}
\alias{stratDensity}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Stratum Level Density
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Outputs a data.frame of stratum level densities, variances, number of primary sampling units, and number of secondary sampling units. 
}
\usage{
stratDensity(rvcObj, stratObj, ssu.area = 177, psu.area = 40000)
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
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
%% ToDo: Fix value output
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{domainDensity}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
## ToDo: Examples
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
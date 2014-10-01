\name{domainDensity}
\alias{domainDensity}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sampling Domain Density
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Outputs a data.frame of domain level density, variance, standard error, coefficient of variation, and number of samples. 
}
\usage{
domainDensity(rvcObj, stratObj, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rvcObj}{
%%     ~~Describe \code{rvcObj} here~~
An "RVC" object. See \code{\link{rvcData}} for more details.
}
  \item{stratObj}{
%%     ~~Describe \code{stratObj} here~~
A "STRAT" object. See \code{\link{stratData}} for more details.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
Optional parameters that can be passed to \code{\link{stratDensity}}
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
Returns a data.frame with the overall average density, variance, standard error (se), coeeficient of variation (cv), and number of secondary samples (nm) for the entire sampling domain per species, protected area (if selected), and length class (if selected)
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{stratDensity}}
\code{\link{rvcData}}
\code{\link{stratData}}
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
\name{domain}
\alias{domain}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sampling Domain Density/Occurrence
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Outputs a data.frame of domain level density/frequency of occurrence aggregated by year and species, and protected status (if includes.protected = TRUE for RVC and STRAT objects) }
\usage{
domain(rvcObj, stratObj, ...)
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
Optional parameters that can be passed to \code{\link{strat}}, including calculate.density = FALSE, to calculate frequency of occurrence, instead of density. See \code{\link{strat}}. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
domain is a lower-level function, which does not have some of the same conveniences of the high level wrappers \code{\link{domainDensity}} and \code{\link{domainOccurrence}}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Returns a data.frame with:
\item{yi}{
A numeric vector of the average domain level density (if calculate.density = TRUE, the default) or of the frequency of occurence (if calculate.density = FALSE).
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

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{strat}}
\code{\link{rvcData}}
\code{\link{stratData}}
\code{\link{domainDensity}}
\code{\link{domainOccurrence}}
}
\examples{
## Import simulated data
data(rvc2)
data(strat2)

## stratum and domain density estimates for Lutjanus griseus and 
## Epinephelus morio without estimating protected areas separately
sample = rvcData(rvc2, c("LUT GRIS", "Epinephelus morio"))
strata = stratData(strat2)

## Domain estimates of density
domain(sample, strata)
## Domain estimates of frequency of occurence
domain(sample, strata, calculate.density = FALSE)

## Same as above, but seperately estimating protected areas
sample = rvcData(rvc2, c("LUT GRIS", "Epinephelus morio"), includes.protected = TRUE)
strata = stratData(strat2, includes.protected = TRUE)

## Domain estimates of density
domain(sample, strata)
## Domain estimates of frequency of occurence
domain(sample, strata, calculate.density = FALSE)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
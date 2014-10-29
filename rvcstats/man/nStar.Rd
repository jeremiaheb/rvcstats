\name{nStar}
\alias{nStar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Optimal Sample Unit Calcultion
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Calculates the optimum number of primary sample units for each stratum or the sampling domain given a target covariance, and RVC sample data and stratum data from precious years. 
}
\usage{
nStar(cv, rvcObj, stratObj, ..., m = 2, per.stratum = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{cv}{
%%     ~~Describe \code{cv} here~~
A number of the target coefficient of variance (\emph{standard deviation as a percent of the mean}). \strong{Note}: Cannot be a vector
}
  \item{rvcObj}{
%%     ~~Describe \code{rvcObj} here~~
A RVC object, see \code{\link{rvcData}}
}
  \item{stratObj}{
%%     ~~Describe \code{stratObj} here~~
A STRAT object, see \code{\link{stratData}}
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
Optional parameters that can be passed to \code{\link{strat}} function. e.g. setting the psu.area meanually. 
}
  \item{m}{
%%     ~~Describe \code{m} here~~
Number of secondary sampling units per primary sampling unit. 
}
  \item{per.stratum}{
%%     ~~Describe \code{per.stratum} here~~
A boolean indicating whether n* should be calculated on a stratum level (TRUE) or on a domain level (FALSE). The default is TRUE.
}
}

\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
\item{YEAR}{Numeric vector of the year from which estimates were used to calculate n*. \strong{NOTE:} Not the n* calculation for that year, but for the year(s) afterwards}
\item{SPECIES_CD}{A character vector of species codes for which the n* calculation applies. A species code consists of the first three letters of the genus name and the last four of the species name.}
\item{STRAT}{A character vector indicating the stratum for which the n* estimate applies. Only present if per.stratum is set to TRUE (default)}
\item{nstar}{A numeric vector of the optimal number of primary sampling units for the provided coefficient of variance}

}
\references{
%% ~put references to the literature/web site here ~
Cochran, W.G. (1977). Sampling Techniques, 3rd Ed. Wiley, New York.

National Park Service (2009). "A cooperative multi-agency reef fish monitoring protocol for the florida keys ecosystem". Natural Resources Report: NPS/SFCN/NRR -- 2009/150. \href{http://www.dep.state.fl.us/coastal/programs/coral/documents/2012/FIM/04-13/FLKeys_Reef_Fish_monitoring_protocol.pdf}{http://www.dep.state.fl.us/coastal/programs/coral/documents/2012/FIM/04-13/FLKeys_Reef_Fish_monitoring_protocol.pdf}
}
\note{
%%  ~~further notes~~
This is a low-level function. See \code{\link{optimalPsus}} for a higher-level version. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{optimalPsus}}
}
\examples{
## Load sample and stratum data
data(rvc2)
data(strat2)

## Make RVC and STRAT objects
sample = rvcData(data = rvc2, species = c("LUT GRIS", "EPI MORI"), years = 2013)
strata = stratData(data = strat2, years = 2013)

## Calculate stratum level n* for a CV of 30\%
nStar(cv = 30, rvcObj=sample, stratObj=strata)

## Calculate domain level n* for CV of 10\%
nStar(10, sample, strata, per.stratum = FALSE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

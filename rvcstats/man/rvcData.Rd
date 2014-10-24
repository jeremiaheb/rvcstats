\name{rvcData}
\alias{rvcData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Reef Visual Census Data Object
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Subsets input data by specified parameters and outputs an object of class "RVC" which can be used by the other functions within the rvcstats package.  
}
\usage{
rvcData(data, species, years = "all", strata = "all", includes.protected = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
A data.frame or list containing analysis ready data. Data must include columns for species code (SPECIES_CD), year (YEAR), primary sample unit (PRIMARY_SAMPLE_UNIT), station (STATION_NR), stratum (STRAT), and number counted (NUM). Other variables such as protected status (MPA_NR) is needed if includes.protected is TRUE. 
}
  \item{species}{
%%     ~~Describe \code{species} here~~
A string or vector of strings containing the species codes (first three letters of the genus and first four of the species) or the full scientific names of the species the user is interested in analyzing.
}
  \item{years}{
%%     ~~Describe \code{years} here~~
A number or numeric vector containing the years the user is interested in analyzing. Default value of "all" selects for all available years.
}
  \item{strata}{
%%     ~~Describe \code{strata} here~~
A character vector of the four letter designations indicating the stratum or strata the user is interested in analyzing. Strata codes are: INPR - inshore patch reef, MCPR - mid-channel patch reef, OFPR - offshore patch reef, FSLR - forereef shallow low relief, FMLR - forereef medium depth low relief, FDLR - forereef deep low relief, HRRF - High relief reef. Default value of "all" selects for all available strata.
}
  \item{includes.protected}{
%%     ~~Describe \code{includes.protected} here~~
A boolean indicating whether or not to analyze protected areas separately from unprotected areas. Default value is FALSE. 
}

}
\details{
%%  ~~ If necessary, more details than the description above ~~
The output from the rvcData function is intended to be used  as input into the other functions in this package, such as \code{\link{domain}}, and \code{\link{strat}}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Returns an "RVC" object with all the data selected for in the parameters.
\item{SPECIES_CD}{
  The species code for the individual station
}
\item{YEAR}{
The year in which the sample was collected
}
\item{STRAT}{
The stratum in which the sample was collected
}
\item{PRIMARY_SAMPLE_UNIT}{
The primary sample unit in which the sample was collected
}
\item{STATION_NR}{
The station number (secondary sample unit) of the primary sample unit in which the data was collected
}
\item{PROT}{
The protected status of the area in which the sample was collected. 1 if it was in a protected area and 0 if it was not
}
\item{NUM}{
The sample count, averaged among divers at a given station. 
}
}


\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{stratData}}
\code{\link{strat}}
\code{\link{domain}}
}
\examples{
## Import simulated data
data(rvc2)
data(strat2)

## stratum and domain density estimates for Lutjanus griseus and 
## Epinephelus morio without estimating protected areas separately
sample = rvcData(rvc2, c("LUT GRIS", "Epinephelus morio"), years = 2011)
strata = stratData(strat2, years = 2011)
## Stratum estimates
strat(sample, strata)
## Domain Estimates
domain(sample, strata)

## Same as above, but seperately estimating protected areas
sample = rvcData(rvc2, c("LUT GRIS", "Epinephelus morio"), years = 2011, includes.protected = TRUE)
strata = stratData(strat2, years = 2011, includes.protected = TRUE)
## Stratum estimates
strat(sample, strata)
## Domain Estimates
domain(sample, strata)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

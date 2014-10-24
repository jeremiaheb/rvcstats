\name{strat1}
\alias{strat1}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
Simulated stratum data for RVC
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
A simulated dataset for the estimates of primary samples NTOT within each stratum for three years (\strong{not real data}).
}
\usage{data(strat1)}
\format{
  A data frame with 21 observations on the following 3 variables.
  \describe{
    \item{\code{YEAR}}{a numeric vector indicating the year}
    \item{\code{STRAT}}{a factor with levels: \code{INPR} Inshore patch reef, \code{MCPR} Mid-channel patch reef, \code{OFPR} Offshore patch reef, \code{FSLR} Fore-reef shallow low-relief, \code{FMLR} Fore-reef medium depth low-relief,  \code{FDLR} Fore-reef deep low-relief, and \code{HRRF} High relief reef}
    \item{\code{NTOT}}{a numeric vector indicating the number of possible primary sample units within each stratum}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
The generating function for the NTOTs was a uniform distribution between 100 and 500. \strong{Note:} Does not include protected status as a variable, and so cannot be used to estimate density/occurrence of protected areas separately from unprotected areas. See \code{\link{strat2}} for a simulated data set with a \code{PROT} variable. 
}
\examples{
## Import data
data(strat1)
data(rvc1)
## Use in stratData to create STRAT object
strata = stratData(strat1)
## Use with rvcObj to calculate domain densities
sample = rvcData(rvc1, species = "epi mori")
domain(sample, strata)
}
\keyword{datasets}

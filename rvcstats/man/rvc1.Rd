\name{rvc1}
\alias{rvc1}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
Simulated RVC data
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
Simulated data for three years of sampling (\strong{not actual data}) and two species, the Mangrove Snapper (\emph{Lutjanus griseus}), and the Red Grouper (\emph{Epinephelus morio}) 
}
\usage{data(rvc1)}
\format{
  A data frame with 8019 observations on the following 7 variables.
  \describe{
    \item{\code{YEAR}}{a numeric vector indicating the year}
    \item{\code{STRAT}}{a factor with levels: \code{INPR} Inshore patch reef, \code{MCPR} Mid-channel patch reef, \code{OFPR} Offshore patch reef, \code{FSLR} Fore-reef shallow low-relief, \code{FMLR} Fore-reef medium depth low-relief,  \code{FDLR} Fore-reef deep low-relief, and \code{HRRF} High relief reef}
    \item{\code{PRIMARY_SAMPLE_UNIT}}{A factor with different codes for every primary sample unit}
    \item{\code{STATION_NR}}{a numeric vector indicating the secondary sample at a given primary sampling unit}
    \item{\code{SPECIES_CD}}{a factor with codes for each species composed of the first three letters of the generic name and the first four letters of the specific name. In this case \code{LUT GRIS} and \code{EPI MORI}}
    \item{\code{NUM}}{a numeric vector indicating the count averaged among divers at a given secondary unit}
    \item{\code{LEN}}{a numeric vector indicating the length class observed at a secondary sampling unit}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
The generating function for density for both species at all strata and years was a poisson distribution with a lambda of 0.25, for length it was a normal distribution with a mean of 40 and a standard deviation of 10. 
}
\examples{
## get rvc data
data(rvc1)
## get stratum data
data(strat1)
## Calculate domain level density for all species and years
sample = rvcData(data = rvc1, species = c("EPI MORI", "LUT GRIS"))
strata = stratData(data = strat1)
## Calculate the density
d = domain(sample, strata)

## Plot the density
require(ggplot2)
ggplot(data = d, aes(x = YEAR, y = yi, color = factor(SPECIES_CD))) +
geom_point() + 
geom_errorbar(aes(ymin = yi-2*se, ymax = yi+2*se), size = 1, width = 0.25) + scale_color_discrete("Species") + scale_y_continuous("Density", limits = c(0,1)) + scale_x_continuous("Year", breaks = c(2011,2012, 2013)) 
} 
\keyword{datasets}

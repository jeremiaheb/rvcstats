rvcstats
========

# Reef Visual Census statistical package in R

## Description
The rvcstats package is designed to compute summary statistics, such as: fish density, frequency of occurrence, and length frequencies for Reef Visual Census data, which can then be output to csv files or turned into graphs.

## Installation
### The Easy Way
1. In R, type the following:
```
install.packages('devtools')
devtools::install_github('harryganz/rvcstats/rvcstats')
```
You can skip the first line if you already have devtools installed.

The disadvantage of this is that it makes you download R devtools first.

### The Hard Way
1. Download the compressed tar ball named "rvcstats_[version].tar.gz" from the root directory of this project
2. Open up windows command prompt
  * Go to start menu
  * In the search bar type cmd
  * Click on the command prompt application
3. In the command prompt navigate to where you downloaded the tarball
  * Type "cd [directory containing tar ball]" (e.g. cd C:\Users\John Smith\Downloads\)
4. Type "R CMD INSTALL rvcstats\_[version].tar.gz", where [version] is version name in the file (e.g. rvcstats\_0.1.1.tar.gz)
  * Make sure that "INSTALL" is capitalized
5. It should install to your R library. To make sure, open up R and type library(rvcstats). If it successfully installed, you should not get any errors.

## How to use this package
First, read the data off the server using the rvcData function. Best practice is to pull off
all the data you will need first then break it in to smaller chunks, if necessary,
for analysis.
* Note: only one region can be pulled off at a time

```
## Pull data for red (Epinephelus morio) and black grouper (Mycteroperca bonaci)
## off of the server for 2010-2012 in the florida keys
grouper <- rvcData(species = c('Epinephelus morio', 'MYC BONA'), year = 2010:2012,
region = 'FLA KEYS')
```
The rvcData and select functions output RVC objects which are basically lists of the 'analysis ready' sample data and stratum data, but the output is fairly raw and not useful without knowledge of how the Reef Visual Census is conducted.

If you would like to do statistics on only one species you can use the select function.

```
## Select red grouper from grouper
red_grouper <- select(grouper, species = "EPI MORI")
```

The select function can also be used to select specific years, strata, and protected statuses. Complete function
descriptions for rvcData and select can be found in the R help files for each function (type ?function\_name into the interactive console, where function\_name is the name of the function you need help with).

Once you have subset the data, you can calculate summary statistics using the getStat function.

```
## Density for red grouper, with protected and unprotected areas
## merged together
red_grouper_dens <- getStat(red_grouper, level = "domain", stat = "density",
merge_protected = TRUE)

## Utilizing the when_present argument, you can calculate density when present
## Here the statistic is being calculated at the stratum level
reg_grouper_dens_when_pres <- getStat(red_grouper, level = "stratum",
stat = "density", when_present = TRUE)

## Options from select can also be passed to the getStat function
## Here we have black grouper occurrence with protected
## and unprotected areas calculated separately
black_grouper_occ <- getStat(grouper, species = "MYC BONA", level = "domain",
stat = "occurrence")
```

There are three required arguments for getStat:
* x: the RVC object produced by either the rvcData function or the select function. It should contain all the species, years, and strata for which you wish to calculate summary statistics
* level: a keyword of either "domain" or "stratum" indicating the level at which you wish to calculate the summary statistic
* stat: a keyword indicating the summary statistic you wish to calculate, the available statistics are:
	* "density": The average number of individuals counted per sampling station (177m^2)
	* "occurrence": The estimated probability of encountering an individual in a sampling station.
	* "abundance": The estimated total count extrapolated over the sampling domain
	* "length_frequency": The estimated frequency of a set of lengths generated from observed data
		* the length frequency data is generated from the minimum median and maximum length at each station fit to a probability distribution.
	* "biomass": The estimated total biomass extrapolated over the sampling domain
		* Requires allometric growth parameters to be input, see the growth_parameters argument description below.

**NOTE**: All of the above statistics are indices, not model-based estimates. They indicate the synoptic count data, and any conclusions drawn from them are subject to the relationship between counts and actual abundance.  

Optional arguments are:
* when_present: a boolean indicating whether or not to calculate the statistic only for stations where the species was presents (default = FALSE)
	* NOTE: Can only be used if only one species selected, and for density/abundance
* merge_protected: a boolean indicating whether the statistic should be calculated for both protected and unprotected areas together (TRUE) or separately (FALSE), the default is FALSE.
* growth_parameters: a list of the allometric growth parameters, including one named, 'a', the linear coefficient, and, 'b', the exponential coefficient. Only required if stat = 'biomass', otherwise NULL.
* length_class: a number indicating a break point between two length classes, such as the breakpoint between immature and mature individuals or non-exploitable and exploitable individuals. Break is non-inclusive for the lower interval and inclusive for the upper (i.e. lower > break >= upper).
	* NOTE: Can only be used if one species selected

## A short list of functions and their descriptions
1. rvcData(species, year, stratum, server): Pulls data off the server by the provided arguments and produces an RVC object.
2. select(x, species, year, stratum, protected): subsets an RVC object x to produce a new RVC object.
3. getStat(x, level, stat, growth\_parameters, merge\_protected, when\_present, length\_class): produces a data.frame of summary statistics, 'stat', from an RVC object, 'x', at the level, 'level', with the other options provided.

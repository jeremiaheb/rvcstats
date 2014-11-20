rvcstats
========

# Reef Visual Census statistical package in R

## Description
The rvcstats package is designed to compute summary statistics, such as: fish density, frequency of occurrence, and length frequencies for Reef Visual Census data, which can then be output to csv files or turned into graphs. 

## Installation 
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
1. Besides the actual R package, you will need two other things to start working with the RVC data:
  * A .csv or .txt file containing the "analysis ready" reef visual census sampling data
  * A .csv or .txt file containing the names and total number of possible primary sampling units per stratum per year
2. Once you have these data files you can turn them into data.frames in R by using the read.table or read.csv functions
  * Example:
  ``` 
    sample = read.csv("rvcdata.csv")
    strata = read.txt("stratadata.csv")
  ```
3. Now you can finally start using the package, below are some examples (executable directly):
 * Examples:
  ```
	require(rvcstats)
	## Load example simulated datasets in package
	data(sample) #RVC sample data
	data(strata) #Stratum data
	
	## Print them out to take a look at them
	print(sample)
	print(strata)
	## The variable names in these tables are what the functions in this package expect,
	## however, they do not need to be uppercase
	
	##Calculate domain level densities and occurrence for African Swallows from year 1..2
	domainDensity(sample_data = sample, stratum_data = strata, species = "African Swallow")
	domainOccurrence(sample_data = sample, stratum_data = strata, species = "African Swallow")
	
	## Calculate stratum level occurrence for European Swallows in the stratum "SPAM" in year 1
	stratOccurrence(sample, strata, "EUR SWAL", strata = "SPAM", years = 1)
	
	## Note that the species argument can be the full species (scientific) name, or the species
	## code
	
	## For lower level functions you first generate an RVC object using the rvcData function
	## Then you can plug that object in to strat, domain, or other lower-level functions
	# Generate RVC object
	r <- rvcData(sample, strata, species = c("EUR SWAL", "AFR SWAL"), includes_protected = TRUE)
	## Stratum level occurrence estimates
	strat(r, calc = "p")
	## Stratum level density estimates
	strat(r, calc = "d")
	## Domain level density estimates
	domain(r)

	## As of right now length frequency is only a lower-level function, lets take a look at length
	## length frequencies for these species
	r <- rvcData(sample, strata, species = c("eur swal", "afr swal"))
	stratLenFreq(r)
	domainLenFreq(r)
	
	## We can also calculate the optimal number of primary samples for a given coef. of variance
	## domainNstar and stratNStar are currently only lower-level funtions
	r <- rvcData(sample, strata, species = c("eur swal", "afr swal"))
	domainNStar(cv = 30, rvcObj = r)
	stratNStar(cv = 30, rvcObj = r)
    ```
 ## List of functions and short descriptions
 This list is subject to change
 - Low-Level
  	* rvcData: Checks the RVC sample data and subsets by provided species, years, and strata. 
  	* strat: Calculates stratum level densities or occurrence
  	* domain: Calculates domain level densities or occurrence
	* stratLenFreq: Calculates the stratum level length frequencies
	* domainLenFreq: Calculates the domain level length frequencies
	* domainNStar: Calculates the optimal number of primary samples for the sampling domain
	* stratNStar: Calculates the optimal number of priamry samples per stratum
 - High-Level
  	* domainDensity: A wrapper for domain that explicitly measures density from original dataframes
  	* domainOccurrence: A wrapper for domain that explicitly measures occurrence from original dataframes
  	* stratDensity: A wrapper for strat that explicitly measures density from original dataframes
  	* stratOccurrence: A wrapper for strat that explicitly measures occurrence from original dataframes
 
 **It is suggested that beggining users use the high level functions to avoid possible errors**
  
  

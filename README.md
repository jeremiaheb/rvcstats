rvcstats
========

# Reef Visual Census statistical package in R

## Description
The rvcstats package is designed to compute summary statistics, such as: fish density, frequency of occurence, and length frequencies for Reef Visual Census data, which can then be output to csv files or turned into graphs. 

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
  data(rvc2) #RVC sample data
  data(strat2) #Stratum data
   ### Calculate domain level densities for Red Grouper for years 2011..2013
    domainDensity(sample.data = rvc2, stratum.data = strat2, species = "Epinephelus morio", years = 2011:2013)
   ## Calculate stratum level occurrence for Grey Snapper on patch reef strata
    stratOccurrence(rvc2, strat2, species = "LUT GRIS", strata = c("INPR", "MCPR", "OFPR"))
   ## Calculate the length frequency of Red Grouper in 2011 
    lenFreq(rvc2, "epi mori", years = 2011)
   ## Calculate the length frequency of Grey Snapper, but aggregate by year and protected status
    lenFreq(rvc2, species = "LUT GRIS", agg.by = c("YEAR", "PROT"))
    ```
 ## List of functions and short descriptions
 This list is subject to change
 - Low-Level
  	* rvcData: Checks the RVC sample data and subsets by provided species, years, and strata. 
  	* stratData: Checks the stratum data and subsets by provided species, years, and strata.
  	* lenFreq: Outputs a table of length frequencies aggregated by variables provided by the user (e.g. year, strata, etc)
  	* strat: Calculates stratum level densities or occurrence
  	* domain: Calculates domain level densities or occurrence
 - High-Level
  	* domainDensity: A wrapper for domain that explicitly measures density from original dataframes
  	* domainOccurrence: A wrapper for domain that explicitly measures occurrence from original dataframes
  	* stratDensity: A wrapper for strat that explicitly measures density from original dataframes
  	* stratOccurrence: A wrapper for strat that explicitly measures occurrence from original dataframes
 
 **It is suggested that beggining users use the high level functions to avoid possible errors**
  
  

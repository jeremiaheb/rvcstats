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
4. Type "R CMD INSTALL rvcstats_[version].tar.gz", where [version] is version name in the file (e.g. rvcstats_0.1.1.tar.gz)
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
   ### Calculate domain level densities for Red Grouper for years 2000..2005
    domainDensity(sample.data = sample, stratum.data = strata, species = "Epinephelus morio", years = 2000:2005)
   ## Calculate stratum level occurrence for Grey Snapper 
  
  

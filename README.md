rvcstats
========

Reef Visual Census statistical package in R
-------------------------------------------

### Description:
This project contains two R packages: rvcstats and testrvcstats. 
  * rvcstats contains sets of functions for producing summary statistics and graphs from analysis ready
  data files from the South Florida Reef Visual Census (RVC), which are kept and maintained by the Southeast
  Fisheries Science Center (SEFSC). 
  * testrvcstats is a package containing functions and data intended to test the rvcstats package. 

### Guidelines for Developers:
General information on how to write R extenstions can be found at http://cran.r-project.org/doc/manuals/r-release/R-exts.html

### Specific Guidelines for this project are listed below:
1.) Function names should: 
  * Contain full words and not abbreviations (e.g. density not dens)
  * Not use periods to seperate words (e.g. densityPlot not density.plot)
  * Be all lowercase, except when made of multiple words, in which case the first letter of each subsequent word
    should be capitalized (e.g. timeSeries not TimeSeries)
  * Not be made up of more than three words, excepting two letter words such as 'is' or 'as' (e.g. timeSeriesPlot not
    rvcTimeSeriesPlot)
2.) Class names should:
  * be have the first letter of each word capitalized (e.g. RvcStatsObject not rvcStatsObject)
  * Use full words and not abbreviations
  * not use periods to seperate words
  * S3 and S4 classes are hard to implement, so this likely will not matter
3.) Parameter names should:
  * be whole words
  * be lowercase
  * use periods to seperate multiple words (e.g. gear.type not gearType)
  * not be made up of more than three words, excepting two letter words (e.g. is.habitat.class not habitat.class.fits.with)
4.) Local variables names should (declared within methods or loops)
  *  be entirely lowercase
  *  be abbreviations (can be formed however makes most sense)
  *  be no longer than 6 characters
5.) Static variable names should
  * be entirely uppercase
  * be abbreviations 
  * be no longer than 8 characters
  * NEVER have functions spit out global variables
6.) Comments on methods 
  * For functions: should start with 'Returns:' or 'Yields:' and indicate the type(s) of data returned as well
    as the parameter names and the type(s) of data inputted (e.g. Returns: a numeric vector of fish densities given,
    a numeric vector of frequencies, 'frequency', and a numeric vector of areas, 'area')
  * For procedures: Should start with 'Does:' and include the type of input, if applicable (e.g. Does: a plot
  of a time series given a numeric vector of densities, 'density', and a factor vector of years, 'year')
7.) Comments within methods
  * Should be whole sentences
8.) Help Documentation:
  * Should follow the format of standard help documentation for base R package
  * Please include links to relevant functions
  * Make sure to include useful examples

### Other Guidelines:
1.) Write help files and specifications for a function before writing the function
2.) It would be great if everyone wrote the test for a function in testrvcstats before writing the actual function in
  rvcstats, but there are some functions for which this is difficult (e.g. plotting)
3.) Remember to FETCH current branch before PUSHING any changes 
4.) When in doubt, make a new branch

## Helper: The base functionality of getStat. Produces the appropriate
## statistic given manipulation of data based on options
getStatBase  <- function(x, level, stat, growth_parameters,
                          merge_protected, when_present){
  # If level == "stratum" use stratum level functions
  # if level == "domain" use domain level functions
  # else return error
  if (level == "stratum"){
    out  <- strat(x, stat, growth_parameters, merge_protected);
  } else if (level == "domain") {
    out  <- domain(x, stat, growth_parameters, merge_protected, when_present)
  } else {stop("level must be 'stratum' or 'domain'")}
  # Set name and return
  names(out)[names(out) == "yi"] = stat;
  return(out)
}
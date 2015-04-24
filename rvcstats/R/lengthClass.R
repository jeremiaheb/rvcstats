## Helper: Handles length_class in getStatSingle function
lengthClass  <- function(x, length_class, level, stat,
                         growth_parameters, merge_protected,
                         when_present){
  #If length_class is LM, set length_class to LM from lhp_data
  if (length_class == "LM"){
    length_class = x$lhp_data$LM
    if(isBlank(length_class)){
      stop("length_at_maturity not found, please enter it manually")
    }
  }
  #If length_class is LC, set length_class to LC from lhp_data
  if (length_class == "LC"){
    length_class = x$lhp_data$LC
    if(isBlank(length_class)){
      stop("length_at_capture not found, please enter it manually")
    }
  }
  # Make three clones of the input data
  lwr  <- x;
  upr  <- x;
  all  <- x;
  # Subset lwr and upr to not include unlengthed fish
  lwr$sample_data  <- subset(lwr$sample_data, LEN >= 0);
  upr$sample_data  <- subset(upr$sample_data, LEN >= 0);
  # Subset lwr and upr for each length class and make a list
  lwr$sample_data$NUM  <- with(lwr$sample_data, ifelse(LEN < length_class, NUM, 0));
  upr$sample_data$NUM  <- with(upr$sample_data, ifelse(LEN >= length_class, NUM, 0));
  l  <- list(lwr, upr, all);
  # Apply getStatSingle to each
  lout  <- lapply(l, function(z){
    getStatSingle(z, level, stat, growth_parameters, merge_protected,
            when_present, length_class = NULL)
  });
  # Append length_class to output data.frames
  lout[[1]]$length_class  <- rep(paste("<", length_class, sep = ""), 
                                 nrow(lout[[1]]));
  lout[[2]]$length_class  <- rep(paste(">=", length_class, sep = ""), 
                                 nrow(lout[[2]]));
  lout[[3]]$length_class  <- rep("all", nrow(lout[[3]]));
  # Rbind and return
  out  <- do.call(rbind, lout)
  return(out)
}
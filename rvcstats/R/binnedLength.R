## Helper: Returns a data.frame of length frequencies
## binned by bin_width
binnedLength  <- function(x, bin_width, level, merge_protected){
  labs  <- with(x,
                seq(bin_width/2, max(LEN), bin_width)
                );
  bins  <- with(x,as.numeric(as.character(
                cut(LEN, seq(0,max(LEN)+bin_width/2,bin_width),
                    labels = labs)
                )));
  out  <- with(x,
               aggregate(
                 list(length_frequency=length_frequency),
                 by = data.frame(aggBy(level, "abundance", merge_protected), LEN = bins),
                 FUN = sum, na.rm = TRUE
                 )
               );
  return(out)
}
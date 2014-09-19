## Class: With fields for every secondary sampling station
Station = setRefClass("Station",
                     fields = list(num = "numeric", len = "numeric", species_nr = "numeric",
                     time_seen = "numeric", station_nr = "numeric", depth = "numeric",
                     underwater_visibility = "numeric"))
## Returns: Getters and setters for every field listed
Station$accessors(c("num", "len", "species_nr", "time_seen", "station_nr",
                    "depth", "underwater_visibility"))
Station$methods(
  ## Init: Initializes required fields, other fields are initialized as NULL
  initialize = function(num, len, species_nr, station_nr, time_seen, depth = NULL, 
                        underwater_visibility = NULL){
    setNum(num); setLen(len); setSpecies_nr(species_nr); setTime_seen(time_seen);
    setStation_nr(station_nr); setDepth(depth);
    setUnderwater_visibility(underwater_visibility)
  }
  )
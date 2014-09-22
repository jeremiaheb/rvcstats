## Class: With fields for every secondary sampling unit
SSU = setRefClass("SSU",
                     fields = list(num = "numeric", len = "numeric", species_nr = "numeric",
                     time_seen = "numeric", station_nr = "numeric", depth = "numeric",
                     underwater_visibility = "numeric", area = "numeric", 
                     density = "numeric"))
## Returns: Getters and setters for every field listed
SSU$accessors(c("num", "len", "species_nr", "time_seen", "station_nr",
                    "depth", "underwater_visibility", "area", "density"))
SSU$methods(
  ## Init: Initializes required fields, other fields are initialized as numeric vector
  ## of length zero
  initialize = function(num, len, species_nr, station_nr, time_seen, depth = numeric(0), 
                        underwater_visibility = numeric(0), area = 177){
    setNum(num); setLen(len); setSpecies_nr(species_nr); setTime_seen(time_seen);
    setStation_nr(station_nr); setDepth(depth);setArea(area)
    setUnderwater_visibility(underwater_visibility);
    density <<- num/area
  }
  )
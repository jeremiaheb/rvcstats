context("testing aggBy helper method")
# A list of variables that might be used
# in aggBy
l  <- list(
  YEAR = 2012,
  REGION = 'FLA KEYS',
  STRAT = 'FDLR',
  PROT = 1,
  PRIMARY_SAMPLE_UNIT = '001u',
  STATION_NR = 1,
  SPECIES_CD = 'LUT GRIS',
  LEN = 25,
  NUM = 0.5
  );
names  <- c("YEAR", "REGION", "STRAT",
            "PROT", "PRIMARY_SAMPLE_UNIT",
            "STATION_NR", "SPECIES_CD");

ssu  <- with(l,aggBy("ssu", "density", merge_protected = FALSE));
psu  <- with(l, aggBy("psu", "length_frequency", merge_protected = TRUE));
strat  <- with(l, aggBy("stratum", "occurrence"));
domain  <- with(l, aggBy("domain","biomass"));
test_that(
  "test aggBy",
  {
    expect_true(length(setdiff(names, names(ssu))) == 0);
    expect_equal(ssu,l[names(ssu)]);
    expect_true(all(setdiff(names(psu),names) %in% c("STATION_NR", "LEN", "PROT")));
    expect_true(all(setdiff(names, names(strat)) %in% c("STATION_NR","PRIMARY_SAMPLE_UNIT")));
    expect_true(all(setdiff(names, names(domain))%in% c("STATION_NR","PRIMARY_SAMPLE_UNIT", "STRAT")));
    
    
  }
  )
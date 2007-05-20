# Test of handling CTD data
library(oce)
sealevel <- read.sealevel("h275a99.dat")
stopifnot(sealevel$station.name == "Halifax")

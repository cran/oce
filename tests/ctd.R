# Test of handling CTD data
library(oce)
profile <- oce::read.ctd("ctd01.cnv",debug=TRUE)
summary(profile)

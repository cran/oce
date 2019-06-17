## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ------------------------------------------------------------------------
library(oce)
data(coastlineWorldFine, package="ocedata")
lon <- coastlineWorldFine[["longitude"]]
lat <- coastlineWorldFine[["latitude"]]
par(mar=c(4, 4, 0.5, 0.5))
plot(lon, lat, type="l",
     xlim=c(-80, -50), ylim=c(40, 50))

## ------------------------------------------------------------------------
par(mar=c(4, 4, 0.5, 0.5))
plot(lon, lat, type="l",
     xlim=c(-80, -50), ylim=c(40, 50), asp=1/cos(45*pi/180))

## ------------------------------------------------------------------------
plot(coastlineWorldFine,
     longitudelim=c(-69, -57), latitudelim=c(43, 47))

## ------------------------------------------------------------------------
data(coastlineWorld)

## ----fig.height=3--------------------------------------------------------
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld)

## ------------------------------------------------------------------------
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld, longitudelim=c(-130, 50), latitudelim=c(60, 120),
       projection="+proj=stere +lat_0=90", col='gray')

## ------------------------------------------------------------------------
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld,
         longitudelim=c(-130,-55), latitudelim=c(35, 60),
         projection="+proj=lcc +lat_0=30 +lat_1=60 +lon_0=-100", col='gray')

## ----fig.height=3--------------------------------------------------------
par(mar=rep(0.5, 4))
mapPlot(coastlineWorld, col="lightgray", projection="+proj=robin")

## ------------------------------------------------------------------------
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld, longitudelim=c(-180, 180), latitudelim=c(-130, -50),
       projection="+proj=stere +lat_0=-90", col='gray', grid=15)

## ------------------------------------------------------------------------
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorldFine, col="lightgray",
        projection="+proj=merc",
        longitudelim=c(-80, -40), latitudelim=c(20, 60))

## ------------------------------------------------------------------------
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorldFine, col="lightgray",
        projection="+proj=aea +lat_1=30 +lat_2=50 +lon_0=-60",
        longitudelim=c(-80, -40), latitudelim=c(20, 60))

## ----fig.height=3--------------------------------------------------------
par(mar=rep(0.5, 4))
data(levitus, package="ocedata")
mapPlot(coastlineWorld, col="lightgray")
mapContour(levitus[['longitude']], levitus[['latitude']], levitus[['SST']])


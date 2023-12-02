## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE, comment="#>")

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("sf")

## ----fig.cap="Distorted North American view, without control of aspect ratio.", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
library(oce)
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
par(mar=c(4, 4, 0.5, 0.5))
plot(lon, lat, type="l",
    xlim=c(-130, -50), ylim=c(40, 50))

## ----fig.cap="North American view, with distortion limited by choice of aspect ratio.", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(4, 4, 0.5, 0.5))
plot(lon, lat, type="l",
    xlim=c(-130, -50), ylim=c(40, 50), asp=1/cos(45*pi/180))

## ----fig.cap="North American view, drawn with mapPlot().", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
plot(coastlineWorld, clongitude=-90, clatitude=45, span=7000)

## -----------------------------------------------------------------------------
data(coastlineWorld)

## ----fig.cap="World coastline with default (Mollweide) projection.", fig.width=5, fig.height=2.7, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld, col="lightgray")

## ----fig.cap="Polar view with stereographic projection.", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld, longitudelim=c(-180, 180), latitudelim=c(60, 90),
    projection="+proj=stere +lat_0=90 +lat_ts=90", col="gray")

## ----fig.cap="Canada in Lambert Conformal projection.", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld,
    longitudelim=c(-130, -55), latitudelim=c(45, 70),
    projection="+proj=lcc +lat_1=50 +lat_2=65 +lon_0=-100", col="gray")

## ----fig.cap="World coastline with Robinson projection (exercise 1).", fig.width=5, fig.height=2.7, dpi=72, dev.args=list(pointsize=10)----
par(mar=rep(0.5, 4))
mapPlot(coastlineWorld, col="lightgray", projection="+proj=robin")

## ----fig.cap="World topography with Mollweide projection (exercise 2).", fig.width=5, fig.height=2.7, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(1.5, 1, 1.5, 1))
data(topoWorld)
topo <- decimate(topoWorld, 2) # coarsen grid: 4X faster plot
lon <- topo[["longitude"]]
lat <- topo[["latitude"]]
z <- topo[["z"]]
cm <- colormap(name="gmt_globe")
drawPalette(colormap=cm)
mapPlot(coastlineWorld, projection="+proj=moll", grid=FALSE, col="lightgray")
mapImage(lon, lat, z, colormap=cm)

## ----fig.cap="Antarctica (exercise 3).", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld, longitudelim=c(-180, 180), latitudelim=c(-130, -50),
    projection="+proj=stere +lat_0=-90", col="gray", grid=15)

## ----fig.cap="Eastern Canadian waters shown in Universal Transverse Mercator projection.", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld, col="lightgray",
    projection="+proj=utm +zone=20",
    longitudelim=c(-85, -45), latitudelim=c(40, 60))

## ----fig.cap="Eastern North Atlantic with Albers equal-area projection (exercise 5).", fig.width=3, fig.height=3, dpi=72, dev.args=list(pointsize=10)----
par(mar=c(1.5, 1.5, 0.5, 0.5))
mapPlot(coastlineWorld, col="lightgray",
    projection="+proj=aea +lat_1=45 +lat_2=55 +lon_0=-65",
    longitudelim=c(-85, -45), latitudelim=c(40, 60))

## ----fig.cap="SST contours with the Goode projection (exercise 6)", fig.width=5, fig.height=2.7, dpi=72, dev.args=list(pointsize=10)----
par(mar=rep(0.5, 4))
mapPlot(coastlineWorld, projection="+proj=goode", col="lightgray")
if (requireNamespace("ocedata", quietly=TRUE)) {
    data(levitus, package="ocedata")
    mapContour(levitus[["longitude"]], levitus[["latitude"]], levitus[["SST"]])
}


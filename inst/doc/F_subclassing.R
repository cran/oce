## ---- echo=FALSE--------------------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE, comment="#>")

## -----------------------------------------------------------------------------
library(oce)
load(system.file("extdata", "drifter.rda", package="oce"))
str(db)

## -----------------------------------------------------------------------------
o <- new("oce")

## -----------------------------------------------------------------------------
summary(o)

## -----------------------------------------------------------------------------
o <- oceSetData(o, "time", db$t)
o <- oceSetData(o, "longitude", db$lon)
o <- oceSetData(o, "latitude", db$lat)
o <- oceSetMetadata(o, "ID", 4201703)

## -----------------------------------------------------------------------------
summary(o)

## -----------------------------------------------------------------------------
str(o[["latitude"]])

## ----fig.cap="**Figure 1.** Demonstration of base-level plot()."--------------
plot(o)

## -----------------------------------------------------------------------------
drifter <- setClass(Class="drifter", contains="oce")

## -----------------------------------------------------------------------------
d <- new("drifter")

## -----------------------------------------------------------------------------
setMethod(f="initialize",
  signature="drifter",
  definition=function(.Object, time, longitude, latitude, ID="unknown") {
      if (missing(time))
          stop("In new(drifter) : must provide 'time'", call.=FALSE)
      if (missing(longitude))
          stop("In new(drifter) : must provide 'longitude'", call.=FALSE)
      if (missing(latitude))
          stop("In new(drifter) : must provide 'latitude'", call.=FALSE)
      .Object@data$time <- time
      .Object@data$longitude <- longitude
      .Object@data$latitude <- latitude
      .Object@metadata$ID <- ID
      .Object@processingLog$time <- presentTime()
      .Object@processingLog$value <- "create 'drifter' object"
      return(.Object)
})

## -----------------------------------------------------------------------------
d <- new("drifter", time=db$t, longitude=db$lon, latitude=db$lat, ID=4201703)

## -----------------------------------------------------------------------------
setMethod(f="plot",
    signature=signature("drifter"),
    definition=function(x, which=1, ...) {
        lonlab <- expression("Longitude ["*degree*"E]")
        latlab <- expression("Latitude ["*degree*"N]")
        if (which == 1) {
            oce.plot.ts(x[["time"]], x[["longitude"]],
                ylab=lonlab, ...)
        } else if (which == 2) {
            oce.plot.ts(x[["time"]], x[["latitude"]],
                ylab=latlab,...)
        } else if (which == 3) {
            asp <- 1 / cos(mean(range(x[["latitude"]]) * pi / 180))
            plot(x[["longitude"]], x[["latitude"]],
                asp=asp, xlab=lonlab, ylab=latlab, ...)
        } else {
            stop("In plot,drifter-method : try which=1, 2 or 3", call.=FALSE)
        }
    })

## ----fig.cap="**Figure 2.** Demonstration of specialized plot()."-------------
par(mar=c(3.3,3.3,1,1), mgp=c(2,0.7,0))
layout(matrix(c(1,3,2,3),nrow=2,byrow=TRUE))
plot(d, which=1, drawTimeRange=FALSE)
plot(d, which=2, drawTimeRange=FALSE)
plot(d, which=3)

## -----------------------------------------------------------------------------
setMethod(f="summary",
    signature="drifter",
    definition=function(object, ...) {
        cat("CTD Summary\n-----------\n\n")
        cat("* ID:          ", object[["ID"]], "\n", sep="")
        invisible(callNextMethod())
    })

## -----------------------------------------------------------------------------
summary(d)

## -----------------------------------------------------------------------------
setMethod(f="[[",
    signature(x="drifter", i="ANY", j="ANY"),
    definition=function(x, i, j, ...) {
        if (i == "velocity") {
            D <- function(x) {
                dx <- diff(x)
                c(dx[1], dx)
            }
            dist <- geodDist(x[["longitude"]], x[["latitude"]])
            lat <- x[["latitude"]]
            lon <- x[["longitude"]]
            dt <- D(as.numeric(x[["time"]])) # seconds
            scalex <- 111.12e3         # m per degree latitude
            scaley <- scalex * cos(lat*pi/180)
            u <- scalex * D(lon) / dt
            v <- scaley * D(lat) / dt
            list(u=u, v=v)
        } else {
            callNextMethod()
        }
    })

## ----fig.cap="**Figure 3.** Velocities inferred from drifter motion."---------
uv <- d[["velocity"]]
par(mfrow=c(2,1))
oce.plot.ts(d[["time"]], uv$u, ylab="Eastward velocity [m/s]", grid=TRUE)
oce.plot.ts(d[["time"]], uv$v, ylab="Northward velocity [m/s]", grid=TRUE)

## ----fig.cap="**Figure 4.** Autocorrelation analysis of drifter velocities, showing also the M2 period."----
data(tidedata)
M2period <- 1 / with(tidedata$const, freq[[which(name=="M2")]])
uv <- d[["velocity"]]
par(mfrow=c(2,1), mar=c(3,3,1,1), mgp=c(2,0.7,0))
acf(uv$u, main="", ylab="u ACF")
abline(v=M2period, col=2)
acf(uv$v, main="", ylab="v ACF")
abline(v=M2period, col=2)


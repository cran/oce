## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ------------------------------------------------------------------------
library(oce)
wave <- setClass(Class="wave", contains="oce")

## ------------------------------------------------------------------------
w <- new("wave")

## ------------------------------------------------------------------------
class(w)

## ------------------------------------------------------------------------
inherits(w, "wave")

## ------------------------------------------------------------------------
str(w)

## ------------------------------------------------------------------------
w[["metadata"]]

## ------------------------------------------------------------------------
w[["data"]]

## ------------------------------------------------------------------------
w[["metadata"]]$station <- "STN01"

## ------------------------------------------------------------------------
str(w)

## ------------------------------------------------------------------------
w <- oceSetMetadata(w, "serialNumber", 1234)

## ------------------------------------------------------------------------
str(w[["metadata"]])

## ------------------------------------------------------------------------
t <- as.POSIXct("2019-01-01 00:00:00", tz="UTC") + seq(0, 30, length.out=100)
tau <- 10
e <- sin(as.numeric(2 * pi * as.numeric(t) / tau)) + rnorm(t, sd=0.01)

## ------------------------------------------------------------------------
w <- oceSetData(w, "time", t)
w <- oceSetData(w, "elevation", e)

## ------------------------------------------------------------------------
summary(w)

## ------------------------------------------------------------------------
w <- oceSetData(w, "elevation", e, unit=list(unit=expression(m),scale=""))

## ------------------------------------------------------------------------
summary(w)

## ------------------------------------------------------------------------
setMethod(f="plot",
    signature=signature("wave"),
    definition=function(x, which=1, ...) {
        if (which == 1) {
            plot(x[["time"]], x[["elevation"]], ...)
        } else if (which == 2) {
            hist(x[["elevation"]], ...)
        } else {
            stop("which must be 1 or 2")
        }
    })

## ------------------------------------------------------------------------
plot(w)

## ------------------------------------------------------------------------
plot(w, type="l", xlab="Time [s]", ylab="Elevation [m]")

## ------------------------------------------------------------------------
setMethod(f="initialize",
    signature="wave",
    definition=function(.Object, time, elevation, units) {
        if (missing(units)) {
            .Object@metadata$units <- list()
            if (missing(units))
                .Object@metadata$units$elevation <- list(unit=expression(m), scale="")
        }
        .Object@data$time <- if (missing(time)) NULL else time
        .Object@data$elevation <- if (missing(elevation)) NULL else elevation
        .Object@processingLog$time <- presentTime()
        .Object@processingLog$value <- "create 'wave' object"
        return(.Object)
    }
)

## ------------------------------------------------------------------------
ww <- new("wave", time=t, elevation=e)
summary(ww)

## ------------------------------------------------------------------------
setMethod(f="[[",
    signature(x="wave", i="ANY", j="ANY"),
    definition=function(x, i, j, ...) {
        if (i == "peak") {
           return(max(x[["elevation"]], na.rm=TRUE))
        } else {
           callNextMethod()
        }
    }
)

## ------------------------------------------------------------------------
w[["peak"]]
str(w[["elevation"]])


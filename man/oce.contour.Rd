% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oce.R
\name{oce.contour}
\alias{oce.contour}
\alias{oceContour}
\title{Oce Variant of contour}
\usage{
oce.contour(
  x,
  y,
  z,
  revx = FALSE,
  revy = FALSE,
  add = FALSE,
  tformat,
  drawTimeRange = getOption("oceDrawTimeRange"),
  debug = getOption("oceDebug"),
  ...
)
}
\arguments{
\item{x}{values for x grid.}

\item{y}{values for y grid.}

\item{z}{matrix for values to be contoured.  The first dimension of \code{z}
must equal the number of items in \code{x}, etc.}

\item{revx}{set to \code{TRUE} to reverse the order in which the labels on
the x axis are drawn}

\item{revy}{set to \code{TRUE} to reverse the order in which the labels on
the y axis are drawn}

\item{add}{logical value indicating whether the contours should be added to
a pre-existing plot.}

\item{tformat}{time format; if not supplied, a reasonable choice will be
made by \code{\link[=oce.axis.POSIXct]{oce.axis.POSIXct()}}, which draws time axes.}

\item{drawTimeRange}{logical, only used if the \code{x} axis is a time.  If
\code{TRUE}, then an indication of the time range of the data (not the axis)
is indicated at the top-left margin of the graph.  This is useful because
the labels on time axes only indicate hours if the range is less than a day,
etc.}

\item{debug}{a flag that turns on debugging; set to 1 to information about
the processing.}

\item{\dots}{optional arguments passed to plotting functions.}
}
\description{
This provides something analogous to \code{\link[=contour]{contour()}}, but with the
ability to flip x and y.
Setting \code{revy=TRUE} can be helpful if the \code{y} data represent
pressure or depth below the surface.
}
\examples{
library(oce)
data(topoWorld)
# coastline now, and in last glacial maximum
lon <- topoWorld[["longitude"]]
lat <- topoWorld[["latitude"]]
z <- topoWorld[["z"]]
oce.contour(lon, lat, z, levels = 0, drawlabels = FALSE)
oce.contour(lon, lat, z, levels = -130, drawlabels = FALSE, col = "blue", add = TRUE)
}
\author{
Dan Kelley
}

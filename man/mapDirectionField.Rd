% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map.R
\name{mapDirectionField}
\alias{mapDirectionField}
\title{Add a Direction Field to an Existing Map}
\usage{
mapDirectionField(
  longitude,
  latitude,
  u,
  v,
  scale = 1,
  length = 0.05,
  code = 2,
  col = par("fg"),
  ...
)
}
\arguments{
\item{longitude, latitude}{numeric vectors of the starting points for arrows.}

\item{u, v}{numeric vectors of the components of a vector to be shown as a direction
field.}

\item{scale}{latitude degrees per unit of \code{u} or \code{v}.}

\item{length}{length of arrow heads, passed to \code{\link[=arrows]{arrows()}}.}

\item{code}{code of arrows, passed to \code{\link[=arrows]{arrows()}}.}

\item{col}{color of arrows.  This may be a single color, or a matrix
of colors of the same dimension as \code{u}.}

\item{\dots}{optional arguments passed to \code{\link[=arrows]{arrows()}}, e.g.
\code{angle} and \code{lwd} can be useful in differentiating different
fields.}
}
\description{
Plot a direction field on a existing map.
}
\details{
Adds arrows for a direction field on an existing map.  There are different
possibilities for how \code{longitude}, \code{latitude} and \code{u} and
\code{v} match up.  In one common case, all four of these are matrices, e.g.
output from a numerical model.  In another, \code{longitude} and
\code{latitude} are the coordinates along the matrices, and are thus stored in
vectors with lengths that match appropriately.
}
\section{Sample of Usage}{

\preformatted{
library(oce)
data(coastlineWorld)
par(mar=rep(2, 4))
mapPlot(coastlineWorld, longitudelim=c(-120,-55), latitudelim=c(35, 50),
        projection="+proj=laea +lat0=40 +lat1=60 +lon_0=-110")
lon <- seq(-120, -60, 15)
lat <- 45 + seq(-15, 15, 5)
lonm <- matrix(expand.grid(lon, lat)[, 1], nrow=length(lon))
latm <- matrix(expand.grid(lon, lat)[, 2], nrow=length(lon))
# vectors pointed 45 degrees clockwise from north
u <- matrix(1/sqrt(2), nrow=length(lon), ncol=length(lat))
v <- matrix(1/sqrt(2), nrow=length(lon), ncol=length(lat))
mapDirectionField(lon, lat, u, v, scale=3)
mapDirectionField(lonm, latm, 0, 1, scale=3, col="red")
# Color code by longitude, using thick lines
col <- colormap(lonm)$zcol
mapDirectionField(lonm, latm, 1, 0, scale=3, col=col, lwd=2)
}
}

\seealso{
A map must first have been created with \code{\link[=mapPlot]{mapPlot()}}.

Other functions related to maps: 
\code{\link{formatPosition}()},
\code{\link{lonlat2map}()},
\code{\link{lonlat2utm}()},
\code{\link{map2lonlat}()},
\code{\link{mapArrows}()},
\code{\link{mapAxis}()},
\code{\link{mapContour}()},
\code{\link{mapCoordinateSystem}()},
\code{\link{mapGrid}()},
\code{\link{mapImage}()},
\code{\link{mapLines}()},
\code{\link{mapLocator}()},
\code{\link{mapLongitudeLatitudeXY}()},
\code{\link{mapPlot}()},
\code{\link{mapPoints}()},
\code{\link{mapPolygon}()},
\code{\link{mapScalebar}()},
\code{\link{mapText}()},
\code{\link{mapTissot}()},
\code{\link{oceCRS}()},
\code{\link{shiftLongitude}()},
\code{\link{usrLonLat}()},
\code{\link{utm2lonlat}()}
}
\author{
Dan Kelley
}
\concept{functions related to maps}

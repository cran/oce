% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map.R
\name{mapImage}
\alias{mapImage}
\title{Add an Image to a Map}
\usage{
mapImage(
  longitude,
  latitude,
  z,
  zlim,
  zclip = FALSE,
  breaks,
  col,
  colormap,
  border = NA,
  lwd = par("lwd"),
  lty = par("lty"),
  missingColor = NA,
  filledContour = FALSE,
  gridder = "binMean2D",
  debug = getOption("oceDebug")
)
}
\arguments{
\item{longitude}{numeric vector of longitudes corresponding to \code{z}
matrix.}

\item{latitude}{numeric vector of latitudes corresponding to \code{z}
matrix.}

\item{z}{numeric matrix to be represented as an image.}

\item{zlim}{limit for z (color).}

\item{zclip}{A logical value, \code{TRUE} indicating that out-of-range
\code{z} values should be painted with \code{missingColor} and \code{FALSE}
indicating that these values should be painted with the nearest
in-range color.  If \code{zlim} is given then its min and max set the
range.  If \code{zlim} is not given but \code{breaks} is given, then the min
and max of \code{breaks} sets the range used for z.  If neither \code{zlim}
nor \code{breaks} is given, clipping is not done, i.e. the action is as
if \code{zclip} were \code{FALSE}.}

\item{breaks}{The z values for breaks in the color scheme.  If this
is of length 1, the value indicates the desired number of breaks,
which is supplied to \code{\link[=pretty]{pretty()}}, in determining clean break points.}

\item{col}{Either a vector of colors corresponding to the breaks,
of length 1 plus the number of breaks, or a function specifying
colors, e.g. \code{\link[=oce.colorsViridis]{oce.colorsViridis()}} for the Viridis scheme.}

\item{colormap}{optional colormap, as created by \code{\link[=colormap]{colormap()}}. If a
\code{colormap} is provided, then its properties takes precedence over
\code{breaks}, \code{col}, \code{missingColor}, and \code{zclip} specified to
\code{mapImage}.}

\item{border}{Color used for borders of patches (passed to
\code{\link[=polygon]{polygon()}}); the default \code{NA} means no border.}

\item{lwd}{line width, used if borders are drawn.}

\item{lty}{line type, used if borders are drawn.}

\item{missingColor}{a color to be used to indicate missing data, or
\code{NA} to skip the drawing of such regions (which will retain
whatever material has already been drawn at the regions).}

\item{filledContour}{an indication of whether to use filled
contours.  This may be FALSE (the default), TRUE, or a positive
numerical value. If FALSE, then polygons are used. Otherwise, the
longitude-latitude values are transformed to x-y values, which will
not be on a grid and thus will require gridding so that
\code{\link[=.filled.contour]{.filled.contour()}} can plot the filled contours.  The method used
for gridding is set by the \code{gridder} parameter (see next item). If
\code{filledContour} is TRUE, then the grid is constructed with the aim
of having approximately 3 of the projected x-y points in each cell.
That can leave some cells unoccupied, yielding blanks in the drawn
image.  There are two ways around that.  First, the \code{gridder} can
be set up to fill gaps.  Second, a numerical value can be used for
\code{filledContour}. For example, using \code{filledContour} equal to 1.5
will increase grid width and height by a factor of 1.5, which may
be enough to fill all the gaps, depending on the projection and the
area shown.}

\item{gridder}{specification of how gridding is to be done, used
only if \code{filledContour} is TRUE. The value of \code{gridder} may
\code{"binMean2D"}, which is the default, \code{"interp"}, or a function.  In
the first two cases, the gridding is done with either \code{\link[=binMean2D]{binMean2D()}}
or \code{\link[interp:interp]{interp::interp()}}, respectively. For more on the last case, see
\dQuote{Details}.}

\item{debug}{an integer specifying whether debugging information is
to be printed during the processing. This is a general parameter that
is used by many \code{oce} functions. Generally, setting \code{debug=0}
turns off the printing, while higher values suggest that more information
be printed. If one function calls another, it usually reduces the value of
\code{debug} first, so that a user can often obtain deeper debugging
by specifying higher \code{debug} values.}
}
\description{
Plot an image on an existing map that was created with \code{\link[=mapPlot]{mapPlot()}}.
}
\details{
Image data are on a regular grid in lon-lat space, but not in the
projected x-y space.  This means that \code{\link[=image]{image()}} cannot be used.
Instead, there are two approaches, depending on the value of
\code{filledContour}.

If \code{filledContour} is \code{FALSE}, the image "pixels" are drawn with
\code{\link[=polygon]{polygon()}}. This can be prohibitively slow for fine grids.

However, if \code{filledContour} is \code{TRUE}, then the "pixels" are
remapped into a regular grid and then displayed with
\code{\link[=.filled.contour]{.filled.contour()}}.  The remapping starts by converting the
regular lon-lat grid to an irregular x-y grid using \code{\link[=lonlat2map]{lonlat2map()}}.
This irregular grid is then interpolated onto a regular x-y grid in
accordance with the \code{gridder} parameter. If \code{gridder} values of
\code{"binMean2D"} and \code{"interp"} do not produce satisfactory results,
advanced users might wish to supply a function to do the gridding
according to their own criteria. The function must have as its
first 5 arguments (1) an x vector, (2) a y vector, (3) a z matrix
that corresponds to x and y in the usual way, (4) a vector holding
the desired x grid, and (5) a vector holding the desired y grid.
The return value must be a list containing items named \code{xmids},
\code{ymids} and \code{result}. To understand the meaning of the parameters
and return values, consult the documentation for \code{\link[=binMean2D]{binMean2D()}}.
Here is an example of a scheme that will fill data gaps of 1 or 2
cells:

\if{html}{\out{<div class="sourceCode">}}\preformatted{g <- function(...) binMean2D(..., fill = TRUE, fillgap = 2)
mapImage(..., gridder = g, ...)
}\if{html}{\out{</div>}}
}
\section{Historical Notes}{


Until oce 1.7.4, the \code{gridder} argument could be set to \code{"akima"},
which used the \code{akima} package.  However, that package is not
released with a FOSS license, so CRAN requested a change to
\CRANpkg{interp}. Note that \code{drawImage()} intercepts the errors
that sometimes get reported by \code{\link[interp:interp]{interp::interp()}}.
}

\section{Sample of Usage}{


\preformatted{
library(oce)
data(coastlineWorld)
data(topoWorld)

# Northern polar region, with color-coded bathymetry
par(mfrow = c(1, 1), mar = c(2, 2, 1, 1))
cm <- colormap(zlim = c(-5000, 0), col = oceColorsGebco)
drawPalette(colormap = cm)
mapPlot(coastlineWorld,
    projection = "+proj=stere +lat_0=90",
    longitudelim = c(-180, 180), latitudelim = c(70, 110)
)
# Uncomment one of the next four blocks.  See
# https://dankelley.github.io/dek_blog/2024/03/07/mapimage.html
# for illustrations.

# Method 1: the default, using polygons for lon-lat patches
mapImage(topoWorld, colormap = cm)

# Method 2: filled contours, with ugly missing-data traces
# mapImage(topoWorld, colormap = cm, filledContour = TRUE)

# Method 3: filled contours, with a double-sized grid cells
# mapImage(topoWorld, colormap = cm, filledContour = 2)

# Method 4: filled contours, with a gap-filling gridder)
# g <- function(...) binMean2D(..., fill = TRUE, fillgap = 2)
# mapImage(topoWorld, colormap = cm, filledContour = TRUE, gridder = g)

mapGrid(15, 15, polarCircle = 1, col = gray(0.2))
mapPolygon(coastlineWorld[["longitude"]],
    coastlineWorld[["latitude"]],
    col = "tan"
)
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
\code{\link{mapDirectionField}()},
\code{\link{mapGrid}()},
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
\code{\link{oceProject}()},
\code{\link{shiftLongitude}()},
\code{\link{usrLonLat}()},
\code{\link{utm2lonlat}()}
}
\author{
Dan Kelley
}
\concept{functions related to maps}

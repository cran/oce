% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colors.R
\name{colormap}
\alias{colormap}
\title{Calculate a Color Map}
\usage{
colormap(
  z = NULL,
  zlim,
  zclip = FALSE,
  breaks,
  col = oceColorsViridis,
  name,
  x0,
  x1,
  col0,
  col1,
  blend = 0,
  missingColor,
  debug = getOption("oceDebug")
)
}
\arguments{
\item{z}{an optional vector or other set of numerical values to be examined.
If \code{z} is given, the return value will contain an item named
\code{zcol} that will be a vector of the same length as \code{z}, containing
a color for each point.  If \code{z} is not given, \code{zcol} will contain
just one item, the color \code{"black"}.}

\item{zlim}{optional vector containing two numbers that specify the \code{z}
limits for the color scale. This can only be provided in cases A
and B, as defined in \dQuote{Details}.  For case A, if \code{zlim} is not
provided, then it is inferred by using \code{\link[=rangeExtended]{rangeExtended()}}
on \code{breaks}, if that is provided, or from \code{z} otherwise.  Also,
in case A, it is an error to provide both \code{zlim} and \code{breaks},
unless the latter is of length 1, meaning the number of
subdivisions to use within the range set by \code{zlim}.
In case B, \code{zlim} is inferred from using \code{\link[=rangeExtended]{rangeExtended()}} on \code{c(x0,x1)}.
In case C, providing \code{zlim} yields an error message, because it makes no
sense in the context of a named, predefined color scheme.}

\item{zclip}{logical, with \code{TRUE} indicating that z values outside the
range of \code{zlim} or \code{breaks} should be painted with
\code{missingColor} and \code{FALSE} indicating that these values should be
painted with the nearest in-range color.}

\item{breaks}{an optional indication of break points between color levels
(see \code{\link[=image]{image()}}).  If this is provided, the arguments \code{name}
through \code{blend} are all ignored (see \dQuote{Details}).  If it is
provided, then it may either be a vector of break points, or a single number
indicating the desired number of break points to be computed with
\code{\link{pretty}}\verb{(z,breaks)}.  In either case of non-missing
\code{breaks}, the resultant break points must number 1 plus the number of
colors (see \code{col}).}

\item{col}{either a vector of colors or a function taking a numerical value
as its single argument and returning a vector of colors.  Prior to 2021-02-08,
the default for \code{col} was \code{oceColorsJet}, but it was switched to
\code{oceColorsViridis} on that date.  The value of
\code{col} is ignored if \code{name} is provided, or if \code{x0} through
\code{col1} are provided.}

\item{name}{an optional string naming a built-in colormap (one of
\code{"gmt_relief"}, \code{"gmt_ocean"}, \code{"gmt_globe"} or
\code{"gmt_gebco"}) or the name of a file or URL that contains a color map
specification in GMT format.  If \code{name} is given, then it is
passed to \code{\link[=colormapGMT]{colormapGMT()}}, which creates the colormap.
Note that the colormap thus created has a fixed
relationship between value and color, and \code{zlim},
only other argument that is examined is \code{z} (which may be used
so that \code{zcol} will be defined in the return value), and warnings
are issued if some irrelevant arguments are provided.}

\item{x0, x1, col0, col1}{Vectors that specify a color map.  They must all be
the same length, with \code{x0} and \code{x1} being numerical values, and
\code{col0} and \code{col1} being colors.  The colors may be strings (e.g.
\code{"red"}) or colors as defined by \code{\link[=rgb]{rgb()}} or \code{\link[=hsv]{hsv()}}.}

\item{blend}{a number indicating how to blend colors within each band.
This is ignored except when \code{x0} through \code{col1} are supplied.  A
value of 0 means to use \code{col0[i]} through the interval \code{x0[i]} to
\code{x1[i]}.  A value of 1 means to use \code{col1[i]} in that interval.  A
value between 0 and 1 means to blend between the two colors according to
the stated fraction.  Values exceeding 1 are an error at present, but there
is a plan to use this to indicate sub-intervals, so a smooth palette can be
created from a few colors.}

\item{missingColor}{color to use for missing values. This cannot be provided
if \code{name} is also provided (case C), because named schemes have pre-defined
colors.  For other cases, \code{missingColor} defaults to \code{"gray"}, if it
is not provided as an argument.}

\item{debug}{a flag that turns on debugging.  Set to 1 to get a moderate
amount of debugging information, or to 2 to get more.}
}
\value{
a list containing the following (not necessarily in this order)
\itemize{
\item \code{zcol}, a vector of colors for \code{z}, if \code{z} was
provided, otherwise \code{"black"}
\item \code{zlim}, a two-element vector suitable as the argument of the same
name supplied to \code{\link[=image]{image()}} or \code{\link[=imagep]{imagep()}}
\item \code{breaks} and \code{col}, vectors of breakpoints and colors,
suitable as the same-named arguments to \code{\link[=image]{image()}} or
\code{\link[=imagep]{imagep()}}
\item \code{zclip} the provided value of \code{zclip}.
\item \code{x0} and \code{x1}, numerical vectors of the sides of color
intervals, and \code{col0} and \code{col1}, vectors of corresponding
colors.  The meaning is the same as on input.  The purpose of returning
these four vectors is to permit users to alter color mapping, as in example
3 in \dQuote{Examples}.
\item \code{missingColor}, a color that could be used to specify missing
values, e.g. as the same-named argument to \code{\link[=imagep]{imagep()}}.
\item \code{colfunction}, a univariate function that returns a vector
of colors, given a vector of \code{z} values; see Example 6.
}
}
\description{
Create a mapping between numeric values and colors, for use in palettes and plots.
The return value can be used in various ways, including colorizing points
on scattergraphs, controlling images created by \code{\link[=image]{image()}} or \code{\link[=imagep]{imagep()}},
drawing palettes with \code{\link[=drawPalette]{drawPalette()}}, etc.
}
\details{
\code{colormap} can be used in a variety of ways, including the following.
\itemize{
\item \strong{Case A.} Supply some combination of arguments that
is sufficient to define a mapping of value to color, without
providing \code{x0}, \code{col0}, \code{x1} or \code{col1} (see case B for these),
or providing \code{name} (see Case C). There are several ways to
do this.  One approach is to supply \code{z} but no
other argument, in which case \code{zlim}, and \code{breaks} will be determined
from \code{z}, and the default \code{col} will be used.  Another approach is
to specify \code{breaks} and \code{col} together, in the same way as they
might be specified for the base R function \code{\link[=image]{image()}}.  It is
also possible to supply only \code{zlim}, in which case \code{breaks} is
inferred from that value.
\if{html}{The figure below explains the
(`breaks`, `col`) method of specifying a color mapping.  Note
that there must be one more break than color.  This is the method used by
e.g. [image()].}
\if{html}{\figure{colormap_fig_1.png}}
\item \strong{Case B.} Supply \code{x0}, \code{col0}, \code{x1}, and \code{col1}, but \emph{not}
\code{zlim}, \code{breaks}, \code{col} or \code{name}.
The \code{x0}, \code{col0}, \code{x1} and \code{col1} values specify a
value-color mapping that is similar to that used
for GMT color maps.  The method works by using \code{\link[=seq]{seq()}} to
interpolate between the elements of the \code{x0} vector.  The same is done
for \code{x1}.  Similarly, \code{\link[=colorRampPalette]{colorRampPalette()}} is used to
interpolate between the colors in the \code{col0} vector, and the same is
done for \code{col1}.  \if{html}{The figure above explains the (`x0`,
`x1`, `col0`, `col1`) method of specifying a color mapping.
Note that the each of the items has the same length. The case of
`blend=0`, which has color `col0[i]` between `x0[i]` and
`x1[i]`, is illustrated below.}
\if{html}{\figure{colormap_fig_2.png}}
\item \strong{Case C.} Supply \code{name} and possibly also \code{z}, but \emph{not}
\code{zlim}, \code{breaks}, \code{col}, \code{x0}, \code{col0}, \code{x1} or \code{col1}.
The \code{name} may be the name of a pre-defined color palette
(\code{"gmt_relief"}, \code{"gmt_ocean"}, \code{"gmt_globe"} or
\code{"gmt_gebco"}), or it may be the name of a file (or URL pointing to a file)
that contains a color map in the GMT format (see \dQuote{References}). If
\code{z} is supplied along with \code{name}, then \code{zcol} will be set up in the
return value, e.g. for use in colorizing points.  Another method
for finding colors for data points is to use the \code{colfunction()}
function in the return value.
}
}
\section{Sample of Usage}{

\preformatted{
# Example 2. topographic image with a standard color scheme
par(mfrow=c(1,1))
data(topoWorld)
cm <- colormap(name="gmt_globe")
imagep(topoWorld, breaks=cm$breaks, col=cm$col)

# Example 3. topographic image with modified colors,
# black for depths below 4km.
cm <- colormap(name="gmt_globe")
deep <- cm$x0 < -4000
cm$col0[deep] <- "black"
cm$col1[deep] <- "black"
cm <- colormap(x0=cm$x0, x1=cm$x1, col0=cm$col0, col1=cm$col1)
imagep(topoWorld, breaks=cm$breaks, col=cm$col)

# Example 4. image of world topography with water colorized
# smoothly from violet at 8km depth to blue
# at 4km depth, then blending in 0.5km increments
# to white at the coast, with tan for land.
cm <- colormap(x0=c(-8000, -4000,   0,  100),
     x1=c(-4000,     0, 100, 5000),
     col0=c("violet","blue","white","tan"),
     col1=c("blue","white","tan","yellow"))
lon <- topoWorld[["longitude"]]
lat <- topoWorld[["latitude"]]
z <- topoWorld[["z"]]
imagep(lon, lat, z, breaks=cm$breaks, col=cm$col)
contour(lon, lat, z, levels=0, add=TRUE)

# Example 5. visualize GMT style color map
cm <- colormap(name="gmt_globe", debug=4)
plot(seq_along(cm$x0), cm$x0, pch=21, bg=cm$col0)
grid()
points(seq_along(cm$x1), cm$x1, pch=21, bg=cm$col1)

# Example 6. colfunction
cm <- colormap(c(0, 1))
x <- 1:10
y <- (x - 5.5)^2
z <- seq(0, 1, length.out=length(x))
drawPalette(colormap=cm)
plot(x, y, pch=21, bg=cm$colfunction(z), cex=3)
}
}

\examples{
library(oce)
# Example 1. color scheme for points on xy plot
x <- seq(0, 1, length.out = 40)
y <- sin(2 * pi * x)
par(mar = c(3, 3, 1, 1))
mar <- par("mar") # prevent margin creep by drawPalette()
# First, default breaks
c <- colormap(y)
drawPalette(c$zlim, col = c$col, breaks = c$breaks)
plot(x, y, bg = c$zcol, pch = 21, cex = 1)
grid()
par(mar = mar)
# Second, 100 breaks, yielding a smoother palette
c <- colormap(y, breaks = 100)
drawPalette(c$zlim, col = c$col, breaks = c$breaks)
plot(x, y, bg = c$zcol, pch = 21, cex = 1)
grid()
par(mar = mar)

}
\references{
The following references provide information on choosing
colour schemes, that are suitable for viewers who have
colour deficiencies.

Light, Adam, and Patrick J. Bartlein. "The End of the Rainbow? Color
Schemes for Improved Data Graphics." \emph{Eos, Transactions American Geophysical
Union} 85, no. 40 (2004): 385.
DOI: 10.1029/2004EO400002

Stephenson, David B. "Comment on 'Color Schemes for Improved Data
Graphics', by A Light and P.J. Bartlein." \emph{Eos, Transactions American
Geophysical Union} 86, no.  20 (2005): 196.
DOI: 10.1029/2005EO200005

Light, Adam, and Patrick J. Bartlein. "Reply to 'Comment on Color
Schemes for Improved Data Graphics,' by A. Light and P.J.  Bartlein'."
\emph{Eos, Transactions American Geophysical Union} 86, no. 20 (2005): 196–196.
DOI: 10.1029/2005EO200006
}
\seealso{
Other things related to colors: 
\code{\link{colormapGMT}()},
\code{\link{oceColors9B}()},
\code{\link{oceColorsCDOM}()},
\code{\link{oceColorsChlorophyll}()},
\code{\link{oceColorsClosure}()},
\code{\link{oceColorsDensity}()},
\code{\link{oceColorsFreesurface}()},
\code{\link{oceColorsGebco}()},
\code{\link{oceColorsJet}()},
\code{\link{oceColorsOxygen}()},
\code{\link{oceColorsPAR}()},
\code{\link{oceColorsPalette}()},
\code{\link{oceColorsPhase}()},
\code{\link{oceColorsSalinity}()},
\code{\link{oceColorsTemperature}()},
\code{\link{oceColorsTurbidity}()},
\code{\link{oceColorsTurbo}()},
\code{\link{oceColorsTwo}()},
\code{\link{oceColorsVelocity}()},
\code{\link{oceColorsViridis}()},
\code{\link{oceColorsVorticity}()},
\code{\link{ocecolors}}
}
\author{
Dan Kelley
}
\concept{things related to colors}

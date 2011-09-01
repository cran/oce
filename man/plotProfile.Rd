\name{plotProfile}

\alias{plotProfile}

\title{Plot a CTD profile of various quantities}

\description{Plot a CTD profile, in any of several common formats.}

\usage{plotProfile(x,
             xtype="salinity+temperature", 
             ytype=c("pressure", "z"),
             col.salinity="darkgreen",
             col.temperature="red",
             col.rho="blue",
             col.N2="brown",
             col.dpdt="darkgreen",
             col.time="darkgreen",
             grid=TRUE,
             col.grid="lightgray",
             lty.grid="dotted",
             Slim, Tlim, densitylim, N2lim, dpdtlim, timelim, ylim,
             lwd=par("lwd"),
             xaxs="r", yaxs="r",
             cex=1, pch=1,
             useSmoothScatter=FALSE,
             type='l',
             mgp=getOption("oceMgp"),
             mar=c(1 + if (length(grep('\\\\+', xtype))) mgp[1] else 0, mgp[1]+1, mgp[1] + 2, 1),
             debug=getOption("oceDebug"),
             \dots)
}

\arguments{
  \item{x}{A \code{cdt} object, e.g. as read by \code{\link{read.ctd}}.}
  \item{xtype}{Item(s) plotted on the x axis, from the list below.
    \describe{
      \item{\code{salinity}}{Profile of salinity.}
      \item{\code{temperature}}{Profile of \emph{in-situ} temperature.}
      \item{\code{density}}{Profile of density (expressed as
	\eqn{\sigma_\theta}{sigma_theta}).}
      \item{\code{index}}{Index of sample (very useful for working with
	\code{\link{ctdTrim}}).}
      \item{\code{S+T}}{Profile of salinity and temperature within a
	single axis frame.}
      \item{\code{N2}}{Profile of square of buoyancy frequency
	\eqn{N^2}{N^2}, calculated with \code{\link{swN2}} with an
	optional argument setting of \code{df=length(x$p)/4} to do some
	smoothing.}
      \item{\code{density+N2}}{Profile of sigma-theta and the square of buoyancy
	frequency within a single axis frame.}
      \item{\code{density+dpdt}}{Profile of sigma-theta and dP/dt for
	the sensor.  The latter is useful in indicating problems with
	the deployment.  It is calculated by first differencing pressure
	and then using a smoothing spline on the result (to avoid
	grid-point wiggles that result because the SBE software only
	writes 3 decimal places in pressure).  Note that dP/dt may be
	off by a scale factor; this should not be a problem if there is
	a \code{x$data$time} column, or a \code{x$metadata$sample.rate}
	value in the header.}
    }
  }
  \item{ytype}{variable to use on y axis.}
  \item{col.salinity}{Color for salinity profile.}
  \item{col.temperature}{Color for temperature.}
  \item{col.rho}{Color for density.}
  \item{col.N2}{Color for square of buoyancy frequency.}
  \item{col.dpdt}{Color for dP/dt.}
  \item{col.time}{Color for delta-time.}
  \item{grid}{logical, set to \code{TRUE} to get a grid.}
  \item{col.grid}{colour for grid.}
  \item{lty.grid}{line type for grid.}
  \item{Slim}{Optional limit for S axis}
  \item{Tlim}{Optional limit for T axis}
  \item{densitylim}{Optional limit for density axis}
  \item{N2lim}{Optional limit for N2 axis}
  \item{dpdtlim}{Optional limit for dp/dt axis}
  \item{timelim}{Optional limit for delta-time axis}
  \item{ylim}{Optional limit for y axis}
  \item{lwd}{lwd value for data line}
  \item{xaxs}{value of \code{\link{par}} \code{xaxs} to use}
  \item{yaxs}{value of \code{\link{par}} \code{yaxs} to use}
  \item{cex}{size to be used for plot symbols (see \code{\link{par}})}
  \item{pch}{code for plotting symbol (see \code{\link{par}}).}
  \item{useSmoothScatter}{boolean, set to \code{TRUE} to use 
    \code{\link{smoothScatter}} instead of \code{\link{plot}} to draw
    the plot.}
  \item{type}{type of plot to draw, using the same scheme as \code{\link{plot}}.}
  \item{mgp}{3-element numerical vector to use for \code{par(mgp)}, and
    also for \code{par(mar)}, computed from this.  The default is
    tighter than the R default, in order to use more space for the data
    and less for the axes.}
  \item{mar}{value to be used with \code{\link{par}("mar")}.}
  \item{debug}{a flag that turns on debugging, if it exceeds 0.}
  \item{\dots}{Optional arguments passed to other functions.  A common example is
    to set \code{df}, for use in \link{swN2} calculations.} 
}

\value{None.}

\seealso{\code{\link{read.ctd}} scans ctd information from a file, and
  \code{\link{plotTS}} plots a temperature-salinity diagram. 
}

\examples{
library(oce)
data(ctd)
plotProfile(ctd, xtype="temperature")
}

\author{Dan Kelley}

\keyword{hplot}
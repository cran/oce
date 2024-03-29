% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sw.R
\name{swAlphaOverBeta}
\alias{swAlphaOverBeta}
\title{Ratio of Seawater Thermal Expansion Coefficient to Haline Contraction Coefficient}
\usage{
swAlphaOverBeta(
  salinity,
  temperature = NULL,
  pressure = NULL,
  longitude = NULL,
  latitude = NULL,
  eos = getOption("oceEOS", default = "gsw")
)
}
\arguments{
\item{salinity}{either practical salinity (in which case \code{temperature}
and \code{pressure} must be provided) \emph{or} an \code{oce} object (in
which case \code{salinity}, etc. are inferred from the object).}

\item{temperature}{\emph{in-situ} temperature (\eqn{^\circ}{deg}C)}

\item{pressure}{pressure (dbar)}

\item{longitude}{longitude of observation (only used if \code{eos="gsw"};
see \dQuote{Details}).}

\item{latitude}{latitude of observation (only used if \code{eos="gsw"}; see
\dQuote{Details}).}

\item{eos}{equation of state, either \code{"unesco"} or \code{"gsw"}.}
}
\value{
Value in psu/\eqn{^\circ}{deg}C.
}
\description{
Compute \eqn{\alpha/\beta}{alpha/beta} using McDougall's (1987) algorithm.
}
\examples{
swAlphaOverBeta(40, 10, 4000, eos = "unesco") # 0.3476

}
\references{
The \code{eos="unesco"} formulae are based on the UNESCO
equation of state, but are formulated empirically by Trevor J. McDougall,
1987, Neutral Surfaces, Journal of Physical Oceanography, volume 17, pages
1950-1964. The \code{eos="gsw"} formulae come from GSW; see references in
the \code{\link[=swRho]{swRho()}} documentation.
}
\seealso{
Other functions that calculate seawater properties: 
\code{\link{T68fromT90}()},
\code{\link{T90fromT48}()},
\code{\link{T90fromT68}()},
\code{\link{computableWaterProperties}()},
\code{\link{locationForGsw}()},
\code{\link{swAbsoluteSalinity}()},
\code{\link{swAlpha}()},
\code{\link{swBeta}()},
\code{\link{swCSTp}()},
\code{\link{swConservativeTemperature}()},
\code{\link{swDepth}()},
\code{\link{swDynamicHeight}()},
\code{\link{swLapseRate}()},
\code{\link{swN2}()},
\code{\link{swPressure}()},
\code{\link{swRho}()},
\code{\link{swRrho}()},
\code{\link{swSCTp}()},
\code{\link{swSR}()},
\code{\link{swSTrho}()},
\code{\link{swSigma0}()},
\code{\link{swSigma1}()},
\code{\link{swSigma2}()},
\code{\link{swSigma3}()},
\code{\link{swSigma4}()},
\code{\link{swSigmaTheta}()},
\code{\link{swSigmaT}()},
\code{\link{swSigma}()},
\code{\link{swSoundAbsorption}()},
\code{\link{swSoundSpeed}()},
\code{\link{swSpecificHeat}()},
\code{\link{swSpice}()},
\code{\link{swSstar}()},
\code{\link{swTFreeze}()},
\code{\link{swTSrho}()},
\code{\link{swThermalConductivity}()},
\code{\link{swTheta}()},
\code{\link{swViscosity}()},
\code{\link{swZ}()}
}
\author{
Dan Kelley
}
\concept{functions that calculate seawater properties}

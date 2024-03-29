% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sw.R
\name{swViscosity}
\alias{swViscosity}
\title{Seawater Viscosity}
\usage{
swViscosity(salinity, temperature)
}
\arguments{
\item{salinity}{either salinity (PSU) (in which case \code{temperature} and
\code{pressure} must be provided) \emph{or} a \code{ctd} object (in which
case \code{salinity}, \code{temperature} and \code{pressure} are determined
from the object, and must not be provided in the argument list).}

\item{temperature}{\emph{in-situ} temperature (\eqn{^\circ}{deg}C), defined
on the ITS-90 scale; see \dQuote{Temperature units} in the documentation for
\code{\link[=swRho]{swRho()}}, and the examples below.}
}
\value{
Viscosity of seawater in \eqn{Pa\cdot s}{Pa*s}.  Divide by density
to get kinematic viscosity in \eqn{m^2/s}{m^2/s}.
}
\description{
Compute viscosity of seawater, in \eqn{Pa\cdot s}{Pa*s}
}
\details{
If the first argument is a \code{ctd} object, then salinity, temperature and
pressure values are extracted from it, and used for the calculation.

The result is determined from a regression of the data provided in Table 87
of Dorsey (1940). The fit matches the table to within 0.2 percent at worst,
and with average absolute error of 0.07 percent. The maximum deviation from
the table is one unit in the last decimal place.

No pressure dependence was reported by Dorsey (1940).
}
\examples{
swViscosity(30, 10) # 0.001383779

}
\references{
N. Ernest Dorsey (1940),
\emph{Properties of ordinary Water-substance},
American Chemical Society Monograph Series.  Reinhold
Publishing.
}
\seealso{
Other functions that calculate seawater properties: 
\code{\link{T68fromT90}()},
\code{\link{T90fromT48}()},
\code{\link{T90fromT68}()},
\code{\link{computableWaterProperties}()},
\code{\link{locationForGsw}()},
\code{\link{swAbsoluteSalinity}()},
\code{\link{swAlphaOverBeta}()},
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
\code{\link{swZ}()}
}
\author{
Dan Kelley
}
\concept{functions that calculate seawater properties}

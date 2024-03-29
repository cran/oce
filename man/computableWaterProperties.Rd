% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sw.R
\name{computableWaterProperties}
\alias{computableWaterProperties}
\title{Determine Available Derived Water Properties}
\usage{
computableWaterProperties(x)
}
\arguments{
\item{x}{a specification of the names of known variables.  This
may be (a) an \linkS4class{oce} object, in which case the names are
determined by calling \code{\link[=names]{names()}} on the \code{data} slot of \code{x}, or
(b) a vector of character values indicating the names.}
}
\value{
\code{\link[=computableWaterProperties]{computableWaterProperties()}} returns a sorted
character vector holding the names of computable
water properties, or NULL, if there are no computable values.
}
\description{
This determines what things can be derived from the supplied
variables.  For example, if \code{salinity}, \code{temperature},
and \code{pressure} are supplied, then potential temperature, sound
speed, and several other things can be derived.  If, in addition,
\code{longitude} and \code{latitude} are supplied, then Absolute Salinity,
Conservative Temperature, and some other things can be derived.
Similarly, \code{nitrate} can be computed from \code{NO2+NO3} together
with \code{nitrate}, and \code{nitrite} can be computed from \code{NO2+NO3}
together with \code{nitrate}.
See the \dQuote{Examples} for a full listing.
}
\examples{
library(oce)
# Example 1
data(ctd)
computableWaterProperties(ctd)
# Example 2: nothing an be computed from just salinity
computableWaterProperties("salinity")
# Example 3: quite a lot can be computed from this trio of values
computableWaterProperties(c("salinity", "temperature", "pressure"))
# Example 4: now we can get TEOS-10 values as well
computableWaterProperties(c(
    "salinity", "temperature", "pressure",
    "longitude", "latitude"
))

}
\seealso{
Other functions that calculate seawater properties: 
\code{\link{T68fromT90}()},
\code{\link{T90fromT48}()},
\code{\link{T90fromT68}()},
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
\code{\link{swViscosity}()},
\code{\link{swZ}()}
}
\author{
Dan Kelley
}
\concept{functions that calculate seawater properties}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sw.R
\name{locationForGsw}
\alias{locationForGsw}
\title{Alter Longitude and Latitude for gsw Computations}
\usage{
locationForGsw(x)
}
\arguments{
\item{x}{an \linkS4class{oce} object.}
}
\value{
A list containing \code{longitude} and \code{latitude}, with
dimensionality matching \code{pressure} in the \code{data} slot
of \code{x}.  If \code{x} lacks location information (in either
its \code{metadata} or \code{data} slot) or lacks \code{pressure} in its
data slot, then the returned list will hold NULL values for
both \code{longitude} and \code{latitude}.
}
\description{
This function is mainly intended for use within \code{\link[=swAbsoluteSalinity]{swAbsoluteSalinity()}} and
similar functions that use the \code{gsw} package to compute seawater
properties in the Gibbs Seawater formulation.
}
\details{
The \code{gsw} functions
require location information to be matched up with hydrographic
information.  The scheme depends on the dimensionality of the
hydrographic variables and the location variables. For example,
the \linkS4class{ctd} stores \code{salinity} etc in vectors, an stores
just one longitude-latitude pair for each vector.  By contrast,
the \linkS4class{argo} stores \code{salinity} etc as matrices, and stores
e.g. \code{longitude} as a vector of length matching the first
dimension of \code{salinity}.

\link{locationForGsw} repeats location information as required,
returning values with dimensionality matching \code{pressure}.
}
\seealso{
Other functions that calculate seawater properties: 
\code{\link{T68fromT90}()},
\code{\link{T90fromT48}()},
\code{\link{T90fromT68}()},
\code{\link{computableWaterProperties}()},
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

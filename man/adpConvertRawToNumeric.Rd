% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adp.R
\name{adpConvertRawToNumeric}
\alias{adpConvertRawToNumeric}
\title{Convert Raw to Numeric Values in an adp Object}
\usage{
adpConvertRawToNumeric(
  object = NULL,
  variables = NULL,
  debug = getOption("oceDebug")
)
}
\arguments{
\item{object}{an \linkS4class{adp} object.}

\item{variables}{variables stored in an \linkS4class{adp} object that has
the same dimensional as \code{v} and is stored in a raw format.}

\item{debug}{an integer specifying whether debugging information is
to be printed during the processing. This is a general parameter that
is used by many \code{oce} functions. Generally, setting \code{debug=0}
turns off the printing, while higher values suggest that more information
be printed. If one function calls another, it usually reduces the value of
\code{debug} first, so that a user can often obtain deeper debugging
by specifying higher \code{debug} values.}
}
\value{
\code{adpConvertRawToNumeric} returns an \linkS4class{adp} object whose specified
variables have been converted from raw to numerical format.
}
\description{
Convert variables in an \linkS4class{adp} object from raw to numeric format.
}
\examples{
library(oce)
data(adp)
adp[["a"]][, , 1][, 1]
ADP <- adpConvertRawToNumeric(adp)
ADP[["a"]][, , 1][, 1]
}
\seealso{
Other things related to adp data: 
\code{\link{[[,adp-method}},
\code{\link{[[<-,adp-method}},
\code{\link{ad2cpCodeToName}()},
\code{\link{ad2cpHeaderValue}()},
\code{\link{adp}},
\code{\link{adp-class}},
\code{\link{adpAd2cpFileTrim}()},
\code{\link{adpEnsembleAverage}()},
\code{\link{adpFlagPastBoundary}()},
\code{\link{adpRdiFileTrim}()},
\code{\link{adp_rdi.000}},
\code{\link{applyMagneticDeclination,adp-method}},
\code{\link{as.adp}()},
\code{\link{beamName}()},
\code{\link{beamToXyz}()},
\code{\link{beamToXyzAdp}()},
\code{\link{beamToXyzAdpAD2CP}()},
\code{\link{beamToXyzAdv}()},
\code{\link{beamUnspreadAdp}()},
\code{\link{binmapAdp}()},
\code{\link{enuToOther}()},
\code{\link{enuToOtherAdp}()},
\code{\link{handleFlags,adp-method}},
\code{\link{is.ad2cp}()},
\code{\link{plot,adp-method}},
\code{\link{read.adp}()},
\code{\link{read.adp.ad2cp}()},
\code{\link{read.adp.nortek}()},
\code{\link{read.adp.rdi}()},
\code{\link{read.adp.sontek}()},
\code{\link{read.adp.sontek.serial}()},
\code{\link{read.aquadopp}()},
\code{\link{read.aquadoppHR}()},
\code{\link{read.aquadoppProfiler}()},
\code{\link{rotateAboutZ}()},
\code{\link{setFlags,adp-method}},
\code{\link{subset,adp-method}},
\code{\link{subtractBottomVelocity}()},
\code{\link{summary,adp-method}},
\code{\link{toEnu}()},
\code{\link{toEnuAdp}()},
\code{\link{velocityStatistics}()},
\code{\link{xyzToEnu}()},
\code{\link{xyzToEnuAdp}()},
\code{\link{xyzToEnuAdpAD2CP}()}
}
\author{
Jaimie Harbin and Dan Kelley
}
\concept{things related to adp data}

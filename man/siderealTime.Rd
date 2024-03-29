% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/astronomy.R
\name{siderealTime}
\alias{siderealTime}
\title{Convert From POSIXt Time to Sidereal Time}
\usage{
siderealTime(t)
}
\arguments{
\item{t}{a time, in POSIXt format, e.g. as created by
\code{\link[=as.POSIXct]{as.POSIXct()}}, \code{\link[=as.POSIXlt]{as.POSIXlt()}}, or
\code{\link[=numberAsPOSIXct]{numberAsPOSIXct()}}.  If this is provided, the other arguments are
ignored.}
}
\value{
A sidereal time, in hours in the range from 0 to 24.
}
\description{
Convert a POSIXt time to a sidereal time, using
the method in Chapter 7 of reference 1.  The small correction
that he discusses after his equation 7.1 is not applied here.
}
\examples{

t <- ISOdatetime(1978, 11, 13, 0, 0, 0, tz = "UTC")
print(siderealTime(t))

}
\references{
\itemize{
\item Meeus, Jean. Astronomical Formulas for Calculators. Second Edition.
Richmond, Virginia, USA: Willmann-Bell, 1982.
}
}
\seealso{
Other things related to astronomy: 
\code{\link{angle2hms}()},
\code{\link{eclipticalToEquatorial}()},
\code{\link{equatorialToLocalHorizontal}()},
\code{\link{julianCenturyAnomaly}()},
\code{\link{julianDay}()},
\code{\link{moonAngle}()},
\code{\link{sunAngle}()},
\code{\link{sunDeclinationRightAscension}()}
}
\author{
Dan Kelley
}
\concept{things related to astronomy}

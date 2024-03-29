% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/astronomy.R
\name{equatorialToLocalHorizontal}
\alias{equatorialToLocalHorizontal}
\title{Convert Equatorial Coordinate to Local Horizontal Coordinate}
\usage{
equatorialToLocalHorizontal(
  rightAscension,
  declination,
  t,
  longitude,
  latitude
)
}
\arguments{
\item{rightAscension}{right ascension, e.g. calculated with
\code{\link[=eclipticalToEquatorial]{eclipticalToEquatorial()}}.}

\item{declination}{declination, e.g. calculated with
\code{\link[=eclipticalToEquatorial]{eclipticalToEquatorial()}}.}

\item{t}{time of observation.}

\item{longitude}{longitude of observation, positive in eastern hemisphere.}

\item{latitude}{latitude of observation, positive in northern hemisphere.}
}
\value{
A data frame containing columns \code{altitude} (angle above
horizon, in degrees) and \code{azimuth} (angle anticlockwise from south, in
degrees).
}
\description{
Convert from equatorial coordinates to local horizontal coordinates, i.e.
azimuth and altitude.
The method is taken from equations 8.5 and 8.6 of reference 1, or, equivalently,
from equations 12.5 and 12.6 of reference 2.
}
\references{
\itemize{
\item Meeus, Jean. Astronomical Formulas for Calculators. Second Edition.
Richmond, Virginia, USA: Willmann-Bell, 1982.
\item Meeus, Jean. Astronomical Algorithms. Second Edition.
Richmond, Virginia, USA: Willmann-Bell, 1991.
}
}
\seealso{
Other things related to astronomy: 
\code{\link{angle2hms}()},
\code{\link{eclipticalToEquatorial}()},
\code{\link{julianCenturyAnomaly}()},
\code{\link{julianDay}()},
\code{\link{moonAngle}()},
\code{\link{siderealTime}()},
\code{\link{sunAngle}()},
\code{\link{sunDeclinationRightAscension}()}
}
\author{
Dan Kelley, based on formulae in references 1 and 2.
}
\concept{things related to astronomy}

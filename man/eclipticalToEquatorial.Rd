% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/astronomy.R
\name{eclipticalToEquatorial}
\alias{eclipticalToEquatorial}
\title{Convert Ecliptical Coordinate to Equatorial Coordinate}
\usage{
eclipticalToEquatorial(lambda, beta, epsilon)
}
\arguments{
\item{lambda}{longitude, in degrees, or a data frame containing
\code{lambda}, \code{beta}, and \code{epsilon}, in which case the next to
arguments are ignored}

\item{beta}{geocentric latitude, in degrees}

\item{epsilon}{obliquity of the ecliptic, in degrees}
}
\value{
A data frame containing columns \code{rightAscension} and
\code{declination} both in degrees.
}
\description{
Convert from ecliptical to equatorial coordinates, using
equations 8.3 and 8.4 of reference 1, or, equivalently,
equations 12.3 and 12.4 of reference 2.
}
\details{
The code is based on reference 1; see \code{\link[=moonAngle]{moonAngle()}} for comments on
the differences in formulae found in reference 2.  Indeed,
reference 2 is only cited
here in case readers want to check the ideas of the formulae; DK
has found that reference 2 is available to him via his university library
inter-library loan system, whereas he owns a copy of reference 1.
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
\code{\link{equatorialToLocalHorizontal}()},
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

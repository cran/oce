\name{as.sealevel}
\alias{as.sealevel}
\title{Coerce data into sea-level dataset}
\description{
  Coerces a dataset (minimally, a sequence of heights) into
  a sealevel dataset.
}
\usage{
as.sealevel(eta,
  header="",
  start.time=as.POSIXct("2000-01-01"),
  station.number="001",
  station.version="A",
  station.name="Santa",
  region="mythical",
  year="2000",
  latitude="90000N",
  longitude="000000E",
  GMT.offset=0,
  decimation.method=1,
  reference.offset=0,
  reference.code="",
  units="MM")
}
\arguments{
  \item{eta}{A list of sea-level heights in metres, in an hourly sequence.}
  \item{header}{A character string as read from first line of a standard data file.}
  \item{start.time}{A time in POSIX format, e.g. \code{as.POSIXct("2000-01-01")}}
  \item{station.number}{Three-character string giving station number}
  \item{station.version}{Single character for version of station}
  \item{station.name}{Name of station (at most 18 characters)}
  \item{region}{Region or country of station (at most 19 characters)}
  \item{year}{Four-character number of year}
  \item{latitude}{First 2 characters are degrees of latitude, next 2 are minutes, next 2 are tenths of minutes, and last is "N" or "S" for hemisphere, e.g. "90000N". Negatives are not allowed.}
  \item{longitude}{First 3 characters are degrees of longitude, next 2 are minutes, next 2 are tenths of minutes, and last is "E" or "W" for hemisphere, e.g. "000000E".  Negatives are not allowed.}
  \item{GMT.offset}{Offset from GMT.  (BUG: this is ignored.)}
  \item{decimation.method}{1: filtered; 2: simple average of all samples; 3: spot readings; 4: other}
  \item{reference.offset}{?}
  \item{reference.code}{?}
  \item{units}{\code{"MM"} or \code{"mm"} if the sea-level heights are in millimetres (the default for data files).  \code{"M"} or \code{"m"} if the heights are in metres.}
}
\details{
  The arguments are based on the standard data format, as described
  at
 \url{ftp://ilikai.soest.hawaii.edu/rqds/hourly.fmt}.
}
\value{
  A \code{sealevel} object.  
}
\seealso{
  \code{\link{read.sealevel}} reads data,
  \code{\link{summary.sealevel}} summarizes the information, while
  \code{\link{plot.sealevel}} plots it.
}
\examples{
library(oce)
h <- 1:(24*100) # fake 100 days
eta <- 1.0 * sin(2*pi*h/12.4172) + 0.8 * sin(2*pi*h/24.0)
eta <- eta + 0.1 * rnorm(length(h)) # add some noise
h <- as.sealevel(eta, units="m")
summary(h)
}
\references{
  \url{ftp://ilikai.soest.hawaii.edu/rqds/hourly.fmt}.
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

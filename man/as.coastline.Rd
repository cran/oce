\name{as.coastline}
\alias{as.coastline}
\title{Coerce data into coastline dataset}
\description{
  Coerces a sequence of latitudes and longitudes into a coastline dataset.
}
\usage{
as.coastline(latitude, longitude)
}
\arguments{
  \item{latitude}{the latitude in decimal degrees, positive north of the equator.}
  \item{longitude}{the longitude in decimal degrees, positive north of Greenwich.}
}
\details{
This may be used when \code{\link{read.coastline}} cannot read a file, or when
the data have been manipulated.
}
\value{
  A \code{coastline} object.  
}
\seealso{
  \code{\link{read.coastline}} reads data
  \code{\link{plot.coastline}} plots it.
}
\examples{
}
\references{
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

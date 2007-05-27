\name{plot.coastline}
\alias{plot.coastline}
\title{Plot a coastline}
\description{
  Plot a coastline.
}
\usage{
\method{plot}{coastline}(x, \dots)
}
\arguments{
  \item{x}{A \code{coastline} object, e.g. as read by \code{\link{read.coastline}}.}
  \item{\dots}{optional arguments passed to plotting functions.}
}
\details{
  Plots a coastline.
}
\value{
  None.
}
\seealso{
  \code{\link{summary.coastline}} summarizes the information, while
  \code{\link{read.coastline}} scans it from a file.
}
\examples{
library(oce)
data(coastline)
plot(coastline)
}
\references{
\url{http://www.ngdc.noaa.gov/mgg/shorelines/shorelines.html}
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

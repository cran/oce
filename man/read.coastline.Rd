\name{read.coastline}
\alias{read.coastline}
\title{Scan a coastline data file}
\description{
  Read a coastline file in mapgen, matlab, or Splus format
}
\usage{
read.coastline(file,type=c("R","S","mapgen"),debug=FALSE)
}
\arguments{
  \item{file}{Name of file containing coastline data.}
  \item{type}{Type of file, one of "R", "S", or "mapgen"}
  \item{debug}{Set to TRUE to print information about the header, etc.}
}
\details{
The S and R formats are identical, and consist of two columns, lon and lat, with land-jump segments 
separated by lines with two NAs.

The MapGen format is of the form
\preformatted{
# -b
-16.179081	28.553943
-16.244793	28.563330
}
BUG: the 'arc/info ungenerate' format is not yet understood.

}
\value{
  A \code{coastline} object containing
  \item{processing.log}{A processing log.}
  \item{data}{a list containing \code{longitude}, in decimal degrees, positive east of Greenwich, and \code{latitude}, in decimal degrees postive north of the equator.}
}

\seealso{
The generic function \code{\link{read.oce}} provides an alternative to this.

Coastlines may be summarized with \code{\link{summary.coastline}} and plotted with
\code{\link{plot.coastline}}.
}
\examples{
\dontrun{
library(oce)
cl <- read.coastline("7404.dat")
# If no plot yet:
plot(cl)
# To add to an existing plot:
lines(cl$data$longitude, cl$data$latitude)
# Note: another trick is to do something like the following,
# to get issues of whether longitude is defined in (-180,180)
# or (0,360)
lines(cl$datas$longitude, cl$data$latitude)
lines(cl$data$longitude-360, cl$data$latitude)
}
}
\references{
  \url{http://www.ngdc.noaa.gov/mgg/shorelines/shorelines.html}
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

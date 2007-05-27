\name{plot.sealevel}
\alias{plot.sealevel}
\title{Plot sealevel data}
\description{
  Plot a summary diagram for sealevel data.
}
\usage{
\method{plot}{sealevel}(x, \dots)
}
\arguments{
  \item{x}{A \code{sealevel} object, e.g. as read by \code{\link{read.sealevel}}.}
  \item{\dots}{optional arguments passed to plotting functions.}
}
\details{
  Creates a summary plot for a sea-level dataset.
}
\value{
  None.
}
\seealso{
  \code{\link{summary.sealevel}} summarizes the information, while
  \code{\link{read.sealevel}} scans it from a file.
}
\examples{
library(oce)
data(sealevel)
plot(sealevel)
}
\references{
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

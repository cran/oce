\name{read.sealevel}
\alias{read.sealevel}
\title{Read a sea-level data file}
\description{
  Read a data file holding sea level data.
  BUG: the time vector assumes GMT, regardless of the GMT.offset value.
}
\usage{
read.sealevel(file,debug=FALSE)
}
\arguments{
  \item{file}{A connection or a character string giving the name of the
    file to load.}
  \item{debug}{Set to \code{TRUE} to get debugging information during processing.}
}
\details{See \link{sealevel} for details of the data format.}
\value{
  A \code{sealevel} object containing 
  \item{header}{The header line (helpful if detail extraction failed)}
	... for various station descriptors, see \code{\link{as.sealevel}}
  \item{n}{Number of data values}
  \item{hour}{Times [h]}
  \item{time}{Time [POSIXct]}
  \item{eta}{Sea level [m]}
}

\seealso{
  \code{\link{summary.sealevel}} summarizes the information, while
  \code{\link{plot.sealevel}} plots it.
}
\examples{
\dontrun{
library(oce)
h <- read.sealevel("ftp://ilikai.soest.hawaii.edu/rqds/pacific/monthly/m652a.dat")
summary(h)
plot(h)
}
}
\references{
  \url{ftp://ilikai.soest.hawaii.edu/rqds/hourly.fmt}.
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

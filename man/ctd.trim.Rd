\name{ctd.trim}
\alias{ctd.trim}
\title{Trim start/end portions of a CTD cast}
\description{
  Trim start/end portions of a CTD cast.
}
\usage{
ctd.trim(x, method="downcast",parameters=NULL)
}
\arguments{
  \item{x}{A \code{ctd} object, e.g. as read by \code{\link{read.ctd}}.}
  \item{method}{Various methods exist, some of which use parameters:
    \item{"downcast"}{Select only data for which the CTD is descending, as
      inferred from the pressure change over time}
    \item{"upcast"}{Reverse of "downcast" ... not too useful}
    \item{"index"}{Select values only in indicated list of indices,
      \emph{e.g.} \code{selection <- trim.ctd(ctd, "index", seq(10,30))}
      selects data points 10, 11, ... 30.}
    \item{"(ANYTHING ELSE)"}{Select data only if the named item
      (\emph{e.g.} \code{scan}, \code{time}, \emph{etc}.) falls
	  in the range of values indicated by \code{parameters}.  If one 
	  parameter is given, it is a lower limit.  If two parameters
	  are given, they are a range.
      For example, \code{ctd2 <- trim.ctd(ctd, "scan", 5)} 
      starts at scan number 5 and continues to the end,
      while \code{ctd3 <- trim.ctd(ctd, "scan", c(5,100))}
      also starts at scan 5, but extends only to scan 100.}
  }
  \item{parameters}{Depends on method; see above.}
}
\details{
  The code is quite straightforward, and indeed it's a good idea to check
  the code, if you want something more sophisticated, \emph{e.g.} selecting
  data based on a T-S criterion.  The most common use of this is to run
  \code{plot.ctd.scan()} together with \code{ctd.trim}, identifying
  by eye an initial period in which the CTD is in the air or
  unequilibrated in the water, and a final period in which the CTD is 
  no longer descending.
} \value{
  A new \code{ctd} object.
}

\seealso{
  The \code{ctd} object may be read with \code{\link{read.ctd}}.  
  \code{\link{plot.ctd.scan}} is very useful in providing guidance
  in how to trim; it is common practice to plot a scan first, then
  to trim by scan.
}
\examples{
library(oce)
data(ctd) 
ctd.trimmed <- ctd.trim(ctd, "pressure", c(3, 5))
summary(ctd.trimmed)
}
\references{
  The Seabird CTD instrument is described at
  \url{http://www.seabird.com/products/spec_sheets/19plusdata.htm}.
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

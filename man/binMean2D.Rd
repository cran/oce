% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.R
\name{binMean2D}
\alias{binMean2D}
\title{Bin-average f=f(x,y)}
\usage{
binMean2D(x, y, f, xbreaks, ybreaks, flatten = FALSE, fill = FALSE,
  fillgap = -1)
}
\arguments{
\item{x}{Vector of numerical values.}

\item{y}{Vector of numerical values.}

\item{f}{Matrix of numerical values, a matrix f=f(x,y).}

\item{xbreaks}{Vector of values of \code{x} at the boundaries between bins, calculated using
\code{\link{pretty}(x)} if not supplied.}

\item{ybreaks}{Vector of values of \code{y} at the boundaries between bins, calculated using
\code{\link{pretty}(y)} if not supplied.}

\item{flatten}{A logical value indicating whether 
the return value also contains equilength
vectors \code{x}, \code{y}, \code{z} and \code{n}, a flattened
representation of \code{xmids}, \code{ymids}, \code{result} and
\code{number}.}

\item{fill}{Logical value indicating whether to fill \code{NA}-value gaps in
the matrix. Gaps will be filled as the average of linear interpolations
across rows and columns. See \code{fillgap}, which works together with this.}

\item{fillgap}{Integer controlling the size of gap that can be filled
across. If this is negative (as in the default), gaps will be filled
regardless of their size. If it is positive, then gaps exceeding this
number of indices will not be filled.}
}
\value{
A list with the following elements: the midpoints (renamed as
\code{x} and \code{y}), the count (\code{number}) of \code{f(x,y)} values
for \code{x} and \code{y} values that lie between corresponding breaks,
and the resultant average (\code{f}) of \code{f(x,y)}, classified by the
\code{x} and \code{y} breaks.
}
\description{
Average the values of a vector \code{f(x,y)} in bins defined on 
vectors \code{x} and \code{y}. A common example might be averaging 
spatial data into location bins.
}
\examples{
library(oce)
x <- runif(500)
y <- runif(500)
f <- x + y
xb <- seq(0, 1, 0.1)
yb <- seq(0, 1, 0.2)
m <- binMean2D(x, y, f, xb, yb)
plot(x, y)
contour(m$xmids, m$ymids, m$result, add=TRUE, levels=seq(0, 2, 0.5), labcex=1)

}
\author{
Dan Kelley
}
\seealso{
Other bin-related functions: \code{\link{binApply1D}},
  \code{\link{binApply2D}}, \code{\link{binAverage}},
  \code{\link{binCount1D}}, \code{\link{binCount2D}},
  \code{\link{binMean1D}}
}

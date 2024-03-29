% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/windrose.R
\name{as.windrose}
\alias{as.windrose}
\title{Create a windrose Object}
\usage{
as.windrose(x, y, dtheta = 15, debug = getOption("oceDebug"))
}
\arguments{
\item{x}{The x component of wind speed (or stress) \emph{or} an object of class
\code{met} (see \linkS4class{met}), in which case the \code{u} and
\code{v} components of that object are used for the components of wind speed,
and \code{y} here is ignored.}

\item{y}{The y component of wind speed (or stress).}

\item{dtheta}{The angle increment (in degrees) within which to classify the data.}

\item{debug}{A flag that turns on debugging.  Set to 1 to get a moderate amount
of debugging information, or to 2 to get more.}
}
\value{
A \linkS4class{windrose} object, with \code{data} slot containing

\tabular{ll}{
\strong{Item}   \tab \strong{Meaning}\cr
\code{n}       \tab the number of \code{x} values\cr
\code{x.mean}  \tab the mean of the \code{x} values\cr
\code{y.mean}  \tab the mean of the \code{y} values\cr
\code{theta}   \tab the central angle (in degrees) for the class\cr
\code{count}   \tab the number of observations in this class\cr
\code{mean}    \tab the mean of the observations in this class\cr
\code{fivenum} \tab the \code{\link[=fivenum]{fivenum()}} vector for
observations in this class (the min, the lower hinge, the
median, the upper hinge, and the max)\cr
}
}
\description{
Create a wind-rose object, typically for plotting with
\code{\link[=plot,windrose-method]{plot,windrose-method()}}.
}
\examples{
library(oce)
set.seed(1234)
theta <- seq(0, 360, 0.25)
x <- 1 + cos(pi / 180 * theta) + rnorm(theta)
y <- sin(pi / 180 * theta) + rnorm(theta)
wr <- as.windrose(x, y)
summary(wr)

}
\seealso{
Other things related to windrose data: 
\code{\link{[[,windrose-method}},
\code{\link{[[<-,windrose-method}},
\code{\link{plot,windrose-method}},
\code{\link{summary,windrose-method}},
\code{\link{windrose-class}}
}
\author{
Dan Kelley, with considerable help from Alex Deckmyn.
}
\concept{things related to windrose data}

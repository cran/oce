\name{grad}

\alias{grad}

\title{Gradient of a matrix}

\description{Calculate the grad of a matrix by first differences}

\usage{grad(h, x, y)}

\arguments{
    \item{h}{a matrix}
    \item{x}{x values}
    \item{y}{y values}
}

\details{In the interior of the matrix, centred second-order differences are
    used to infer the components of the grad.  Along the edges, first-order
    differences are used.}
    
\value{A list containing \code{gx} and \code{gy}, matrices of the same
    dimension as \code{h}.}

\examples{
## Geostrophic flow around an eddy
library(oce)
dx <- 5e3
dy <- 10e3
x <- seq(-200e3, 200e3, dx)
y <- seq(-200e3, 200e3, dy)
R <- 100e3
h <- outer(x, y, function(x, y) 500*exp(-(x^2+y^2)/R^2))
grad <- grad(h, x, y)
par(mfrow=c(2,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
contour(x,y,h,asp=1, main=expression(h))
f <- 1e-4
gprime <- 9.8 * 1 / 1024
u <- -(gprime / f) * grad$gy
v <-  (gprime / f) * grad$gx
contour(x, y, u, asp=1, main=expression(u))
contour(x, y, v, asp=1, main=expression(v))
contour(x, y, sqrt(u^2+v^2), asp=1, main=expression(speed))
}

\author{Dan Kelley, based on advice of Clark Richards, and mimicking a matlab function.}

\keyword{misc}
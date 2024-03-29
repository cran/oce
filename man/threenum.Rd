% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.R
\name{threenum}
\alias{threenum}
\title{Calculate Minimum, Mean, and Maximum Values}
\usage{
threenum(x)
}
\arguments{
\item{x}{a vector or matrix of numerical values.}
}
\value{
A character vector of three values: the minimum, the mean, the
maximum.
}
\description{
This is a simpler cousin of the standard \code{\link[=fivenum]{fivenum()}} function,
used in \code{\link[=summary]{summary()}} functions for \code{oce} objects.
}
\section{Historical note}{

On Aug 5, 2019, the dimension was dropped as the fourth column, and
this function returned to the original intention (revealed by its
name).  Another change is that the function now returns numerical
results, leaving the task of setting the number of digits to
\code{\link[=summary]{summary()}}.
}

\examples{
library(oce)
threenum(1:10)
}
\author{
Dan Kelley
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oce.R
\name{tail.oce}
\alias{tail.oce}
\title{Extract the End of an Oce Object}
\usage{
\method{tail}{oce}(x, n = 6L, ...)
}
\arguments{
\item{x}{an \linkS4class{oce} object.}

\item{n}{Number of elements to extract, as for \code{\link[=tail]{tail()}}.}

\item{...}{ignored}
}
\description{
Extract the End of an Oce Object

This function handles the following object classes directly:
\linkS4class{adp},
\linkS4class{adv},
\linkS4class{argo} (selection by profile),
\linkS4class{coastline},
\linkS4class{ctd},
\linkS4class{echosounder} (selection by ping),
\linkS4class{section} (selection by station)
and
\linkS4class{topo} (selection by longitude and latitude).
It does not handle
\linkS4class{amsr} or
\linkS4class{landsat}
yet, instead issuing a warning and returning \code{x} in those cases.
For all other classes, it calls \code{\link[=tail]{tail()}}
with \code{n} as provided, for each item in the \code{data}
slot, issuing a warning if that item is not a vector; the
author is quite aware that this may not work well for all classes.
The plan is to handle all appropriate classes by July 2018.
Please contact the author if there is a class you need handled
before that date.
}
\seealso{
\code{\link[=head.oce]{head.oce()}}, which yields the start of an \code{oce} object.
}
\author{
Dan Kelley
}

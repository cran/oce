% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/topo.R
\name{subset,topo-method}
\alias{subset,topo-method}
\title{Subset a topo Object}
\usage{
\S4method{subset}{topo}(x, subset, ...)
}
\arguments{
\item{x}{a \linkS4class{topo} object.}

\item{subset}{A condition to be applied to the \code{data} portion of \code{x}.
See \dQuote{Details}.}

\item{...}{Ignored.}
}
\value{
A new \linkS4class{topo} object.
}
\description{
This function is somewhat analogous to \code{\link[=subset.data.frame]{subset.data.frame()}}.
Subsetting can be by \code{time} or \code{distance}, but these may not be
combined; use a sequence of calls to subset by both.
}
\examples{
# northern hemisphere
library(oce)
data(topoWorld)
plot(subset(topoWorld, latitude > 0))

}
\seealso{
Other things related to topo data: 
\code{\link{[[,topo-method}},
\code{\link{[[<-,topo-method}},
\code{\link{as.topo}()},
\code{\link{download.topo}()},
\code{\link{plot,topo-method}},
\code{\link{read.topo}()},
\code{\link{summary,topo-method}},
\code{\link{topo-class}},
\code{\link{topoInterpolate}()},
\code{\link{topoWorld}}

Other functions that subset oce objects: 
\code{\link{subset,adp-method}},
\code{\link{subset,adv-method}},
\code{\link{subset,amsr-method}},
\code{\link{subset,argo-method}},
\code{\link{subset,cm-method}},
\code{\link{subset,coastline-method}},
\code{\link{subset,ctd-method}},
\code{\link{subset,echosounder-method}},
\code{\link{subset,lobo-method}},
\code{\link{subset,met-method}},
\code{\link{subset,oce-method}},
\code{\link{subset,odf-method}},
\code{\link{subset,rsk-method}},
\code{\link{subset,sealevel-method}},
\code{\link{subset,section-method}},
\code{\link{subset,xbt-method}}
}
\author{
Dan Kelley
}
\concept{functions that subset oce objects}
\concept{things related to topo data}

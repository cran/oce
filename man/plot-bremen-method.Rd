% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bremen.R
\name{plot,bremen-method}
\alias{plot,bremen-method}
\alias{plot.bremen}
\title{Plot a bremen Object}
\usage{
\S4method{plot}{bremen}(x, type, ...)
}
\arguments{
\item{x}{a \linkS4class{bremen} object.}

\item{type}{Optional string indicating the type to which \code{x} should be
coerced before plotting. The choices are \code{ctd} and \code{ladp}.}

\item{...}{Other arguments, passed to plotting functions.}
}
\description{
Plot a \linkS4class{bremen} object.
If the first argument seems to be a CTD dataset, this uses \code{\link[=plot,ctd-method]{plot,ctd-method()}};
otherwise, that argument is assumed to be a \linkS4class{ladp} object, and a two-panel
plot is created with \code{\link[=plot,ladp-method]{plot,ladp-method()}} to show velocity variation with
pressure.
}
\seealso{
Other functions that plot oce data: 
\code{\link{download.amsr}()},
\code{\link{plot,adp-method}},
\code{\link{plot,adv-method}},
\code{\link{plot,amsr-method}},
\code{\link{plot,argo-method}},
\code{\link{plot,cm-method}},
\code{\link{plot,coastline-method}},
\code{\link{plot,ctd-method}},
\code{\link{plot,gps-method}},
\code{\link{plot,ladp-method}},
\code{\link{plot,landsat-method}},
\code{\link{plot,lisst-method}},
\code{\link{plot,lobo-method}},
\code{\link{plot,met-method}},
\code{\link{plot,odf-method}},
\code{\link{plot,rsk-method}},
\code{\link{plot,satellite-method}},
\code{\link{plot,sealevel-method}},
\code{\link{plot,section-method}},
\code{\link{plot,tidem-method}},
\code{\link{plot,topo-method}},
\code{\link{plot,windrose-method}},
\code{\link{plot,xbt-method}},
\code{\link{plotProfile}()},
\code{\link{plotScan}()},
\code{\link{plotTS}()},
\code{\link{tidem-class}}

Other things related to bremen data: 
\code{\link{[[,bremen-method}},
\code{\link{[[<-,bremen-method}},
\code{\link{bremen-class}},
\code{\link{read.bremen}()},
\code{\link{summary,bremen-method}}
}
\author{
Dan Kelley
}
\concept{functions that plot oce data}
\concept{things related to bremen data}

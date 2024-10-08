% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rsk.R
\name{subset,rsk-method}
\alias{subset,rsk-method}
\title{Subset a rsk Object}
\usage{
\S4method{subset}{rsk}(x, subset, ...)
}
\arguments{
\item{x}{an \linkS4class{rsk} object.}

\item{subset}{a condition to be applied to the \code{data} portion of \code{x}.
See \dQuote{Details}.}

\item{\dots}{ignored.}
}
\value{
An \linkS4class{rsk} object.
}
\description{
Subset a rsk object.  This function is somewhat analogous to
\code{\link[=subset.data.frame]{subset.data.frame()}}, but subsetting is only permitted by time.
}
\examples{
library(oce)
data(rsk)
plot(rsk)
plot(subset(rsk, time < mean(range(rsk[["time"]]))))

}
\seealso{
Other things related to rsk data: 
\code{\link{[[,rsk-method}},
\code{\link{[[<-,rsk-method}},
\code{\link{as.rsk}()},
\code{\link{ctdFindProfilesRBR}()},
\code{\link{plot,rsk-method}},
\code{\link{read.rsk}()},
\code{\link{rsk}},
\code{\link{rsk-class}},
\code{\link{rskPatm}()},
\code{\link{rskToc}()},
\code{\link{summary,rsk-method}}

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
\code{\link{subset,sealevel-method}},
\code{\link{subset,section-method}},
\code{\link{subset,topo-method}},
\code{\link{subset,xbt-method}}
}
\author{
Dan Kelley
}
\concept{functions that subset oce objects}
\concept{things related to rsk data}

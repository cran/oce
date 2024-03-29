% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coastline.R
\name{read.coastline.openstreetmap}
\alias{read.coastline.openstreetmap}
\title{Read a coastline File in Openstreetmap Format}
\usage{
read.coastline.openstreetmap(
  file,
  lonlim = c(-180, 180),
  latlim = c(-90, 90),
  monitor = FALSE,
  encoding = NA,
  debug = getOption("oceDebug"),
  processingLog
)
}
\arguments{
\item{file}{name of file containing coastline data (a file ending in \code{.shp})
or a zipfile that contains such a file, with a corresponding name.
The second scheme is useful for files downloaded from the NaturalEarth
website (see reference 2).}

\item{lonlim, latlim}{numerical vectors specifying the
west and east edges (and south and north edges) of a focus window.
Coastline polygons that do not intersect the defined box are
skipped, which can be useful in narrowing high-resolution world-scale
data to a local application.}

\item{monitor}{Logical indicating whether to print an indication of progress through
the file.}

\item{encoding}{ignored.}

\item{debug}{set to TRUE to print information about the header, etc.}

\item{processingLog}{if provided, the action item to be stored in the log.
(Typically only provided for internal calls; the default that it provides is
better for normal calls by a user.)}
}
\value{
a \linkS4class{coastline} object.
}
\description{
Read coastline data stored in the openstreetmap format.
}
\seealso{
Other things related to coastline data: 
\code{\link{[[,coastline-method}},
\code{\link{[[<-,coastline-method}},
\code{\link{as.coastline}()},
\code{\link{coastline-class}},
\code{\link{coastlineBest}()},
\code{\link{coastlineCut}()},
\code{\link{coastlineWorld}},
\code{\link{download.coastline}()},
\code{\link{plot,coastline-method}},
\code{\link{read.coastline.shapefile}()},
\code{\link{subset,coastline-method}},
\code{\link{summary,coastline-method}}
}
\author{
Dan Kelley
}
\concept{things related to coastline data}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/amsr.R
\docType{class}
\name{amsr-class}
\alias{amsr-class}
\title{Class to Store AMSR-2 Satellite Data}
\description{
This class stores data from the AMSR-2 satellite.
}
\details{
The Advanced Microwave Scanning Radiometer (AMSR-2) is in current operation on
the Japan Aerospace Exploration Agency (JAXA) GCOM-W1 space craft, launched in
May 2012. Data are processed by Remote Sensing Systems. The satellite
completes an ascending and descending pass during local daytime and nighttime
hours respectively. Each daily file contains 7 daytime and 7 nighttime
maps of variables named as follows within the \code{data}
slot of amsr objects: \code{timeDay},
\code{SSTDay}, \code{LFwindDay} (wind at 10m sensed in
the 10.7GHz band), \code{MFwindDay} (wind at 10m sensed at 18.7GHz),
\code{vaporDay}, \code{cloudDay}, and \code{rainDay}, along with
similarly-named items that end in \code{Night}.
See reference 1 for additional information on the instrument, how
to cite the data source in a paper, etc.

The bands are stored in \code{\link[=raw]{raw()}} form, to save storage. The accessor
function \code{\link{[[,amsr-method}} can provide these values in \code{raw}
form or in physical units; \code{\link[=plot,amsr-method]{plot,amsr-method()}}, and
\code{\link[=summary,amsr-method]{summary,amsr-method()}} work with physical units.
}
\section{Slots}{

\describe{
\item{\code{data}}{As with all \code{oce} objects, the \code{data} slot
for \code{amsr} objects is a
\link{list} containing the main data for the object.
{}}

\item{\code{metadata}}{As with all \code{oce} objects, the \code{metadata} slot
for \code{amsr} objects is a \link{list} containing
information about the \code{data} or about the object itself.
Examples that are of common interest include  \code{longitude} and \code{latitude}, which define the grid.}

\item{\code{processingLog}}{As with all \code{oce} objects, the \code{processingLog} slot
for \code{amsr} objects is a
\link{list} with entries describing the creation and evolution
of the object. The contents are updated by various \code{oce} functions to
keep a record of processing steps.  Object summaries and
\code{\link[=processingLogShow]{processingLogShow()}} both display the log.}
}}

\section{Modifying slot contents}{


Although the \code{[[<-} operator may permit modification of the contents
of \linkS4class{amsr} objects (see \code{\link{[[<-,amsr-method}}),
it is better to use \code{\link[=oceSetData]{oceSetData()}} and \code{\link[=oceSetMetadata]{oceSetMetadata()}},
because those functions save an entry in the \code{processingLog}
that describes the change.
}

\section{Retrieving slot contents}{


The full contents of the \code{data} and \code{metadata} slots of a \linkS4class{amsr}
object may be retrieved in the standard R way using \code{\link[=slot]{slot()}}. For
example \code{slot(o,"data")} returns the \code{data} slot of an object named \code{o},
and similarly \code{slot(o,"metadata")} returns
the \code{metadata} slot.

The slots may also be obtained with the \code{\link{[[,amsr-method}}
operator, as e.g. \code{o[["data"]]} and \code{o[["metadata"]]}, respectively.

The \code{\link{[[,amsr-method}} operator can also
be used to retrieve items from within the \code{data} and \code{metadata} slots.
For example, \code{o[["temperature"]]} can be used to retrieve temperature
from an object containing that quantity. The rule is that a named
quantity is sought first within the object's \code{metadata} slot,
with the \code{data} slot being checked only if \code{metadata} does not
contain the item. This \code{[[} method can also be used to get
certain derived quantities, if the object contains sufficient
information to calculate them. For example, an object that holds
(practical) salinity, temperature and pressure, along with
longitude and latitude, has sufficient information to compute
Absolute Salinity, and so \code{o[["SA"]]} will yield the
calculated Absolute Salinity.

It is also possible to find items more directly, using \code{\link[=oceGetData]{oceGetData()}} and
\code{\link[=oceGetMetadata]{oceGetMetadata()}}, but neither of these functions can
retrieve derived items.
}

\references{
\enumerate{
\item Information on the satellite, how to cite the data, etc. is
provided at \verb{http://www.remss.com/missions/amsr/}.
\item A simple interface for viewing and downloading data is at
\verb{http://images.remss.com/amsr/amsr2_data_daily.html}.
}
}
\seealso{
Other classes holding satellite data: 
\code{\link{g1sst-class}},
\code{\link{landsat-class}},
\code{\link{satellite-class}}

Other things related to amsr data: 
\code{\link{[[,amsr-method}},
\code{\link{[[<-,amsr-method}},
\code{\link{amsr}},
\code{\link{composite,amsr-method}},
\code{\link{download.amsr}()},
\code{\link{plot,amsr-method}},
\code{\link{read.amsr}()},
\code{\link{subset,amsr-method}},
\code{\link{summary,amsr-method}}
}
\author{
Dan Kelley and Chantelle Layton
}
\concept{classes holding satellite data}
\concept{things related to amsr data}

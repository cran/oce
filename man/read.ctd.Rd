\name{read.ctd}
\alias{read.ctd}
\title{Scan seawater (CTD) data file}
\description{
  Read a data file created by a Sea-Bird CTD.
}
\usage{
read.ctd(file, type="SBE19", debug=FALSE,
 	columns=NULL, check.human.headers=TRUE)
}
\arguments{
  \item{file}{A connection or a character string giving the name of the
    file to load.}
  \item{type}{String indicating type of instrument: 
    \code{SBE19} stands for the \emph{Seabird 19} CTD.}
  \item{debug}{Set true to print debugging information.}
  \item{columns}{If NULL, \code{read.ctd} tries to infer column names from the
                 header.  If a list, then it will be taken to be the list
				 of columns.  The list \emph{must} include "pressure", "temperature"
				 and either "conductivity" or "salinity", or else very little
				 can be done with the file.}
  \item{check.human.headers}{Set TRUE to make it give warnings for missing human-written header items.}
}
\details{
  Oceanographers use a CTD (conductivity-temperature-depth) instrument
  to measure some key properties of ocean Physics.  This function reads
  CTD datasets created with the popular Sea-Bird instrument.
  Although \code{read.ctd} scans the header information in an 
  attempt to infer the measured variables, it cannot account for 
  the wide variability of headers that are used in practice.  For
  example, in the first file tested during development, 
  the sampling rate was written as
  \code{* sample rate = 1 scan every 0.5 seconds}, while 
  in the second test file it was written 
  \code{* Real-Time Sample Interval = 0.125 seconds}.  Yes,
  there are similarities, but what is the general rule?  Nobody
  has been able to tell me ... and all of this suggests that a 
  robust scanner will never be written.  The best advice is
  to read in a CTD object (\code{c}, say) using
  the default scheme and then to do \code{attributes(c)} to discover
  whether the fields of interest were filled in.  Then, check 
  whether the columns were discovered correctly; if not, read it 
  again and then set the attributes manually.
}
\value{
  A \code{ctd} object containing information about the station
  (e.g. \code{latitude}, etc.), along with vectors containing the
  acquired data (e.g. \code{S}, etc.).  The full header is also
  contained in the list.  Specifically, the returned list contains:
  \item{header[]}{the header itself, normally containing 66 lines of information}
  \item{ship}{name of the ship from which the CTD was deployed}
  \item{scientist}{name of the scientist taking the data}
  \item{institute}{name of the institute}
  \item{address}{the address of the institute where the scientist}
  \item{cruise}{name of cruise}
  \item{mooring}{mooring number or name}
  \item{date}{date of lowering of CTD into the water}
  \item{latitude}{latitude, as a character string}
  \item{latitude.dec}{latitude, in decimal degrees positive north of equator}
  \item{longitude}{longitude, as a character string} 
  \item{longitude.dec}{longitude, in decimal degrees, positive if east
    of Greenwich and west of dateline} 
  \item{recovery}{date of recovery of CTD}
  \item{sample.interval}{time interval between samples [s]}
  \item{water.depth}{the water depth at the site [m]}
  \item{processing.log}{A processing log.}
  \item{data}{A data table containing the profile data as vectors.  The column
    names are discovered from the header, and may thus differ from file
    to file.  For example, some CTD instruments may have a fluorometer
    connected, others may not.  The following vectors are, however,
    guaranteed to be present: \code{data$pressure}, 
    \code{data$salinity},  \code{data$temperature} and
    \code{data$sigma}. and \code{data$OK}. 
    Note that \code{data$sigma} is calculated 
    from the pressure, salinity, and temperature in the file, using 
    \code{\link{sw.sigma}}.  If the file also contains \code{\link{sw.sigma.t}}
    or \code{\link{sw.sigma.theta}}, then these will also appear in the data
    table.}
}

\seealso{
  \code{\link{summary.ctd}}
}
\examples{
\dontrun{
library(oce)
prof <- read.ctd("/usr/local/lib/R/library/oce/demo/ctdprofile.cnv")
attach(prof)
plot(t, pressure) # T profile
}
}
\references{
  The Seabird CTD instrument is described at
  \url{http://www.seabird.com/products/spec_sheets/19plusdata.htm}.
}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

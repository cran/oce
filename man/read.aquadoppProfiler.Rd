% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adp.nortek.R
\name{read.aquadoppProfiler}
\alias{read.aquadoppProfiler}
\title{Read an adp File in Nortek Aquadopp Format}
\usage{
read.aquadoppProfiler(
  file,
  from = 1,
  to,
  by = 1,
  tz = getOption("oceTz"),
  longitude = NA,
  latitude = NA,
  orientation,
  distance,
  monitor = FALSE,
  despike = FALSE,
  encoding = NA,
  processingLog,
  debug = getOption("oceDebug"),
  ...
)
}
\arguments{
\item{file}{a connection or a character string giving the name of the file
to load.  (For \code{read.adp.sontek.serial}, this is generally a list of
files, which will be concatenated.)}

\item{from}{indication of the first profile to read.  This can be an
integer, the sequence number of the first profile to read, or a POSIXt time
before which profiles should be skipped, or a character string that converts
to a POSIXt time (assuming UTC timezone).  See \dQuote{Examples}, and make
careful note of the use of the \code{tz} argument. If \code{from} is not
supplied, it defaults to 1.}

\item{to}{an optional indication of the last profile to read, in a
format as described for \code{from}.  As a special case, \code{to=0} means
to read the file to the end.  If \code{to} is not supplied, then it defaults
to 0.}

\item{by}{an optional indication of the stride length to use while walking through
the file.  If this is an integer, then \code{by-1} profiles are skipped
between each pair of profiles that is read, e.g. the default \code{by=1}
means to read all the data.  (For RDI files \emph{only}, there are some
extra features to avoid running out of memory; see \dQuote{Memory considerations}.)}

\item{tz}{character string indicating time zone to be assumed in the data.}

\item{longitude}{optional signed number indicating the longitude in degrees
East.}

\item{latitude}{optional signed number indicating the latitude in degrees
North.}

\item{orientation}{Optional character string specifying the orientation of the
sensor, provided for those cases in which it cannot be inferred from the
data file.  The valid choices are \code{"upward"}, \code{"downward"}, and
\code{"sideward"}.}

\item{distance}{Optional vector holding the distances of bin centres from the
sensor.  This argument is ignored except for Nortek profilers, and need not
be given if the function determines the distances correctly from the data.
The problem is that the distance is poorly documented in the Nortek System
Integrator Guide (2008 edition, page 31), so the function must rely on
word-of-mouth formulae that do not work in all cases.}

\item{monitor}{boolean value indicating whether to indicate the progress
of reading the file, by using \code{\link[=txtProgressBar]{txtProgressBar()}} or otherwise.  The value
of \code{monitor} is changed to \code{FALSE} automatically, for non-interactive
sessions.}

\item{despike}{if \code{TRUE}, \code{\link[=despike]{despike()}} will be used to clean
anomalous spikes in heading, etc.}

\item{encoding}{ignored.}

\item{processingLog}{if provided, the action item to be stored in the log.
(Typically only provided for internal calls; the default that it provides is
better for normal calls by a user.)}

\item{debug}{a flag that turns on debugging.  Set to 1 to get a moderate
amount of debugging information, or to 2 to get more.}

\item{\dots}{optional additional arguments that some (but not all)
\verb{read.adp.*()} functions pass to lower-level functions.}
}
\value{
An \linkS4class{adp} object.
The contents of that object make sense for the particular instrument
type under study, e.g. if the data file contains
NMEA strings, then navigational data will be stored in an item
called \code{nmea} in the \code{data} slot).
}
\description{
The R code is based on information in
the Nortek System Integrator Guide (2008) and on postings on the Nortek
``knowledge center'' discussion board.  One might assume that the latter is
less authoritative than the former.  For example, the inference of cell size
follows advice found at
\verb{https://www.nortekusa.com/en/knowledge-center/forum/hr-profilers/736804717},
which contains a typo in an early posting that is
corrected later on.
}
\section{How the binary file is decoded}{


This file type, like other acoustic-Doppler types, is read
with a hybrid R/C++ system, for efficiency.
The processing steps are sketched below, for
users who want to inspect the code or build upon it.
\enumerate{
\item In R, \code{\link[=readBin]{readBin()}} is used to insert the file contents into
a \link{vector} of type \code{raw}.
\item In C++, this raw vector is scanned byte by byte,
to find the starting indices of data "chunks", or subsections of
the data that correspond to individual sampling times.
Checksum computations are also done at this stage, to detect
possible data corruption.  Warnings are issued for any bad chunks,
and they are skipped in further processing. The valid
starting points are then passed back to R as a \link{vector} of
type \code{integer}.
\item In R, \code{\link[=readBin]{readBin()}} is used to read the components of each chunk.
For speed, this is done in a vectorized fashion. For example,
all the velocities in the whole file are read in a single call
to \code{\link[=readBin]{readBin()}}. This process is done for each of the data
fields that are to be handled.  Importantly, these \code{\link[=readBin]{readBin()}}
calls are tailored to the data, using values of
the \code{size}, \code{endian} and \code{signed} parameters that are tailored
to the structure of the given component.
Scaling factors are then applied as required, to convert the
components to physical units.
\item Finally, in R, the acquired items are inserted into the \code{data} or
\code{metadata} slot of the return value, according to oce convention.
}
}

\references{
\enumerate{
\item Information on Nortek profilers (including the System Integrator Guide,
which explains the data format byte-by-byte) is available at
\verb{https://www.nortekusa.com/}.  (One must join the site to see the
manuals.)
\item The Nortek Knowledge Center
\verb{https://www.nortekusa.com/en/knowledge-center} may be of help if
problems arise in dealing with data from Nortek instruments.
}
}
\seealso{
Other things related to adp data: 
\code{\link{[[,adp-method}},
\code{\link{[[<-,adp-method}},
\code{\link{ad2cpCodeToName}()},
\code{\link{ad2cpHeaderValue}()},
\code{\link{adp}},
\code{\link{adp-class}},
\code{\link{adpAd2cpFileTrim}()},
\code{\link{adpConvertRawToNumeric}()},
\code{\link{adpEnsembleAverage}()},
\code{\link{adpFlagPastBoundary}()},
\code{\link{adpRdiFileTrim}()},
\code{\link{adp_rdi.000}},
\code{\link{applyMagneticDeclination,adp-method}},
\code{\link{as.adp}()},
\code{\link{beamName}()},
\code{\link{beamToXyz}()},
\code{\link{beamToXyzAdp}()},
\code{\link{beamToXyzAdpAD2CP}()},
\code{\link{beamToXyzAdv}()},
\code{\link{beamUnspreadAdp}()},
\code{\link{binmapAdp}()},
\code{\link{enuToOther}()},
\code{\link{enuToOtherAdp}()},
\code{\link{handleFlags,adp-method}},
\code{\link{is.ad2cp}()},
\code{\link{plot,adp-method}},
\code{\link{read.adp}()},
\code{\link{read.adp.ad2cp}()},
\code{\link{read.adp.nortek}()},
\code{\link{read.adp.rdi}()},
\code{\link{read.adp.sontek}()},
\code{\link{read.adp.sontek.serial}()},
\code{\link{read.aquadopp}()},
\code{\link{read.aquadoppHR}()},
\code{\link{rotateAboutZ}()},
\code{\link{setFlags,adp-method}},
\code{\link{subset,adp-method}},
\code{\link{subtractBottomVelocity}()},
\code{\link{summary,adp-method}},
\code{\link{toEnu}()},
\code{\link{toEnuAdp}()},
\code{\link{velocityStatistics}()},
\code{\link{xyzToEnu}()},
\code{\link{xyzToEnuAdp}()},
\code{\link{xyzToEnuAdpAD2CP}()}

Other functions that read adp data: 
\code{\link{read.adp}()},
\code{\link{read.adp.ad2cp}()},
\code{\link{read.adp.nortek}()},
\code{\link{read.adp.rdi}()},
\code{\link{read.adp.sontek}()},
\code{\link{read.adp.sontek.serial}()},
\code{\link{read.aquadopp}()},
\code{\link{read.aquadoppHR}()}
}
\author{
Dan Kelley
}
\concept{functions that read adp data}
\concept{things related to adp data}

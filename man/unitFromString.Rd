% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.R
\name{unitFromString}
\alias{unitFromString}
\title{Decode units, from strings}
\usage{
unitFromString(s)
}
\arguments{
\item{s}{A string.}
}
\value{
A \code{\link[=list]{list()}} of two items: \code{unit} which is an
\code{\link[=expression]{expression()}}, and \code{scale}, which is a string.
}
\description{
Decode units, from strings
}
\examples{
unitFromString("DB") # dbar
}
\seealso{
Other functions that interpret variable names and units from headers: 
\code{\link{ODFNames2oceNames}()},
\code{\link{cnvName2oceName}()},
\code{\link{oceNames2whpNames}()},
\code{\link{oceUnits2whpUnits}()},
\code{\link{unitFromStringRsk}()},
\code{\link{woceNames2oceNames}()},
\code{\link{woceUnit2oceUnit}()}
}
\concept{functions that interpret variable names and units from headers}

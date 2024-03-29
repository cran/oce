% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.R
\name{fullFilename}
\alias{fullFilename}
\title{Full Name of File, Including Path}
\usage{
fullFilename(filename)
}
\arguments{
\item{filename}{name of file}
}
\value{
Full file name
}
\description{
Determines the full name of a file, including the path.  Used by many
\code{read.X} routines, where \code{X} is the name of a class of object.
This is a wrapper around \code{\link[=normalizePath]{normalizePath()}}, with warnings turned
off so that messages are not printed for files that are
not found (e.g. URLs).
}
\author{
Dan Kelley
}

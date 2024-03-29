% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.R
\name{dataLabel}
\alias{dataLabel}
\title{Associate Data Names With Units}
\usage{
dataLabel(names, units)
}
\arguments{
\item{names}{the names of data within an object}

\item{units}{the units from metadata}
}
\value{
a vector of strings, with blank entries for data with unknown units
}
\description{
Note that the whole object is not being given as an argument;
possibly this will reduce copying and thus storage impact.
}

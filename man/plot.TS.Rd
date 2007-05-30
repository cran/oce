\name{plot.TS}
\alias{plot.TS}
\title{Plot temperature-salinity diagram for seawater (CTD) data}
\description{
  Plot temperature-salinity diagram for seawater (CTD) data.
}
\usage{
plot.TS(x, rho.levels = 8, grid = FALSE,
	col.data="black", col.rho="blue",  col.grid = "lightgray",
    cex.rho=0.8,
    rho1000=TRUE,
	debug=FALSE, \dots)
}
\arguments{
  \item{x}{A \code{cdt} object, e.g. as read by \code{\link{read.ctd}}.}
  \item{rho.levels}{Either a list of density levels for which to draw 
                    isopycnal lines, or a suggestion for the number of levels.
 					In the latter case, \code{pretty()} is used to select levels.}
  \item{grid}{Set \code{TRUE} to get a grid.}
  \item{col.data}{Color for data.}
  \item{col.rho}{Color for isopycnal lines.}
  \item{col.grid}{Color of grid.}
  \item{debug}{Flag to turn on debugging mode (prints info on isopycnal choices)}
  \item{cex.rho}{cex value for isopycnal labels}
  \item{rho1000}{If TRUE, label isopycnals as e.g. 1024; if FALSE, label as e.g. 24}
  \item{\dots}{optional arguments passed to plotting functions.}
}
\details{
  Creates a temperature-salinity plot for a CTD cast. 
}
\value{
  None.
}

\seealso{
  \code{\link{summary.ctd}} summarizes the information, while
  \code{\link{read.ctd}} scans it from a file.
}
\examples{
\dontrun{
library(oce)
profile <- read.ctd("/usr/local/lib/R/library/oce/demo/ctdprofile.cnv")
attach(profile)
plot.TS(profile)
# North Atlantic thermocline water, mixing to Antarctic Intermediate Water
# (after Defant's analysis)
N <- 10
Srange <- c(34.15, 35.94)
Trange <- c(3.3,18)
SS <- Srange[1] + (Srange[2] - Srange[1]) *(1:N)/(N-1) + 0.01*rnorm(N)
TT <- Trange[1] + (Trange[2] - Trange[1]) *(1:N)/(N-1) + 0.01*rnorm(N)
plot.TS(as.CTD(S=SS, T=TT, p=0),type='b',pch=19)
}
}
\references{}
\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cm.R
\docType{data}
\name{cm}
\alias{cm}
\title{Sample cm Data}
\usage{
data(cm)
}
\description{
The result of using \code{\link[=read.cm]{read.cm()}} on a current meter file holding measurements made with an
Interocean S4 device.  See \code{\link[=read.cm]{read.cm()}} for some general cautionary notes on reading such
files. Note that the salinities in this sample dataset are known to be incorrect, perhaps
owing to a lack of calibration of an old instrument that had not been used in a long time.
}
\examples{
library(oce)
data(cm)
summary(cm)
plot(cm)

}
\seealso{
Other datasets provided with oce: 
\code{\link{adp}},
\code{\link{adv}},
\code{\link{amsr}},
\code{\link{argo}},
\code{\link{coastlineWorld}},
\code{\link{ctdRaw}},
\code{\link{ctd}},
\code{\link{echosounder}},
\code{\link{landsat}},
\code{\link{lisst}},
\code{\link{lobo}},
\code{\link{met}},
\code{\link{ocecolors}},
\code{\link{rsk}},
\code{\link{sealevelTuktoyaktuk}},
\code{\link{sealevel}},
\code{\link{section}},
\code{\link{topoWorld}},
\code{\link{wind}},
\code{\link{xbt}}

Other things related to cm data: 
\code{\link{[[,cm-method}},
\code{\link{[[<-,cm-method}},
\code{\link{applyMagneticDeclination,cm-method}},
\code{\link{as.cm}()},
\code{\link{cm-class}},
\code{\link{plot,cm-method}},
\code{\link{read.cm}()},
\code{\link{rotateAboutZ}()},
\code{\link{subset,cm-method}},
\code{\link{summary,cm-method}}
}
\concept{datasets provided with oce}
\concept{things related to cm data}

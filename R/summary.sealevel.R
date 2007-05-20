summary.sealevel <- function(object, ...)
{
	if (!inherits(object, "sealevel"))
		stop("method is only for sealevel objects")
	cat(paste("Station\n"))
	cat(paste("  number:     ", object$station.number,  "\n"))
	cat(paste("  version:    ", object$station.version, "\n"))
	cat(paste("  name:       ", object$station.name,    "\n"))
	cat(paste("  region:     ", object$region,          "\n"))
	cat(paste("  latitude:   ", object$latitude,        "\n"))
	cat(paste("  longitude:  ", object$longitude,       "\n"))
	cat(paste("Data\n"))
	cat(paste("  start time: ", object$start.time, "\n", sep=""))
	cat(paste("  GMT offset: ", object$GMT.offset,"\n", sep=""))
	eta.m <- object$eta / 1000 # metres
	fn <- fivenum(eta.m, na.rm=TRUE)
	cat("Sealevel:\n");
	cat(paste("  min:    ", fn[1],      "\n",sep=""))
	cat(paste("  max:    ", fn[5],      "\n",sep=""))
	cat(paste("  median: ", fn[3],      "\n",sep=""))
	cat(paste("  mean:   ", mean(eta.m,na.rm=TRUE),"\n",sep=""))
}

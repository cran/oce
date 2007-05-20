summary.ctd <- function(object, ...)
{
  	if (!inherits(object, "ctd"))
    	stop("method is only for ctd objects")
  	cat("CTD profile from file", object$filename, "\n")
	cat("  Scientist : ", object$scientist, "\n");
	cat("  Ship      : ", object$ship, "\n");
	cat("  Cruise    : ", object$cruise, "\n");
	cat("  Institute : ", object$institute, "\n");
  	cat("  Location, raw: (", object$latitude, ",", object$longitude, ") = (", object$latitude.dec, ",", object$longitude.dec, ")\n")
  	#cat(paste("DEBUG: start time",object$start.time,"\n"))  
  	cat(paste("  Start time:", as.POSIXct(object$start.time), "\n"))
  	cat("  Deployed:", object$date, "\n")
  	#cat(" Start sec:", object$start.time, "\n")
  	cat("  Recovered:", object$recovery, "\n")
  	cat("  Water depth:", object$water.depth, "\n")
  	cat("  Number of levels:    ", length(object$data$temperature),  "\n")
  	cat(sprintf("  %5s %10s %10s %10s %10s %10s\n", "ITEM", "min", "Q1", "median", "Q3", "max"));
  	f<-fivenum(object$data$pressure);    cat(sprintf("  %5s %10.1f %10.1f %10.1f %10.1f %10.1f\n", "  P  ", f[1], f[2], f[3], f[4], f[5]))
  	f<-fivenum(object$data$temperature); cat(sprintf("  %5s %10.1f %10.1f %10.1f %10.1f %10.1f\n", "  T  ", f[1], f[2], f[3], f[4], f[5]))
  	f<-fivenum(object$data$salinity);    cat(sprintf("  %5s %10.1f %10.1f %10.1f %10.1f %10.1f\n", "  S  ", f[1], f[2], f[3], f[4], f[5]))
  	f<-fivenum(object$data$sigma);       cat(sprintf("  %5s %10.1f %10.1f %10.1f %10.1f %10.1f\n", "sigma", f[1], f[2], f[3], f[4], f[5]))
}
 

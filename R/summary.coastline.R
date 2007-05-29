summary.coastline <- function(object, ...)
{
  	if (!inherits(object, "coastline"))
    	stop("method is only for coastline objects")
  	cat(sprintf("Coastline object contains %d points, bounded within box\n",
 		length(object$lon)))
	cat(sprintf("%8.3f < longitude < %8.3f\n", 
		min(object$lon,na.rm=TRUE), 
		max(object$lon,na.rm=TRUE)))
	cat(sprintf("%8.3f < latitude  < %8.3f\n",
	 	min(object$lat,na.rm=TRUE), 
		max(object$lat,na.rm=TRUE)))
	processing.log.summary(object)
}

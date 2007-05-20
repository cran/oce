plot.coastline <- function (x, ...) 
{
	# NOTE: for projections, use maps package
    if (!inherits(x, "coastline")) 
        stop("method is only for coastline objects")
	asp <- 1 / cos(mean(range(x$lat,na.rm=TRUE))*pi/180)
    plot(x$lon, x$lat, type='l', asp=asp, xlab="", ylab="",...)
}

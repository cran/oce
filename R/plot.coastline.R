plot.coastline <- function (x, ...) 
{
	# NOTE: for projections, use maps package
    if (!inherits(x, "coastline")) 
        stop("method is only for coastline objects")
	asp <- 1 / cos(mean(range(x$data$latitude,na.rm=TRUE))*pi/180)
    plot(x$data$longitude, x$data$latitude, type='l', asp=asp, xlab="", ylab="",...)
}

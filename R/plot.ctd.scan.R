plot.ctd.scan <- function(x,
	name = "scan",
	col.S = "darkgreen",
	col.T = "darkred", col.p = "blue", ...)
{
	if (!inherits(x, "ctd")) 
        stop("method is only for ctd objects")
    oldpar <- par(no.readonly = TRUE)
	par(mar=c(4,4,1,4)) # bot left top right
	par(mfrow=c(2,1))  
	xx <- x$data[[name]];
	xxlen <- length(xx)
	if (xxlen < 1) 
		stop(paste("this ctd has no data column named '", name, "'",sep=""))
	if (xxlen != length(x$data$pressure))
		stop(paste("length mismatch.  '", name, "' has length ", xxlen, 
		" but pressure has length ", length(x$data$pressure),sep=""))
    plot(x$data[[name]], x$data$pressure, 
		xlab=name, ylab="Pressure [dbar]", 
		type="l", axes=FALSE)
	box()
	grid(col="brown")
	axis(1)
	axis(2,col=col.p, col.axis=col.p, col.lab = col.p)

	par(mar=c(4,4,1,4)) # bot left top right
	Slen <- length(x$data$salinity)
	Tlen <- length(x$data$temperature)
	if (Slen != Tlen)
		stop(paste("length mismatch.  'salinity' has length ", Slen, 
		" but 'temperature' has length ", Tlen, sep=""))
	plot(x$data[[name]], x$data$temperature, xlab="Scan", ylab="", type="l",
		col = col.T, axes=FALSE)
	axis(1)
	axis(2,col=col.T, col.axis = col.T, col.lab = col.T)
	box()
	grid(NULL, NA, col="brown")
    mtext("Temperature [degC]", side = 2, line = 2, col = col.T)
	#
	par(new=TRUE) # overplot
    plot(x$data[[name]], x$data$salinity, xlab="", ylab="", col=col.S, type="l", axes=FALSE)
    mtext("Salinity [PSU]", side = 4, line = 2, col = col.S)
	axis(4,col=col.S, col.axis = col.S, col.lab = col.S)
	par(oldpar)
}

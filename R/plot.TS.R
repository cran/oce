plot.TS <- function (x, rho.levels = 8, 
 	grid = FALSE,
	col.data="black", col.rho = "blue", col.grid = "lightgray",
	cex.rho=0.8,
	rho1000=TRUE,
	debug = FALSE, ...) 
{
    if (!inherits(x, "ctd")) 
        stop("method is only for ctd objects")
    plot(x$data$salinity, x$data$temperature, xlab = "", 
        ylab = expression(paste("temperature [", degree, "c]")),col=col.data, ...)
    mtext("salinity [psu]", side = 1, line = 2)
	if (grid)
		grid(col=col.grid)
	rho.min <- sw.sigma(min(x$data$salinity,na.rm=TRUE), max(x$data$temperature,na.rm=TRUE), 0)
	rho.max <- sw.sigma(max(x$data$salinity,na.rm=TRUE), min(x$data$temperature,na.rm=TRUE), 0)
    if (length(rho.levels) == 1) {
		rho.list <- pretty(c(rho.min, rho.max), n=rho.levels)
		# Trim first and last values, since not in box
		rho.list <- rho.list[-1]
		rho.list <- rho.list[-length(rho.list)]
    } else {
        rho.list <- rho.levels
    }
    t.n <- 100
    t.line <- seq(par()$usr[3], par()$usr[4], (par()$usr[4] - 
        par()$usr[3])/t.n)
	S.axis.max <- par()$usr[2]
	T.axis.max <- par()$usr[4]
    for (rho in rho.list) {
		rho.label <- if (rho1000) 1000+rho else rho
        n <- length(t.line)
        s.line <- sw.S.T.rho(t.line, rep(rho, n), rep(0, n))
        lines(s.line, t.line, col = col.rho)
		if (s.line[length(s.line)] > S.axis.max) {
			i <- match(TRUE, s.line > S.axis.max)
			mtext(rho.label, side=4, at=t.line[i], cex=cex.rho, col=col.rho) # to right of box
		} else {
			mtext(rho.label, side=3, at=s.line[t.n], adj=0, cex=cex.rho, col=col.rho) # above box
		}
    }
	# Freezing point
	Sr <- range(x$data$salinity, na.rm=TRUE)
	lines(Sr, sw.T.freeze(Sr, p=0), col="darkblue")
}

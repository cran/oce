plot.TS <- function (x, rho.levels = 5, 
 	grid = FALSE,
	col.data="black", col.rho = "blue", col.grid = "lightgray",
	debug = FALSE, ...) 
{
    if (!inherits(x, "ctd")) 
        stop("method is only for ctd objects")
    plot(x$data$salinity, x$data$temperature, xlab = "Salinity [PSU]", 
        ylab = expression(paste("Temperature [", degree, "C]")),col=col.data, ...)
	if (grid)
		grid(col=col.grid)
	rho.min <- sw.sigma(min(x$data$salinity,na.rm=TRUE), max(x$data$temperature,na.rm=TRUE), 0)
	rho.max <- sw.sigma(max(x$data$salinity,na.rm=TRUE), min(x$data$temperature,na.rm=TRUE), 0)
    if (length(rho.levels) == 1) { # try to get this many isopycnals
		adjust <- 1 # ad hoc trial, since we're rounding d.rho down
        d.rho <- (rho.max - rho.min) / rho.levels * adjust
        rho.list <- seq(rho.min, rho.max, d.rho)
        scale <- 10^(floor(log10(d.rho)))
        d.rho.scaled <- d.rho / scale
        if (d.rho.scaled < 2) 
            d.rho.scaled <- 1
        else if (d.rho.scaled < 5) 
            d.rho.scaled <- 2
        else
			d.rho.scaled <- 5
        d.rho.2 <- d.rho.scaled * scale
        rho.list.2 <- seq(floor(rho.min/d.rho.2), floor(1 + rho.max/d.rho.2)) * d.rho.2
        if (debug) {
            cat("plot.TS() debugging information:\n")
			cat("  rho.min           = ", rho.min, "\n");
			cat("  rho.max           = ", rho.max, "\n");
            cat("  raw increment     = ", d.rho, "\n")
            cat("  rounded increment = ", d.rho.2, "\n")
            #cat("  original isopycnals: ", rho.list, "\n")
            cat("  graphed isopycnals: ", rho.list.2, "\n")
        }
    }
    else {
        rho.list <- rho.levels
    }
    t.n <- 100
    t.line <- seq(par()$usr[3], par()$usr[4], (par()$usr[4] - 
        par()$usr[3])/t.n)
    for (rho in rho.list.2) {
        n <- length(t.line)
        S.line <- sw.S.T.rho(t.line, rep(rho, n), rep(0, n))
        lines(S.line, t.line, col = col.rho)
        text(S.line[length(S.line)], t.line[length(t.line)], 
            rho, pos = 1)
    }
	# Freezing point
	Sr <- range(x$data$salinity, na.rm=TRUE)
	lines(Sr, sw.T.freeze(Sr, p=0), col="darkblue")
}

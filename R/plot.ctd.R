plot.ctd <- function (x, ref.lat = NaN, ref.lon = NaN, 
	grid = TRUE, col.grid="lightgray", ...) 
{
    dec_deg <- function(x, code = "lat")
	{
        if (code == "lat") {
            if (x < 0) {
                x <- -x
                sprintf("%.0f %.2fS", floor(x), 60 * (x - floor(x)))
            }
            else {
                sprintf("%.0f %.2fN", floor(x), 60 * (x - floor(x)))
            }
        }
        else {
            if (x < 0) {
                x <- -x
                sprintf("% %.2fW", floor(x), 60 * (x - floor(x)))
            }
            else {
                sprintf("% %.2fE", floor(x), 60 * (x - floor(x)))
            }
        }
    }
    if (!inherits(x, "ctd")) 
        stop("method is only for ctd objects")
    par(mfrow = c(2, 2))
    plot.profile(x, type = "S+T", grid=grid, col.grid=col.grid, ...)
    plot.TS(x, grid=grid, col.grid=col.grid, ...)
    plot.profile(x, type = "sigmatheta+N2", grid=grid, col.grid=col.grid, ...)
   	# Text
	text.item <- function(item, label) {
		if (item != "NaN" && !is.na(item)) {
			text(xloc, yloc, paste(label, item), adj = c(0, 0), cex = cex);			
    		yloc <<- yloc - d.yloc;
		}
	}
   	xfake <- seq(0:10)
    yfake <- seq(0:10)
    plot(xfake, yfake, type = "n", xlab = "", ylab = "", axes = FALSE)
    cex <- 1
    xloc <- 1
    yloc <- 10
    d.yloc <- 1
    text(xloc, yloc, paste("CTD Station"), adj = c(0, 0), cex = cex)
    yloc <- yloc - d.yloc
    text.item(x$filename, "  File:")
    text.item(x$date,     "  Deployed: ")
    if (!is.na(x$longitude) && !is.na(x$latitude)) {
		text(xloc, yloc, paste("  At ", x$longitude, ",", x$latitude), adj = c(0, 0), cex = cex)
    	yloc <- yloc - d.yloc
	}
    if (!is.na(ref.lat) && !is.na(ref.lon)) {
        dist <- geod.dist(x$latitude.dec, x$longitude.dec, ref.lat, 
            ref.lon)
        kms <- sprintf("%.2f km", dist/1000)
        rlat <- text(xloc, yloc, paste("  Distance to (", dec_deg(ref.lon), 
            ",", dec_deg(ref.lat), ") = ", kms), adj = c(0, 0), 
            cex = cex)
        yloc <- yloc - d.yloc
    }
	text.item(x$scientist,		"  Scientist:");
	text.item(x$ship,			"  Ship:");
	text.item(x$cruise,    		"  Cruise:");
	text.item(x$institute, 		"  Institute:");
}

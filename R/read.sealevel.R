read.sealevel <- function(file,debug=FALSE)
{    
	# Reads sea-level data, in a format described at
	# ftp://ilikai.soest.hawaii.edu/rqds/hourly.fmt
	if (is.character(file)) {
        file <- file(file, "r")
        on.exit(close(file))
    }
    if (!inherits(file, "connection")) {
        stop("argument `file' must be a character string or connection")
    }
    if (!isOpen(file)) {
        open(file, "r")
        on.exit(close(file))
    }
	d <- readLines(file)
	if (debug) {
		cat(paste("Line 1: ",d[1],"\n"))
		cat(paste("Line 2: ",d[2],"\n"))
	}
	header <- d[1]  
	# From the docs:
	#
	#station number        1-3     3     exactly 3 digits
    #station version         4     1     letter from A to Z 
    #station name         6-23    18     Abbreviated if necessary     
    #region/country      25-43    19     Abbreviated if necessary     
    #year                45-48     4
    #latitude            50-55     6     degrees, minutes, tenths
    #                                    (implied decimal), and hemisphere
    #longitude           57-63     7     degrees, minutes, tenths
    #                                    (implied decimal), and hemisphere
    #GMT offset          65-68     4     time data are related to in terms
    #                                    of difference from GMT in hours
    #                                    of difference from GMT in hours
	#				 and tenths (implied decimal) with
	#				 East latitudes positive*
    #decimation method      70     1     Coded as 1 : filtered
    #                                             2 : simple average of all
	#					      samples
	#					  3 : spot readings
	#					  4 : other
    #reference offset    72-76     5     constant offset to be added to each
    #                                    each data value for data to be 
	#				 relative to tide staff zero or primary
	#				 datum in same units as data
    #reference code         77     1     R = data referenced to datum
    #                                    X = data not referenced to datum
    #units               79-80     2     always millimeters, MM
	#				 
    #* Data always are in GMT (offset=0000) unless data are relative to a local
    #  time zone that is not an increment of one hour from GMT.  For example,
    #  Colombo, Sri Lanka has a GMT offset = 0055 which is 5.5 hours ahead
    #  of GMT.
                
	station.number    <- substr(header,  1,  3)
	station.version   <- substr(header,  4,  4)
	station.name      <- substr(header,  6, 23)
	station.name      <- sub("[ ]*$","",station.name)
	region            <- substr(header, 25, 43)
	region            <- sub("[ ]*$","",region)
	year              <- substr(header, 45, 48)
	latitude          <- substr(header, 50, 55) #degrees,minutes,tenths,hemisphere
	longitude         <- substr(header, 57, 63) #""
    GMT.offset        <- substr(header, 65, 68) #hours,tenths (East is +ve)
    decimation.method <- substr(header, 70, 70) #1=filtered 2=average 3=spot readings 4=other
    reference.offset  <- substr(header, 72, 76) # add to values
	reference.code    <- substr(header, 77, 77) # add to values
	units             <- substr(header, 79, 80)
	n <- length(d) - 1
	hour <- 1:(12*n) # hours
	eta <- c()
	for (i in 1:n) {
		sp <- strsplit(d[1+i],"[ ]+")
		eta <- c(eta, as.numeric(sp[[1]][4:15]))
		if (i == 1) {
			ymdc <- sp[[1]][3]
			ymd <- paste(substr(ymdc,1,4),"-",substr(ymdc,5,6),"-",substr(ymdc,7,8),sep="")
			one.or.two <- substr(ymdc,9,9)
			start.time <- as.POSIXct(ymd, tz="GMT")# BUG: should look at the GMT.offset value
		}
	}                          
	n <- 12 * n
	if (n != length(hour))
		stop("internal malfunction - check the loop.  n=",n," length(hour)=", length(hour))
	eta[eta==9999] <- NA
	rval <- list(header=header,
		station.number=station.number,
		station.version=station.version,
		station.name=station.name,
		region=region,
		year=year,
		latitude=latitude,
		longitude=longitude,
		GMT.offset=GMT.offset,
		decimation.method=decimation.method,
		reference.offet=reference.offset,
		reference.code=reference.code,
		units=units,
		n=n,
		hour=hour, # 1, 2, ...
		start.time=start.time, # POSIXct
		eta=eta)
	class(rval) <- "sealevel"
	rval
}

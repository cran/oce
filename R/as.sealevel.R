as.sealevel <- function(eta,header="",
start.time=as.POSIXct("2000-01-01"),
station.number="001",
station.version="A",
station.name="Santa",
region="mythical",
year="2000",
latitude="90000N",
longitude="000000E",
GMT.offset=0,
decimation.method=1,
reference.offset=0,
reference.code="",
units="MM")
{    
	n <- length(eta)
	hour <- 1:n
	if (units == "M" || units == "m") {
		eta <- eta * 1000
	}
	processing.log <- list(time=c(Sys.time()), action=c("created by as.sealevel()"))
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
		processing.log=processing.log,
		n=n,
		hour=hour, # 1, 2, ...
		start.time=start.time, # POSIXct
		eta=eta)
	class(rval) <- "sealevel"
	rval
}

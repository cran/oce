as.CTD <- function(S, T, p, header=NULL, filename=NA,ship=NA,scientist=NA,institute=NA,address=NA,
cruise=NA,mooring=NA,date=NA,start.time=NA,start.time.list=NA,
latitude=NA,latitude.dec=NA,
longitude=NA,longitude.dec=NA,
recovery=NA,
water.depth=NA,
sample.interval=NA)
{
	if (length(p) == 1) # special case
		p = rep(p, length(S))
	data <- list(salinity=S, temperature=T, pressure=p, sigma=sw.sigma(S, T, p))
	res <- list(header=header,
	      		filename=filename,
              	ship=ship,
              	scientist=scientist,
              	institute=institute,
              	address=address,
              	cruise=cruise,
              	mooring=mooring,
              	date=date,
	      		start.time=start.time,
	      		start.time.list=start.time.list,
              	latitude=latitude,
              	latitude.dec=latitude.dec,
              	longitude=longitude,
              	longitude.dec=longitude.dec,
              	recovery=recovery,
              	water.depth=water.depth,
              	sample.interval=sample.interval,
              	data=data);
  	class(res) <- "ctd"
	res
}

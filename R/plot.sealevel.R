plot.sealevel <- function(x, ...)
{
	# tidal constituents (in cpd):
	# http://www.soest.hawaii.edu/oceanography/dluther/HOME/Tables/Kaw.htm
    oldpar <- par(no.readonly = TRUE)
	par(mfrow=c(4,1))
	par(mar=c(4,5,4,1)+0.1)
	par(cex=1)
	eg.days <- 28
	stop <- 24 * eg.days
	eta.m <- x$eta / 1000 # use metres
	MSL <- mean(eta.m, na.rm=TRUE)
	tmp <- (pretty(max(eta.m-MSL,na.rm=TRUE)-min(eta.m-MSL,na.rm=TRUE))/2)[2]
	ylim <- c(-tmp,tmp)
	# Whole timeseries
	par(mar=c(2,5,2,1)+0.1)
	plot(x$start.time+x$hour*3600,eta.m-MSL,xlab="",ylab="Sealevel [m]",type='l',ylim=ylim)
	abline(h=0,col="darkgreen")
	mtext(side=4,text=sprintf("%.2f m",MSL),col="darkgreen")
	grid()
	title <- paste("Station: ",
			x$station.number, " (",
			x$station.name,   ",",
			x$region,         ") ",
			substr(x$latitude,1,2),
				"o",
				substr(x$latitude,3,4),
				".",
				substr(x$latitude,5,5), "'",
				substr(x$latitude,6,6),
			" ",
			substr(x$longitude,1,3),
				"o",
				substr(x$longitude,4,5),
				".",
				substr(x$longitude,6,6), "'",
				substr(x$longitude,7,7),
			" ",
			sep="")
	title(main=list(title,cex=1))
	# First bit
	par(mar=c(2,5,1,1)+0.1)
	plot(x$start.time+x$hour[1:stop]*3600,eta.m[1:stop]-MSL,xlab="",ylab="Sealevel [m]",type='l',ylim=ylim)
	grid()
	abline(h=0,col="darkgreen")
	mtext(side=4,text=sprintf("%.2f m",MSL),col="darkgreen")
#	title(paste("First",eg.days,"of",x$n/24,"days"))
	Eta <- ts(eta.m,start=1,frequency=1)   
	#s<-spectrum(Eta-mean(Eta),spans=c(5,5),xlim=c(0,0.1),plot=FALSE,log="y") 
	#s<-spectrum(Eta-mean(Eta),xlim=c(0,0.1),plot=FALSE,log="y",demean=TRUE) 
	s<-spectrum(Eta-mean(Eta),spans=3,plot=FALSE,log="y",demean=TRUE,detrend=TRUE) 
	par(mar=c(2,5,1,1)+0.1)
	plot(s$freq,s$spec,xlim=c(0,0.1),
		xlab="",ylab=expression(paste("spectrum [",m^2/cph,"]")),
		type='l',log="y")
	grid()#col="lightgray",lty="dashed")
	draw.constituent <- function(period=12,label="S2",col="darkred",side=1)
	{
		abline(v=1/period, col=col)
		mtext(label, side=side, at=1/period, col=col,cex=0.8)
	}
	#draw.constituent(23.9344, "K1")
	#draw.constituent(24.0659, "P1")
	#draw.constituent(25.8194, "O1")        
	draw.constituent(24,      "S1",side=1)             
	draw.constituent(360/14.4966939, "M1",side=3,col="blue")       
	draw.constituent(12, "S2")
	draw.constituent(360/14.4966939/2, "M2",side=3,col="blue")
                              
	n <- x$n
	n.cum.spec <- length(s$spec)
	cum.spec <- sqrt(cumsum(s$spec) / n.cum.spec)
	e<-eta.m-mean(eta.m)
	par(mar=c(4,5,1,1)+0.1)
	plot(s$freq,cum.spec,
		xlab="frequency [cph]",
		ylab=expression(paste(integral(spectrum,0,f)," df [m]")),
		type='l',xlim=c(0,0.1))
	grid()
	draw.constituent(24,      "S1",side=1)             
	draw.constituent(360/14.4966939, "M1",side=3,col="blue")       
	draw.constituent(12, "S2")
	draw.constituent(360/14.4966939/2, "M2",side=3,col="blue")
	par(oldpar)
}

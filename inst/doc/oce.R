###################################################
### chunk number 1: ctdplot
###################################################
library(oce)
data(ctd)
plot(ctd)


###################################################
### chunk number 2: ctdsummary eval=FALSE
###################################################
## summary(ctd)


###################################################
### chunk number 3: ctdnames eval=FALSE
###################################################
## names(ctd)


###################################################
### chunk number 4: ctdnames2 eval=FALSE
###################################################
## names(ctd$data)


###################################################
### chunk number 5: ctdfig
###################################################
library(oce)
data(ctd)
plot(ctd)


###################################################
### chunk number 6: ctdrawplot
###################################################
data(ctd.raw)
plot.ctd.scan(ctd.raw)


###################################################
### chunk number 7: ctdrawfig
###################################################
data(ctd.raw)
plot.ctd.scan(ctd.raw)


###################################################
### chunk number 8: ctdscaneg eval=FALSE
###################################################
## plot.ctd.scan(ctd.trim(ctd.raw, "scan", c(140,250)))
## plot.ctd.scan(ctd.trim(ctd.raw, "scan", c(150,250)))


###################################################
### chunk number 9: ctdtrimeg eval=FALSE
###################################################
## ctd.trimmed <- ctd.trim(ctd.raw)


###################################################
### chunk number 10: ctddectrim eval=FALSE
###################################################
## plot(ctd.decimate(ctd.trim(read.ctd("stn123.cnv"))))


###################################################
### chunk number 11: ctdfix eval=FALSE
###################################################
## x <- read.ctd("nnsa_00934_00001_ct1.csv", type="WOCE")
## x$metadata$institute <- "SIO"
## x$metadata$scientist <- "DAM"


###################################################
### chunk number 12: arcticeg eval=FALSE
###################################################
## library(oce)
## # Source: http://cchdo.ucsd.edu/data_access?ExpoCode=58JH199410
## files <- system("ls *.csv", intern=TRUE)
## for (i in 1:length(files)) {
## 	cat(files[i], "\n")
## 	x <- read.ctd(files[i])
## 	if (i == 1) {
## 		plot.TS(x, xlim=c(31, 35.5), ylim=c(-1, 10), type='l', col="red")
## 	} else {
## 		lines(x$data$salinity, x$data$temperature, col="red")
## 	}
## }


###################################################
### chunk number 13: rangeg eval=FALSE
###################################################
## print(range(x$data$temperature))
## print(range(x$data$salinity))


###################################################
### chunk number 14: sectionplot
###################################################
data(section)
data(coastline.hal)
plot(section, coastline=coastline.hal)


###################################################
### chunk number 15: sectionfig
###################################################
data(section)
data(coastline.hal)
plot(section, coastline=coastline.hal)


###################################################
### chunk number 16: sectionplota03
###################################################
# File source -- http://cchdo.ucsd.edu/data_access?ExpoCode=90CT40_1
# a03 <- read.section("a03_hy1.csv")
data(a03)
Gulf.Stream <- section.subset(a03, 124:102)
Gulf.Stream.gridded <- section.grid(Gulf.Stream, p=seq(0, 5000, 10))
data(coastline.world)
plot(Gulf.Stream.gridded, coastline=coastline.world, map.xlim=c(-80,-60))


###################################################
### chunk number 17: sectionfiga03
###################################################
# File source -- http://cchdo.ucsd.edu/data_access?ExpoCode=90CT40_1
# a03 <- read.section("a03_hy1.csv")
data(a03)
Gulf.Stream <- section.subset(a03, 124:102)
Gulf.Stream.gridded <- section.grid(Gulf.Stream, p=seq(0, 5000, 10))
data(coastline.world)
plot(Gulf.Stream.gridded, coastline=coastline.world, map.xlim=c(-80,-60))


###################################################
### chunk number 18: coastlineplot
###################################################
library(oce)
data(coastline.maritimes)
plot(coastline.maritimes, col="darkred")
points(-(63+34/60), 44+39/60, cex=3, col = "blue")


###################################################
### chunk number 19: coastlinefig
###################################################
library(oce)
data(coastline.maritimes)
plot(coastline.maritimes, col="darkred")
points(-(63+34/60), 44+39/60, cex=3, col = "blue")


###################################################
### chunk number 20: sealevelplot
###################################################
library(oce)
#sealevel <- read.oce("../../tests/h275a96.dat")
data(sealevel.hal)
plot(sealevel.hal)


###################################################
### chunk number 21: sealevelfig
###################################################
library(oce)
#sealevel <- read.oce("../../tests/h275a96.dat")
data(sealevel.hal)
plot(sealevel.hal)


###################################################
### chunk number 22: tideplot
###################################################
library(oce)
data(sealevel.hal)
tide <- tidem(sealevel.hal)
days <- 15 # focus on these days at end of series
n <- length(sealevel.hal$data$eta)
i <- seq(n-24*days, n)
t   <- sealevel.hal$data$t[i]
eta <- sealevel.hal$data$eta[i]
eta.pred <- predict(tide)[i]
plot(t, eta, type="l", ylim=c(-0.5,3))
abline(h=0, col="pink")
lines(t, eta - eta.pred, col="red")


###################################################
### chunk number 23: tidefig
###################################################
library(oce)
data(sealevel.hal)
tide <- tidem(sealevel.hal)
days <- 15 # focus on these days at end of series
n <- length(sealevel.hal$data$eta)
i <- seq(n-24*days, n)
t   <- sealevel.hal$data$t[i]
eta <- sealevel.hal$data$eta[i]
eta.pred <- predict(tide)[i]
plot(t, eta, type="l", ylim=c(-0.5,3))
abline(h=0, col="pink")
lines(t, eta - eta.pred, col="red")


###################################################
### chunk number 24: loboplot
###################################################
library(oce)
data(lobo)
plot(lobo)


###################################################
### chunk number 25: lobofig
###################################################
library(oce)
data(lobo)
plot(lobo)


###################################################
### chunk number 26: 
###################################################
library(oce)
sw.rho(S=34, t=10, p=100)
sw.theta(S=34, t=10, p=100)
sw.rho(S=34, t=sw.theta(S=34, t=10, p=100), p=0)
sw.rho(S=34, t=sw.theta(S=34, t=10, p=100, pref=200), p=200)
plot.TS(as.ctd(c(30,40),c(-2,20),rep(0,2)), grid=TRUE, col="white")


###################################################
### chunk number 27: 
###################################################
library(oce)
data(ctd)
pycnocline <- ctd.trim(ctd, "pressure", c(5,12))
plot.profile(pycnocline, type="density+N2")


###################################################
### chunk number 28: 
###################################################
library(oce)
data(section)
SS <- TT <- pp <- id <- NULL
n <- length(section$data$station)
for (i in 1:n) {
	stn <- section$data$station[[i]] # save typing
	SS <- c(SS, stn$data$salinity)
	TT <- c(TT, stn$data$temperature)
	pp <- c(pp, stn$data$pressure)
	id <- c(id, rep(i, length(stn$data$pressure)))
}
ctd <- as.ctd(SS, TT, pp)
plot.TS(ctd, col=hsv(0.7*id/n), cex=2, pch=21)


###################################################
### chunk number 29: 
###################################################
library(oce)
data(a03)
Gulf.Stream <- section.subset(a03, 124:102)
dh <- sw.dynamic.height(Gulf.Stream)
par(mfrow=c(2,1))
plot(dh$distance, dh$height, type='b', xlab="", ylab="Dyn. Height [m]")
grid()
# 1e3 metres per kilometre
f <- coriolis(Gulf.Stream$data$station[[1]]$metadata$latitude)
g <- gravity(Gulf.Stream$data$station[[1]]$metadata$latitude)
v <- diff(dh$height)/diff(dh$distance) * g / f / 1e3
plot(dh$distance[-1], v, type='l', col="blue", xlab="Distance [km]", ylab="Velocity [m/s]")
grid()
abline(h=0)


###################################################
### chunk number 30: 
###################################################
library(oce)
data(sealevel.hal)
plot(sealevel.hal, focus.time=c("2003-09-23","2003-10-05"))
abline(v=as.POSIXct("2003-09-28 23:30:00"), col="red", lty="dotted")
mtext("Hurricane\nJuan", at=as.POSIXct("2003-09-28 23:30:00"), col="red")


###################################################
### chunk number 31: 
###################################################
library(oce)
data(sealevel.hal)
spectrum(sealevel.hal$data$eta, spans=c(3,7))
abline(v=1/12.42)
mtext("M2",at=1/12.42,side=3)


###################################################
### chunk number 32: 
###################################################
library(oce)
data(lobo)
i <- sample(length(lobo$data$temperature))
a <- as.numeric(lobo$data$time[i] - lobo$data$time[1])
col <- hsv(0.5 * a / max(a), 1, 1)
plot.TS(as.ctd(lobo$data$salinity[i], lobo$data$temperature[i], 0), col=col, pch=1)



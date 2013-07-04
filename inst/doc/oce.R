### R code from vignette source 'oce.Rnw'

###################################################
### code chunk number 1: oce.Rnw:104-105
###################################################
options(keep.source=TRUE, width=60, prompt=' ', continue=' ')


###################################################
### code chunk number 2: oce.Rnw:117-119 (eval = FALSE)
###################################################
## library(oce)
## plot(read.oce(filename))


###################################################
### code chunk number 3: ctdplot (eval = FALSE)
###################################################
## library(oce)
## data(ctd)
## plot(ctd)


###################################################
### code chunk number 4: ctdsummary (eval = FALSE)
###################################################
## summary(ctd)


###################################################
### code chunk number 5: ctdnames (eval = FALSE)
###################################################
## names(ctd)


###################################################
### code chunk number 6: ctdfig
###################################################
library(oce)
data(ctd)
plot(ctd)


###################################################
### code chunk number 7: ctdrawplot (eval = FALSE)
###################################################
## data(ctdRaw)
## plotScan(ctdRaw)


###################################################
### code chunk number 8: ctdrawfig
###################################################
data(ctdRaw)
plotScan(ctdRaw)


###################################################
### code chunk number 9: ctdscaneg (eval = FALSE)
###################################################
## plotScan(ctdTrim(ctdRaw, "range",
##                  parameters=list(item="scan", from=140, to=250)))
## plotScan(ctdTrim(ctdRaw, "range",
##                  parameters=list(item="scan", from=150, to=250)))


###################################################
### code chunk number 10: ctdtrimeg (eval = FALSE)
###################################################
## ctdTrimmed <- ctdTrim(ctdRaw)


###################################################
### code chunk number 11: ctddectrim (eval = FALSE)
###################################################
## plot(ctd.decimate(ctdTrim(read.ctd("stn123.cnv"))))


###################################################
### code chunk number 12: ctdfix1 (eval = FALSE)
###################################################
## x <- read.ctd("nnsa_00934_00001_ct1.csv", type="WOCE")
## x[["institute"]] <- "SIO" # better (using an accessor) but still bad


###################################################
### code chunk number 13: ctdfix2 (eval = FALSE)
###################################################
## x <- read.ctd("nnsa_00934_00001_ct1.csv", type="WOCE")
## x <- oceEdit(x, "institute", "SIO") # better way


###################################################
### code chunk number 14: ctdfix3 (eval = FALSE)
###################################################
## x <- read.ctd("nnsa_00934_00001_ct1.csv", type="WOCE")
## x <- oceEdit(x, "institute", "SIO", "human-parsed", "Dan Kelley")


###################################################
### code chunk number 15: arcticeg (eval = FALSE)
###################################################
## library(oce)
## # Source: http://cchdo.ucsd.edu/data_access?ExpoCode=58JH199410
## files <- system("ls *.csv", intern=TRUE)
## for (i in 1:length(files)) {
##     cat(files[i], "\n")
##     x <- read.ctd(files[i])
##     if (i == 1) {
##         plotTS(x, xlim=c(31, 35.5), ylim=c(-1, 10), type="l", col="red")
##     } else {
##         lines(x[["salinity"]], x[["temperature"]], col="red")
##     }
## }


###################################################
### code chunk number 16: rangeg (eval = FALSE)
###################################################
## print(range(x[["temperature"]]))
## print(range(x[["salinity"]]))


###################################################
### code chunk number 17: sectionplot (eval = FALSE)
###################################################
## data(section)
## data(coastlineHalifax)
## plot(section, coastline=coastlineHalifax)


###################################################
### code chunk number 18: oce.Rnw:414-415
###################################################
jpeg("a03.jpg", quality=75, width=600, height=700, pointsize=12)


###################################################
### code chunk number 19: oce.Rnw:417-424
###################################################
# File source -- http://cchdo.ucsd.edu/data_access?ExpoCode=90CT40_1
# a03 <- read.section("a03_hy1.csv")
data(a03)
GS <- subset.oce(a03, indices=124:102)
GSg <- sectionGrid(GS, p=seq(0, 1600, 25))
data(coastlineWorld)
plot(GSg, coastline=coastlineWorld, map.xlim=c(-85,-(64+13/60)))


###################################################
### code chunk number 20: oce.Rnw:426-427
###################################################
dev.off()


###################################################
### code chunk number 21: oce.Rnw:467-468
###################################################
jpeg("topo.jpg", quality=70, width=800, height=400, pointsize=13)


###################################################
### code chunk number 22: oce.Rnw:470-475
###################################################
library(oce)
data(topoMaritimes)
plot(topoMaritimes, clatitude=46, clongitude=-62, span=800,
    water.z=c(  -50, -100, -150, -200, -300, -400, -500, -1000, -2000),
    lwd.water=c(  1,    1,    1,    1,    1,   1,   1.5,   1.5,   1.5))


###################################################
### code chunk number 23: oce.Rnw:477-478
###################################################
dev.off()


###################################################
### code chunk number 24: oce.Rnw:496-497
###################################################
jpeg("sealevel.jpg", quality=70, width=800, height=600, pointsize=20)


###################################################
### code chunk number 25: oce.Rnw:499-503
###################################################
library(oce)
#sealevel <- read.oce("../../tests/h275a96.dat")
data(sealevelHalifax)
plot(sealevelHalifax)


###################################################
### code chunk number 26: oce.Rnw:505-506
###################################################
dev.off()


###################################################
### code chunk number 27: oce.Rnw:583-584
###################################################
png("tdr.png", width=600, height=300, pointsize=13)


###################################################
### code chunk number 28: oce.Rnw:586-589
###################################################
library(oce)
data(tdr)
plot(tdr, useSmoothScatter=TRUE)


###################################################
### code chunk number 29: oce.Rnw:591-592
###################################################
dev.off()


###################################################
### code chunk number 30: oce.Rnw:622-623
###################################################
png("adp.png", width=800, height=400, pointsize=18)


###################################################
### code chunk number 31: adpplot
###################################################
library(oce)
data(adp)
plot(adp, which=1, adorn=expression({lines(x[["time"]], x[["pressure"]])}))


###################################################
### code chunk number 32: oce.Rnw:630-631
###################################################
dev.off()


###################################################
### code chunk number 33: oce.Rnw:699-705
###################################################
library(oce)
swRho(34, 10, 100)
swTheta(34, 10, 100)
swRho(34, swTheta(34, 10, 100), 0)
swRho(34, swTheta(34, 10, 100, 200), 200)
plotTS(as.ctd(c(30,40),c(-2,20),rep(0,2)), grid=TRUE, col="white")


###################################################
### code chunk number 34: oce.Rnw:710-715
###################################################
library(oce)
data(ctd)
pycnocline <- ctdTrim(ctd, "range",
                      parameters=list(item="pressure", from=5, to=12))
plotProfile(pycnocline, which="density+N2")


###################################################
### code chunk number 35: oce.Rnw:719-723
###################################################
library(oce)
data(ctd)
pycnocline <- subset.oce(ctd, 5<=pressure & pressure<=12)
plotProfile(pycnocline, which="density+N2")


###################################################
### code chunk number 36: oce.Rnw:729-733
###################################################
library(oce)
data(section)
ctd <- as.ctd(salinity(section), temperature(section), pressure(section))
plotTS(ctd)


###################################################
### code chunk number 37: oce.Rnw:737-748
###################################################
library(oce)
data(section)
SS <- TT <- pp <- id <- NULL
n <- length(section@data$station)
for (stn in section@data$station) {
    SS <- c(SS, stn@data$salinity)
    TT <- c(TT, stn@data$temperature)
    pp <- c(pp, stn@data$pressure)
}
ctd <- as.ctd(SS, TT, pp)
plotTS(ctd)


###################################################
### code chunk number 38: oce.Rnw:756-770
###################################################
library(oce)
data(a03)
GS <- subset.oce(a03, indices=124:102)
dh <- swDynamicHeight(GS)
par(mfrow=c(2,1))
plot(dh$distance, dh$height, type="b", xlab="", ylab="Dyn. Height [m]")
grid()
# 1e3 metres per kilometre
f <- coriolis(GS@data$station[[1]]@metadata$latitude)
g <- gravity(GS@data$station[[1]]@metadata$latitude)
v <- diff(dh$height)/diff(dh$distance) * g / f / 1e3
plot(dh$distance[-1], v, type="l", col="blue", xlab="Distance [km]", ylab="Velocity [m/s]")
grid()
abline(h=0)


###################################################
### code chunk number 39: oce.Rnw:778-784
###################################################
library(oce)
data(sealevelHalifax)
# Focus on 2003-Sep-28 to 29th, the time when Hurricane Juan caused flooding
plot(sealevelHalifax,which=1,xlim=as.POSIXct(c("2003-09-24","2003-10-05"), tz="UTC"))
abline(v=as.POSIXct("2003-09-29 04:00:00", tz="UTC"), col="red")
mtext("Hurricane\nJuan", at=as.POSIXct("2003-09-29 04:00:00", tz="UTC"), col="red")


###################################################
### code chunk number 40: oce.Rnw:790-792
###################################################
library(oce)
data(sealevelHalifax)


###################################################
### code chunk number 41: oce.Rnw:795-796
###################################################
elevation <- sealevelHalifax[["elevation"]]


###################################################
### code chunk number 42: oce.Rnw:800-803
###################################################
spectrum(elevation, spans=c(3,7))
abline(v=1/12.42)
mtext("M2",at=1/12.42,side=3)


###################################################
### code chunk number 43: oce.Rnw:821-822
###################################################
abline(v=as.POSIXct("2008-06-25 00:00:00"),col="red")



library(oce)
data(coastline)
plot(coastline, col="darkred")
hfx.lat <-  44+39/60
hfx.lon <- -(63+34/60)
points(hfx.lon, hfx.lat, col="blue", cex=3, pch=20)
text(hfx.lon, hfx.lat, "Halifax", col = "blue", pos=4, cex=1.3)

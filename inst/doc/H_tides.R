## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----fig.width=7, fig.height=3, fig.keep="none"-------------------------------
library(oce)
data(sealevel)
plot(sealevel)

## ----eval=FALSE---------------------------------------------------------------
# library(oce)
# library(reticulate)
# use_condaenv("tides")

## ----eval=FALSE---------------------------------------------------------------
# utide <- import("utide")
# pandas <- import("pandas")
# np <- import("numpy")

## ----eval=FALSE---------------------------------------------------------------
# data(tidalCurrent)
# t <- tidalCurrent$time
# u <- np$array(tidalCurrent$u)
# v <- np$array(tidalCurrent$v)
# tpy <- pandas$to_datetime(as.numeric(t), unit = "s", utc = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# coef <- utide$solve(tpy, u, v,
#     lat = 45, nodal = FALSE, trend = FALSE, method = "ols",
#     conf_int = "linear", Rayleigh_min = 0.95
# )

## ----eval=FALSE---------------------------------------------------------------
# names(coef)

## ----eval=FALSE---------------------------------------------------------------
# tide <- utide$reconstruct(t = tpy, coef = coef)

## ----eval=FALSE---------------------------------------------------------------
# par(mfrow = c(2, 1))
# oce.plot.ts(t, u)
# lines(t, tide["u"], col = 2)
# legend("bottomleft", c("data", "fit"), lty = 1, col = 1:2, bg = "white")
# oce.plot.ts(t, v)
# lines(t, tide["v"], col = 2)

## ----eval=FALSE---------------------------------------------------------------
# ellipse <- function(xc = 0, yc = 0, Lmaj, Lmin, phi, ...) {
#     th <- seq(0, 2 * pi, 0.01)
#     x <- xc + Lmaj * cos(th) * cos(phi) - Lmin * sin(th) * sin(phi)
#     y <- yc + Lmaj * cos(th) * sin(phi) + Lmin * sin(th) * cos(phi)
#     lines(x, y, ...)
# }
# par(mfrow = c(1, 1))
# plot(u, v, asp = 1)
# grid()
# for (i in seq_along(coef$name)) {
#     ellipse(coef$umean, coef$vmean, coef$Lsmaj[i], coef$Lsmin[i], coef$theta[i] * pi / 180, lwd = 3, col = i)
# }

## ----fig.width=7, fig.height=3, fig.keep="none"-------------------------------
library(oce)
data(sealevel)
# Focus on 2003-Sep-28 to 29th, the time when Hurricane Juan caused flooding
plot(sealevel, which = 1, xlim = as.POSIXct(c("2003-09-24", "2003-10-05"), tz = "UTC"))
abline(v = as.POSIXct("2003-09-29 04:00:00", tz = "UTC"), col = "red")
mtext("Juan", at = as.POSIXct("2003-09-29 04:00:00", tz = "UTC"), col = "red")

## ----fig.width=7, fig.height=3, fig.keep="none"-------------------------------
library(oce)
data(sealevel)
m <- tidem(sealevel)
oce.plot.ts(sealevel[["time"]], sealevel[["elevation"]] - predict(m),
    ylab = "Detided sealevel [m]",
    xlim = c(as.POSIXct("2003-09-20"), as.POSIXct("2003-10-08"))
)


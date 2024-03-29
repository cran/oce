# vim:textwidth=80:expandtab:shiftwidth=4:softtabstop=4

#' Lunar Angle as Function of Space and Time
#'
#' The calculations are based on formulae provided by Meeus (1982), primarily
#' in chapters 6, 18, and 30.  The first step is to compute sidereal time as
#' formulated in Meeus (1982) chapter 7, which in turn uses Julian day computed
#' according to as formulae in Meeus (1982) chapter 3.  Using these quantities,
#' formulae in Meeus (1982) chapter 30 are then used to compute geocentric
#' longitude (\eqn{lambda}{lambda}, in the Meeus notation), geocentric latitude
#' (\eqn{beta}{beta}), and parallax.  Then the `obliquity` of the ecliptic
#' is computed with Meeus (1982) equation 18.4.  Equatorial coordinates (right
#' ascension and declination) are computed with equations 8.3 and 8.4 from
#' Meeus (1982), using [eclipticalToEquatorial()].  The hour angle
#' (\eqn{H}{H}) is computed using the unnumbered equation preceding Meeus's
#' (1982) equation 8.1.  Finally, Meeus (1982) equations 8.5 and 8.6 are used
#' to calculate the local azimuth and altitude of the moon, using
#' [equatorialToLocalHorizontal()].
#'
#' @param t time, a POSIXt object (converted to timezone `"UTC"`,
#' if it is not already in that timezone), a character or numeric value that
#' corresponds to such a time.
#'
#' @param longitude observer longitude in degrees east
#'
#' @param latitude observer latitude in degrees north
#'
#' @param useRefraction boolean, set to `TRUE` to apply a correction for
#' atmospheric refraction.  (Ignored at present.)
#'
#' @return A list containing the following.
#' * `time`
#' * `azimuth` moon azimuth, in degrees eastward of north, from 0 to 360.
#' Note: this is not the convention used by Meeus, who uses degrees westward of
#' South. Here, the convention is chosen to more closely match the expectation
#' of oceanographers.
#' * `altitude` moon altitude, in degrees from -90 to 90.
#' * `rightAscension` in' degrees.
#' * `declination` in degrees.
#' * `lambda` geocentric longitude, in degrees.
#' * `beta` geocentric latitude, in degrees.
#' * `diameter` lunar diameter, in degrees.
#' * `distance` earth-moon distance, in kilometers.
#' * `illuminatedFraction` fraction of moon's visible disk that is illuminated.
#' * `phase` phase of the moon, defined in equation 32.3 of Meeus (1982).
#' The fractional part of which is 0 for new moon, 1/4 for first
#' quarter, 1/2 for full moon, and 3/4 for last quarter.
#'
#' \if{html}{\figure{starCoords.png}{options: width="400"}}
#'
#' @section Alternate formulations:
#' Formulae provide by Meeus (1982) are used
#' for all calculations here.  Meeus (1991) provides formulae that are similar,
#' but that differ in the 5th or 6th digits.  For example, the formula for
#' ephemeris time in Meeus (1991) differs from that in Meeus (1992) at the 5th
#' digit, and almost all of the approximately 200 coefficients in the relevant
#' formulae also differ in the 5th and 6th digits.  Discussion of the changing
#' formulations is best left to members of the astronomical community.  For the
#' present purpose, it may be sufficient to note that `moonAngle`, based
#' on Meeus (1982), reproduces the values provided in example 45.a of Meeus
#' (1991) to 4 significant digits, e.g. with all angles matching to under 2
#' minutes of arc.
#'
#' @author Dan Kelley, based on formulae in Meeus (1982).
#'
#' @seealso The equivalent function for the sun is [sunAngle()].
#'
#' @references
#' * Meeus, Jean. Astronomical Formulas for Calculators. Second Edition.
#' Richmond, Virginia, USA: Willmann-Bell, 1982.
#'
#' * Meeus, Jean. Astronomical Algorithms. Second Edition.
#' Richmond, Virginia, USA: Willmann-Bell, 1991.
#'
#' @examples
#'
#' library(oce)
#' par(mfrow = c(3, 2))
#' y <- 2012
#' m <- 4
#' days <- 1:3
#' # Halifax sunrise/sunset (see e.g. https://www.timeanddate.com/worldclock)
#' rises <- ISOdatetime(y, m, days, c(13, 15, 16), c(55, 04, 16), 0, tz = "UTC") + 3 * 3600 # ADT
#' sets <- ISOdatetime(y, m, days, c(3, 4, 4), c(42, 15, 45), 0, tz = "UTC") + 3 * 3600
#' azrises <- c(69, 75, 82)
#' azsets <- c(293, 288, 281)
#' latitude <- 44.65
#' longitude <- -63.6
#' for (i in 1:3) {
#'     t <- ISOdatetime(y, m, days[i], 0, 0, 0, tz = "UTC") + seq(0, 24 * 3600, 3600 / 4)
#'     ma <- moonAngle(t, longitude, latitude)
#'     oce.plot.ts(t, ma$altitude, type = "l", mar = c(2, 3, 1, 1), cex = 1 / 2, ylab = "Altitude")
#'     abline(h = 0)
#'     points(rises[i], 0, col = "red", pch = 3, lwd = 2, cex = 1.5)
#'     points(sets[i], 0, col = "blue", pch = 3, lwd = 2, cex = 1.5)
#'     oce.plot.ts(t, ma$azimuth, type = "l", mar = c(2, 3, 1, 1), cex = 1 / 2, ylab = "Azimuth")
#'     points(rises[i], -180 + azrises[i], col = "red", pch = 3, lwd = 2, cex = 1.5)
#'     points(sets[i], -180 + azsets[i], col = "blue", pch = 3, lwd = 2, cex = 1.5)
#' }
#'
#' @family things related to astronomy
moonAngle <- function(t, longitude = 0, latitude = 0, useRefraction = TRUE) {
    if (missing(t)) {
        stop("must provide 't'")
    }
    if (is.character(t)) {
        t <- as.POSIXct(t, tz = "UTC")
    } else if (inherits(t, "Date")) {
        t <- as.POSIXct(t)
    }
    if (!inherits(t, "POSIXt")) {
        if (is.numeric(t)) {
            tref <- as.POSIXct("2000-01-01 00:00:00", tz = "UTC") # arbitrary
            t <- t - as.numeric(tref) + tref
        } else {
            stop("t must be POSIXt or a number corresponding to POSIXt (in UTC)")
        }
    }
    # Ensure that the timezone is UTC. Note that Sys.Date() gives a NULL tzone.
    tzone <- attr(as.POSIXct(t[1]), "tzone")
    if (is.null(tzone) || "UTC" != tzone) {
        attributes(t)$tzone <- "UTC"
    }
    RPD <- atan2(1.0, 1.0) / 45.0 # radians per degree
    # In this code, the symbol names follow Meeus (1982) chapter 30, with e.g. "p"
    # used to indicate primes, e.g. Lp stands for L' in Meeus' notation.
    # Also, T2 and T3 are powers on T.
    T <- julianCenturyAnomaly(julianDay(t)) # nolint
    T2 <- T * T # nolint
    T3 <- T * T2 # nolint
    # Step 1 (top of Meuus page 148, chapter 30): mean quantities
    # moon mean longitude
    Lp <- 270.434164 + 481267.8831 * T - 0.001133 * T2 + 0.0000019 * T3 # nolint
    # sun mean amomaly
    M <- 358.475833 + 35999.0498 * T - 0.000150 * T2 - 0.0000033 * T3 # nolint
    # moon mean amomaly
    Mp <- 296.104608 + 477198.8491 * T + 0.009192 * T2 + 0.0000144 * T3 # nolint
    # moon mean elongation
    D <- 350.737486 + 445267.1142 * T - 0.001436 * T2 + 0.0000019 * T3 # nolint
    # moon distance from ascending node
    F <- 11.250889 + 483202.0251 * T - 0.003211 * T2 - 0.0000003 * T3 # nolint
    # longitude of moon ascending node
    Omega <- 259.183275 - 1934.1420 * T + 0.002078 * T2 + 0.0000022 * T3 # nolint
    # Step 2 (to bottom of p 148, chapter 30): add periodic variations ("additive terms")
    # note that 'tmp' is redefined every few lines
    tmp <- sin(RPD * (51.2 + 20.2 * T)) # nolint
    Lp <- Lp + 0.000233 * tmp
    M <- M - 0.001778 * tmp
    Mp <- Mp + 0.000817 * tmp
    D <- D + 0.002011 * tmp
    tmp <- 0.003964 * sin(RPD * (346.560 + 132.870 * T - 0.0091731 * T2)) # nolint
    Lp <- Lp + tmp
    Mp <- Mp + tmp
    D <- D + tmp
    F <- F + tmp # nolint
    tmp <- sin(RPD * Omega)
    Lp <- Lp + 0.001964 * tmp
    Mp <- Mp + 0.002541 * tmp
    D <- D + 0.001964 * tmp
    F <- F - 0.024691 * tmp # nolint
    F <- F - 0.004328 * sin(RPD * (Omega + 275.05 - 2.30 * T)) # nolint
    # Step 3: Meeus p 149
    e <- 1 - 0.002495 * T - 0.00000752 * T2 # nolint
    e2 <- e * e
    lambda <- Lp + # nolint
        (6.288750 * sin(RPD * (Mp))) + # nolint
        (1.274018 * sin(RPD * (2 * D - Mp))) + # nolint
        (0.658309 * sin(RPD * (2 * D))) + # nolint
        (0.213616 * sin(RPD * (2 * Mp))) + # nolint
        (e * -0.185596 * sin(RPD * (M))) + # nolint
        (-0.114336 * sin(RPD * (2 * F))) + # nolint
        (0.058793 * sin(RPD * (2 * D - 2 * Mp))) + # nolint
        (e * 0.057212 * sin(RPD * (2 * D - M - Mp))) + # nolint
        (0.053320 * sin(RPD * (2 * D + Mp))) + # nolint
        (e * 0.045874 * sin(RPD * (2 * D - M))) + # nolint
        (e * 0.041024 * sin(RPD * (Mp - M))) + # nolint
        (-0.034718 * sin(RPD * (D))) + # nolint
        (e * -0.030465 * sin(RPD * (M + Mp))) + # nolint
        (0.015326 * sin(RPD * (2 * D - 2 * F))) + # nolint
        (-0.012528 * sin(RPD * (2 * F + Mp))) + # nolint
        (-0.010980 * sin(RPD * (2 * F - Mp))) + # nolint
        (0.010674 * sin(RPD * (4 * D - Mp))) + # nolint
        (0.010034 * sin(RPD * (3 * M))) + # nolint
        (0.008548 * sin(RPD * (4 * D - 2 * Mp))) + # nolint
        (e * -0.007910 * sin(RPD * (M - Mp + 2 * D))) + # nolint
        (e * -0.006783 * sin(RPD * (2 * D + M))) + # nolint
        (0.005162 * sin(RPD * (Mp - D))) + # nolint
        (e * 0.005000 * sin(RPD * (M + D))) + # nolint
        (e * 0.004049 * sin(RPD * (Mp - M + 2 * D))) + # nolint
        (0.003996 * sin(RPD * (2 * Mp + 2 * D))) + # nolint
        (0.003862 * sin(RPD * (4 * D))) + # nolint
        (0.003665 * sin(RPD * (2 * D - 3 * Mp))) + # nolint
        (e * 0.002696 * sin(RPD * (2 * Mp - M))) + # nolint
        (0.002602 * sin(RPD * (Mp - 2 * F - 2 * D))) + # nolint
        (e * 0.002396 * sin(RPD * (2 * D - M - 2 * Mp))) + # nolint
        (-0.002349 * sin(RPD * (Mp + D))) + # nolint
        (e2 * 0.002249 * sin(RPD * (2 * D - 2 * M))) + # nolint
        (e * -0.002125 * sin(RPD * (2 * Mp + M))) + # nolint
        (e2 * -0.002079 * sin(RPD * (2 * M))) + # nolint
        (e2 * 0.002059 * sin(RPD * (2 * D - Mp - 2 * M))) + # nolint
        (-0.001773 * sin(RPD * (Mp + 2 * D - 2 * F))) + # nolint
        (-0.001595 * sin(RPD * (2 * F + 2 * D))) + # nolint
        (e * 0.001220 * sin(RPD * (4 * D - M - Mp))) + # nolint
        (-0.001110 * sin(RPD * (2 * Mp + 2 * F))) + # nolint
        (0.000892 * sin(RPD * (Mp - 3 * D))) + # nolint
        (e * -0.000811 * sin(RPD * (M + Mp + 2 * D))) + # nolint
        (e * 0.000761 * sin(RPD * (4 * D - M - 2 * Mp))) + # nolint
        (e2 * 0.000717 * sin(RPD * (Mp - 2 * M))) + # nolint
        (e2 * 0.000704 * sin(RPD * (Mp - 2 * M - 2 * D))) + # nolint
        (e * 0.000693 * sin(RPD * (M - 2 * Mp + 2 * D))) + # nolint
        (e * 0.000598 * sin(RPD * (2 * D - M - 2 * F))) + # nolint
        (0.000550 * sin(RPD * (Mp + 4 * D))) + # nolint
        (0.000538 * sin(RPD * (4 * Mp))) + # nolint
        (e * 0.000521 * sin(RPD * (4 * D - M))) + # nolint
        (0.000486 * sin(RPD * (2 * M - D))) # nolint
    lambda <- lambda %% 360
    B <- 0 + # nolint
        (5.128189 * sin(RPD * (F))) + # nolint
        (0.280606 * sin(RPD * (Mp + F))) + # nolint
        (0.277693 * sin(RPD * (Mp - F))) + # nolint
        (0.173238 * sin(RPD * (2 * D - F))) + # nolint
        (0.055413 * sin(RPD * (2 * D + F - Mp))) + # nolint
        (0.046272 * sin(RPD * (2 * D - F - Mp))) + # nolint
        (0.032573 * sin(RPD * (2 * D + F))) + # nolint
        (0.017198 * sin(RPD * (2 * Mp + F))) + # nolint
        (0.009267 * sin(RPD * (2 * D + Mp - F))) + # nolint
        (0.008823 * sin(RPD * (2 * Mp - F))) + # nolint
        (0.008247 * sin(RPD * (2 * D - M - F))) + # nolint
        (0.004323 * sin(RPD * (2 * D - F - 2 * Mp))) + # nolint
        (0.004200 * sin(RPD * (2 * D + F + Mp))) + # nolint
        (e * 0.003372 * sin(RPD * (F - M - 2 * D))) + # nolint
        (e * 0.002472 * sin(RPD * (2 * D + F - M - Mp))) + # nolint
        (e * 0.002222 * sin(RPD * (2 * D + F - M))) + # nolint
        (e * 0.002072 * sin(RPD * (2 * D - F - M - Mp))) + # nolint
        (e * 0.001877 * sin(RPD * (F - M + Mp))) + # nolint
        (0.001828 * sin(RPD * (4 * D - F - Mp))) + # nolint
        (e * -0.001803 * sin(RPD * (F + M))) + # nolint
        (-0.001750 * sin(RPD * (3 * F))) + # nolint
        (e * 0.001570 * sin(RPD * (Mp - M - F))) + # nolint
        (-0.001487 * sin(RPD * (F + D))) + # nolint
        (e * -0.001481 * sin(RPD * (F + M + Mp))) + # nolint
        (e * 0.001417 * sin(RPD * (F - M - Mp))) + # nolint
        (e * 0.001350 * sin(RPD * (F - M))) + # nolint
        (0.001330 * sin(RPD * (F - D))) + # nolint
        (0.001106 * sin(RPD * (F + 3 * Mp))) + # nolint
        (0.001020 * sin(RPD * (4 * D - F))) + # nolint
        (0.000833 * sin(RPD * (F + 4 * D - Mp))) + # nolint
        (0.000781 * sin(RPD * (Mp - 3 * F))) + # nolint
        (0.000670 * sin(RPD * (F + 4 * D - 2 * Mp))) + # nolint
        (0.000606 * sin(RPD * (2 * D - 3 * F))) + # nolint
        (0.000597 * sin(RPD * (2 * D + 2 * Mp - F))) + # nolint
        (e * 0.000492 * sin(RPD * (2 * D + Mp - M - F))) + # nolint
        (0.000450 * sin(RPD * (2 * Mp - F - 2 * D))) + # nolint
        (0.000439 * sin(RPD * (3 * Mp - F))) + # nolint
        (0.000423 * sin(RPD * (F + 2 * D + 2 * Mp))) + # nolint
        (0.000422 * sin(RPD * (2 * D - F - 3 * Mp))) + # nolint
        (e * -0.000367 * sin(RPD * (F + F + 2 * D - Mp))) + # nolint
        (e * -0.000353 * sin(RPD * (M + F + 2 * D))) + # nolint
        (0.000331 * sin(RPD * (F + 4 * D))) + # nolint
        (e * 0.000317 * sin(RPD * (2 * D + F - M + Mp))) + # nolint
        (e2 * 0.000306 * sin(RPD * (2 * D - 2 * M - F))) + # nolint
        (-0.000283 * sin(RPD * (Mp + 3 * F))) # nolint
    omega1 <- 0.0004664 * cos(RPD * Omega)
    omega2 <- 0.0000754 * cos(RPD * (Omega + 275.05 - 2.30 * T)) # nolint
    beta <- B * (1 - omega1 - omega2)
    pi <- 0.950724 + # nolint
        (0.051818 * cos(RPD * (Mp))) + # nolint
        (0.009531 * cos(RPD * (2 * D - Mp))) + # nolint
        (0.007843 * cos(RPD * (2 * D))) + # nolint
        (0.002824 * cos(RPD * (2 * Mp))) + # nolint
        (0.000857 * cos(RPD * (2 * D + Mp))) + # nolint
        (e * 0.000533 * cos(RPD * (2 * D - M))) + # nolint
        (e * 0.000401 * cos(RPD * (2 * D - M - Mp))) + # nolint
        (e * 0.000320 * cos(RPD * (Mp - M))) + # nolint
        (-0.000271 * cos(RPD * (D))) + # nolint
        (e * -0.000264 * cos(RPD * (M + Mp))) + # nolint
        (-0.000198 * cos(RPD * (2 * F - Mp))) + # nolint
        (0.000173 * cos(RPD * (3 * Mp))) + # nolint
        (0.000167 * cos(RPD * (4 * D - Mp))) + # nolint
        (e * -0.000111 * cos(RPD * (M))) + # nolint
        (0.000103 * cos(RPD * (4 * D - 2 * Mp))) + # nolint
        (-0.000084 * cos(RPD * (2 * Mp - 2 * D))) + # nolint
        (e * -0.000083 * cos(RPD * (2 * D + M))) + # nolint
        (0.000079 * cos(RPD * (2 * D + 2 * Mp))) + # nolint
        (0.000072 * cos(RPD * (4 * D))) + # nolint
        (e * 0.000064 * cos(RPD * (2 * D - M + Mp))) + # nolint
        (e * -0.000063 * cos(RPD * (2 * D + M - Mp))) + # nolint
        (e * 0.000041 * cos(RPD * (M + D))) + # nolint
        (e * 0.000035 * cos(RPD * (2 * Mp - M))) + # nolint
        (-0.000033 * cos(RPD * (3 * Mp - 2 * D))) + # nolint
        (-0.000030 * cos(RPD * (Mp + D))) + # nolint
        (-0.000029 * cos(RPD * (2 * F - 2 * D))) + # nolint
        (e * -0.000029 * cos(RPD * (2 * Mp + M))) + # nolint
        (e2 * 0.000026 * cos(RPD * (2 * D - 2 * M))) + # nolint
        (-0.000023 * cos(RPD * (2 * F - 2 * D + Mp))) + # nolint
        (e * 0.000019 * cos(RPD * (4 * D - M - Mp))) # nolint
    # For coordinate conversions, need epsilon (obliquity of the ecliptic)
    # as defined in Meuus eq 18.4, page 81.
    epsilon <- 23.452294 - 0.0130125 * T - 0.00000164 * T2 + 0.000000503 * T3 # nolint
    ec <- eclipticalToEquatorial(lambda, beta, epsilon)
    # .lh <- equatorialToLocalHorizontal(ec$rightAscension, ec$declination, t, latitude, longitude)
    lh <- equatorialToLocalHorizontal(
        rightAscension = ec$rightAscension,
        declination = ec$declination,
        t = t,
        longitude = longitude,
        latitude = latitude
    )
    # Illuminated fraction, reference 1 chapter 31 (second, approximate, formula)
    D <- D %% 360 # need this; could have done it earlier, actually
    illfr <- 180 - D - 6.289 * sin(RPD * Mp) +
        2.100 * sin(RPD * M) -
        1.274 * sin(RPD * (2 * D - Mp)) -
        0.658 * sin(RPD * 2 * D) -
        0.2114 * sin(RPD * 2 * Mp) -
        0.112 * sin(RPD * D)
    illuminatedFraction <- (1 + cos(RPD * illfr)) / 2
    # Meeus (1982) eq 32.3 page 160
    phase <- T * 1236.85 # nolint

    # The 180 in azimuth converts from astron convention with azimuth=westward
    # angle from South, to eastward from North.
    res <- list(
        time = t,
        azimuth = lh$azimuth + 180,
        altitude = lh$altitude,
        rightAscension = ec$rightAscension, declination = ec$declination,
        lambda = lambda %% 360, beta = beta,
        diameter = pi, distance = 6378.14 / sin(RPD * pi),
        illuminatedFraction = illuminatedFraction,
        phase = phase
    )
    res
}

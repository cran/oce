# vim:textwidth=80:expandtab:shiftwidth=4:softtabstop=4

#' Read a NOAA Ocean Index File
#'
#' Read an ocean index file, in the format used by NOAA.
#'
#' Reads a text-format index file, in either of two formats. If
#' `format` is missing, then the first line of the file is examined. If
#' that line contains 2 (whitespace-separated) tokens, then `"noaa"`
#' format is assumed. If it contains 13 tokens, then `"ucar"` format is assumed.
#' Otherwise, an error is reported.
#'
#' In the `"noaa"` format, the two tokens on the first line are taken to
#' be the start year and the end year, respectively. The second line
#' must contain a single token, the missing value. All further lines must contain
#' 12 tokens, for the values in January, February, etc.
#'
#' In the `"ucar"` format, all data lines must contain the 13 tokens,
#' the first of which is the year, with the following 12 being the values
#' for January, February, etc.
#'
#' @param file a connection or a character string giving the name of the file
#' to load.  May be a URL.
#'
#' @param format optional character string indicating the format type. If not
#' supplied, a guess will be made, based on examination of the first few lines
#' of the file. If supplied, the possibilities are `"noaa"` and
#' `"ucar"`. See \dQuote{Details}.
#'
#' @param missingValue If supplied, this is a numerical value that indicates
#' invalid data. In some datasets, this is -99.9, but other values may be used.
#' If `missingValue` is not supplied, any data that have value equal
#' to or less than -99 are considered invalid. Set `missingValue`
#' to `TRUE` to turn of the processing of missing values.
#'
#' @param tz character string indicating time zone to be assumed in the data.
#'
#' @template encodingTemplate
#'
#' @param debug a flag that turns on debugging, ignored in the present version
#' of the function.
#'
#' @return A data frame containing `t`, a POSIX time, and `index`,
#' the numerical index.  The times are set to the 15th day of each month, which
#' is a guess that may need to be changed if so indicated by documentation (yet
#' to be located).
#'
#' @references See `https://psl.noaa.gov/data/climateindices/list/`
#' for a list of indices.
#'
#' @section Sample of Usage:
#' \preformatted{
#' library(oce)
#' par(mfrow=c(2, 1))
#' # 1. AO, Arctic oscillation
#' #  Note that data used to be at https://www.esrl.noaa.gov/psd/data/correlation/ao.data
#' ao <- read.index("https://psl.noaa.gov/data/correlation/ao.data")
#' aorecent <- subset(ao, t > as.POSIXct("2000-01-01"))
#' oce.plot.ts(aorecent$t, aorecent$index)
#' # 2. SOI, probably more up-to-date then data(soi, package="ocedata")
#' soi <- read.index("https://www.cgd.ucar.edu/cas/catalog/climind/SOI.signal.ascii")
#' soirecent <- subset(soi, t > as.POSIXct("2000-01-01"))
#' oce.plot.ts(soirecent$t, soirecent$index)
#' }
#'
#' @author Dan Kelley
read.index <- function(
    file,
    format,
    missingValue,
    tz = getOption("oceTz"),
    encoding = "latin1",
    debug = getOption("oceDebug")) {
    if (missing(file)) {
        stop("must supply 'file'")
    }
    if (is.character(file)) {
        if (!file.exists(file)) {
            stop("cannot find file \"", file, "\"")
        }
        if (0L == file.info(file)$size) {
            stop("empty file \"", file, "\"")
        }
    }
    if (is.character(file)) {
        # filename <- fullFilename(file)
        file <- file(file, "r", encoding = encoding)
        on.exit(close(file))
    }
    if (!inherits(file, "connection")) {
        stop("file must be a character string or connection")
    }
    if (!isOpen(file)) {
        open(file, "r", encoding = encoding)
        on.exit(close(file))
    }
    lines <- readLines(file, warn = FALSE)
    if (missing(format)) {
        ntokens <- length(scan(text = lines[1], quiet = TRUE))
        if (2 == ntokens) {
            format <- "noaa"
        } else if (13 == ntokens) {
            format <- "ucar"
        } else {
            stop("first line must contain either 2 or 13 tokens, but it contains ", ntokens, " tokens")
        }
    }
    formatAllowed <- c("noaa", "ucar")
    formatIndex <- pmatch(format, formatAllowed)
    if (is.na(formatIndex)) {
        stop("unknown format; must be 'noaa' or 'ucar'")
    }
    format <- formatAllowed[formatIndex]
    if (format == "noaa") {
        lines <- lines[-1] # drop first header line
        # the missing value is on a line by itself, and after that
        # is footer that we will ignore for now.
        n <- unlist(lapply(
            seq_along(lines),
            function(l) length(scan(text = lines[l], what = "numeric", quiet = TRUE))
        ))
        onetoken <- which(n == 1)[1]
        if (is.na(onetoken)) {
            stop("cannot find missing-value token")
        }
        missingValue <- as.numeric(lines[onetoken])
        lines <- lines[seq.int(1L, onetoken - 1)]
        d <- as.matrix(read.table(text = lines, header = FALSE, encoding = encoding))
        year <- d[, 1]
        t <- seq(ISOdatetime(year[1], 1, 15, 0, 0, 0, tz = "UTC"), by = "month", length.out = 12 * length(year))
        data <- as.vector(t(d[, -1]))
        data[data == missingValue] <- NA
    } else if (format == "ucar") {
        m <- read.table(text = lines, header = FALSE, encoding = encoding)
        year <- m[, 1]
        data <- as.vector(t(m[, -1]))
        t <- seq(ISOdatetime(year[1], 1, 15, 0, 0, 0, tz = "UTC"), by = "month", length.out = 12 * length(year))
    } else {
        stop("unknown format '", format, "'; must be 'noaa' or 'ucar'")
    }
    if (missing(missingValue)) {
        # guess, probably dangerous
        data[data <= -99] <- NA
    } else {
        if (!is.null(missingValue)) {
            data[data == missingValue] <- NA
        }
    }
    data.frame(t = t, index = data)
}

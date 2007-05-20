"ctd.trim" <- function(x, method="downcast", parameters=NULL)
{
  	if (!inherits(x, "ctd"))
    	stop("method is only for ctd objects")
  	result <- x
  	n <- length(x$data$pressure)
  	if (n < 2) {
    	warning("too few data to trim.ctd()")
  	}
 	else {
    	keep <- rep(TRUE, n)
    	if (method == "index") {
			cat("parameters:",parameters,"\n");
			if (min(parameters) < 1)
				stop("Cannot select indices < 1");
			if (max(parameters) > n)
				stop(paste("Cannot select past end of array, i.e. past ", n))
       		keep <- rep(FALSE, n)
       		keep[parameters] <- TRUE
    	}
 		else if (method == "downcast") {
      		deltat <- x$data$time[2] - x$data$time[1]
      		dpdt <- diff(x$data$pressure) / deltat
      		dpdt <- c(dpdt[1], dpdt)          # duplicate point to get right length
      		keep <- dpdt > 0
    	}
 		else if (method == "upcast") {
      		warning("upcast does nothing for now\n")
    	}
 		else {
			l <- length(parameters)
			if (l == 1) { 		# lower limit
    	  		keep <- (x$data[[method]] > parameters[1]);
			}
			else if (l == 2) {	# lower and upper limits
    	  		keep <- (x$data[[method]] > parameters[1]) & (x$data[[method]] < parameters[2])
			}
    	}
  	}
  	#cat("\nBEFORE:");print(x$data$pressure)
  	result$data <- subset(x$data, keep)
  	#cat("AFTER:");print(x$data$pressure)
  	result
}

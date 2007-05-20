sw.S.T.rho <- function(t, rho, p)
{
  	nt <- length(t)
  	nrho <- length(rho)
  	np <- length(p)
  	if (nt != nt)
    	stop("lengths of temperature and density must agree, but they are ", nt, " and ", nrho, ", respectively")
	if (nt != np)
    	stop("lengths of temperature and p arrays must agree, but they are ", nt, " and ", np, ", respectively")
  	for (i in 1:nt) {
    	sig <- rho[i]
    	if (sig > 500) {
      		sig <- sig - 1000
    	}
    	this.S <- .C("sw_strho",
			as.double(t[i]),
			as.double(sig),
			as.double(p[i]),
			S = double(1),
			NAOK=TRUE, PACKAGE = "oce")$S
    	if (i == 1)
			res <- this.S
		else
			res <- c(res, this.S)
  	}
  	res
}

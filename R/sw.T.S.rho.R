sw.T.S.rho <- function(S, rho, p)
{
  	nS <- length(S)
  	nrho <- length(rho)
  	np <- length(p)
  	if (nS != nrho)
    	stop("lengths of S and rho must agree, but they are ", nS, " and ", nrho,  ", respectively")
  	if (nS != np)
    	stop("lengths of S and p must agree, but they are ", nS, " and ", np, ", respectively")
  	for (i in 1:nS) {
    	sig <- rho[i]
    	if (sig > 500) {
      		sig <- sig - 1000
    	}
    	this.t <- .C("sw_tsrho",
			as.double(S[i]), 
			as.double(sig),
			as.double(p[i]), 
            t = double(1), 
			NAOK=TRUE, PACKAGE = "oce")$t
    	if (i == 1)
			res <- this.t
		else
			res <- c(res, this.t)
  	}
  	res
}

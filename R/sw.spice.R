sw.spice <- function(S, t, p)
{
  	nS <- length(S)
  	nt <- length(t)
  	np <- length(p)
  	if (nS != nt)
    	stop("lengths of S and t must agree, but they are ", nS, " and ", nt, ", respectively")
  	if (nS != np)
    	stop("lengths of S and p must agree, but they are ", nS, " and ", np, ", respectively")
	for (i in 1:nS) {
    	this.spice <- .C("sw_spice",
			as.double(S[i]),
			as.double(t[i]),
			as.double(p[i]), 
        	spice = double(1), 
			NAOK=TRUE, PACKAGE = "oce")$spice
    	if (i == 1)
			res <- this.spice
		else
			res <- c(res, this.spice)
  	}
  	res
}

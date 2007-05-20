sw.rho <- function(S, t, p)
{
  	nS <- length(S)
  	nt <- length(t)
  	np <- length(p)
  	if (nS != nt)
    	stop("lengths of S and t must agree, but they are ", nS, " and ", nt, ", respectively")
	# sometimes give just a single p value (e.g. for a TS diagram)
	if (np == 1) {
		np <- nS
		p <- rep(p[1], np)
	}
  	if (nS != np)
    	stop("lengths of S and p must agree, but they are ", nS, " and ", np, ", respectively")
  	.C("sw_rho",
		as.integer(nS),
		as.double(S),
		as.double(t),
		as.double(p),
		value = double(nS),
		NAOK=TRUE, PACKAGE = "oce")$value
}

# I really should add ability to specify column numbers, to avoid wasting time
# on ad-hoc header tweaks.  DEK 2006-01-27

# Read Seabird data file.  Note on headers: '*' is machine-generated,
# '**' is a user header, and '#' is a post-processing header.
read.ctd <- function(file,
	   	type="SBE19",
   		debug=FALSE,
		columns=NULL,
	   	check.human.headers=TRUE)
{
  	filename<-file
  	if (is.character(file)) {
    	file <- file(file, "r")
    	on.exit(close(file))
  	}
  	if (!inherits(file, "connection")) {
    	stop("argument `file' must be a character string or connection")
	}
	if (!isOpen(file)) {
    	open(file, "r")
    	on.exit(close(file))
  	}
  	if (type != "SBE19") {
   		stop("Only the type 'SBE19' is understood.  Try using this value (the default) no matter what your instrument is")
	}
  	# Header
  	scientist <- ship <- institute <- address <- NaN
  	sample.interval <- NaN
  	mooring <- NaN
  	latitude <- longitude <- latitude.dec <- longitude.dec <- NaN
  	start.time <- NaN
  	start.time.list <- NaN
  	water.depth <- NaN
  	date <- recovery <- NaN
  	header <- c();
  	col.names.inferred <- NULL
  	found.temperature <- found.salinity <- found.pressure <- FALSE
  	found.sigma.theta <- found.sigma.t <- found.sigma <- FALSE
	found.conductivity <- found.conductivity.ratio <- FALSE
	conductivity.standard <- 4.2914
  	while (TRUE) {
    	line <- scan(file, what='char', sep="\n", n=1, quiet=TRUE);
    	if(debug)
	  		cat(paste("examining header line '",line,"'\n"));
    	header <- c(header, line);
    	#if (length(grep("\*END\*", line))) #BUG# why is this regexp no good (new with R-2.1.0)
		aline <- iconv(line, from="UTF-8", to="ASCII", sub="?");
		if (length(grep("END", aline, perl=TRUE, useBytes=TRUE)))
      		break;
		lline <- tolower(aline);
    	# BUG: the discovery of CTD column names is brittle to file-format changes
    	if (0 < (r <- regexpr("# name ", lline))) {
	  		if (debug)
				print(paste("line=",line))
      		tokens <- strsplit(line, split=" ")
      		name <- tokens[[1]][6]
      		if (0 < regexpr("pressure", lline)) {
        		name <- "pressure"
        		found.pressure <- TRUE
      		}
      		if (0 < regexpr("salinity", lline)) {
        		name <- "salinity"
        		found.salinity <- TRUE
      		}
      		if (0 < regexpr("temperature", lline)) {
        		name <- "temperature"
        		found.temperature <- TRUE
      		}
			if (0 < regexpr("conductivity", lline)) {
				if (0 < regexpr("ratio", lline)) {
					found.conductivity.ratio <- TRUE;
					name <- "conductivityratio";
				}
				else {
					found.conductivity <- TRUE;
					name <- "conductivity";
				}
			}
      		if (0 < regexpr("depth", lline)) name <- "depth"
      		if (0 < regexpr("fluorometer", lline)) name <- "fluorometer"
      		if (0 < regexpr("oxygen, current", lline)) name <- "oxygen.current"
      		if (0 < regexpr("oxygen, temperature", lline)) name <- "oxygen.temperature"
      		if (0 < regexpr("flag", lline)) name <- "flag"
      		if (0 < regexpr("sigma-theta", lline)) {
        		name <- "sigma.theta"
        		found.sigma.theta <- TRUE
      		}
			else {
        		if (0 < regexpr("sigma-t", lline)) {
          			name <- "sigma.t"
        			found.sigma.t <- TRUE
        		}
      		}
      		col.names.inferred <- c(col.names.inferred, name)
    	}
    	if (0 < (r<-regexpr("date:", lline))) {
      		date <- sub("(.*)date:([ ])*", "", lline);
		}
    	if (0 < (r<-regexpr("latitude:", lline))) {
      		north <- TRUE
      		latitude <- sub("(.*)latitude:([ ])*", "", ignore.case=TRUE, line);
      		trimmed <- latitude
      		if (0 < (r <- regexpr("[Nn]", trimmed))) {
        		trimmed <- sub("n", "", ignore.case=TRUE, trimmed)
      		}
      		if (0 < (r <- regexpr("[Ss]", trimmed))) {
        		north <- FALSE
        		trimmed <- sub("s", "", ignore.case=TRUE, trimmed)
      		}
      		lat <- strsplit(trimmed, " ")
      		if (length(lat[[1]]) == 2) {
        		latitude.dec <- as.double(lat[[1]][1]) + as.double(lat[[1]][2]) / 60
        		if (!north) {
          			latitude.dec <- -(latitude.dec)
        		}
      		}
			else {
        		warning("cannot parse Latitude in header since need 2 items but got ", length(lat[[1]]), " items in '", line, "'\n")
      		}
    	}
    	if (0 < (r<-regexpr("longitude:", lline))) {
      		east <- TRUE
      		longitude <- sub("(.*)longitude:([ ])*", "", ignore.case=TRUE, line);
      		trimmed <- longitude
      		if (0 < (r <- regexpr("[Ee]", trimmed))) {
        		trimmed <- sub("e", "", ignore.case=TRUE, trimmed)
      		}
      		if (0 < (r <- regexpr("[Ww]", trimmed))) {
        		east <- FALSE
        		trimmed <- sub("w", "", ignore.case=TRUE, trimmed)
      		}
      		lon <- strsplit(trimmed, " ")
      		if (length(lon[[1]]) == 2) {
        		longitude.dec <- as.double(lon[[1]][1]) + as.double(lon[[1]][2]) / 60
        		if (!east) {
          			longitude.dec <- -(longitude.dec)
        		}
      		}
 			else {
        		warning("cannot parse Longitude in header since need 2 items but got ", length(lon[[1]]), " items in '", line, "'\n")
      		}
    	}
    	if (0 < (r<-regexpr("start_time =", lline))) {
       		#    # start_time = Aug 28 2002 18:25:50
       		#    1      2     3  4   5   6     7
       		items <- strsplit(lline, " ")
       		if (length(items[[1]]) != 7) {
         		warning("cannot parse start_time in header since need 7 items but got ", length(items[[1]]), " items in '", line, "'\n")
       		}
			else {
				month <- items[[1]][4]; # UGLY: ascii
				if (month=="jan") month= 1; # FILL IN LATER
				if (month=="feb") month= 2; # FILL IN LATER
				if (month=="mar") month= 3; # FILL IN LATER
				if (month=="apr") month= 4; # FILL IN LATER
				if (month=="may") month= 5; # FILL IN LATER
				if (month=="jun") month= 6; # FILL IN LATER
				if (month=="jul") month= 7; # FILL IN LATER
				if (month=="aug") month= 8; # FILL IN LATER
				if (month=="sep") month= 9; # FILL IN LATER
				if (month=="oct") month= 10; # FILL IN LATER
				if (month=="nov") month= 11; # FILL IN LATER
				if (month=="dec") month= 12; # FILL IN LATER
				day <- as(items[[1]][5], "numeric")
				year <- as(items[[1]][6], "numeric");
				hms <- strsplit(items[[1]][7],":")
				hour <- hms[[1]][1]
				min  <- hms[[1]][2]
				sec  <- hms[[1]][3]
				start.time <- ISOdatetime(year,month,day,hour,min,sec,"GMT")
				start.time.list <- c(year,month,day,hour,min,sec)
      		}
    	}
    	if (0 < (r<-regexpr("ship:", lline))) {
			#cat(line);cat("\n");
      		ship <- sub("(.*)ship:([ ])*", "", ignore.case=TRUE, line); # note: using full string
			#cat(ship);cat("\n");
		}
    	if (0 < (r<-regexpr("scientist:", lline)))
      		scientist <- sub("(.*)scientist:([ ])*", "", ignore.case=TRUE, line); # full string
    	if (0 < (r<-regexpr("institute:", lline)))
      		institute <- sub("(.*)institute:([ ])*", "", ignore.case=TRUE, line); # full string
    	if (0 < (r<-regexpr("address:", lline)))
      		address <- sub("(.*)address:([ ])*", "", ignore.case=TRUE, line); # full string
    	if (0 < (r<-regexpr("cruise:", lline)))
      		cruise <- sub("(.*)cruise:([ ])*", "", ignore.case=TRUE, line); # full string
    	if (0 < (r<-regexpr("mooring:", lline)))
      		mooring <- sub("(.*)mooring:([ ])*", "", lline);
    	if (0 < (r<-regexpr("recovery:", lline)))
      		recovery <- sub("(.*)recovery:([ ])*", "", lline);
    	if (0 < (r<-regexpr("water depth:", lline))) {
      		linesplit <- strsplit(line," ")
      		if (length(linesplit[[1]]) != 7)
        		warning("cannot parse water depth in `",line,"' (expecting 7 tokens)");
      		value <- linesplit[[1]][6]
      		unit <- strsplit(lline," ")[[1]][7]
      		if (!is.na(unit)) {
        		if (unit == "m") {
          			water.depth <- as.numeric(value)
        		}
				else {
          			if (rtmp[[1]][2] == "km") {
            			water.depth <- as.numeric(value) * 1000
          			}
        		}
      		}
    	}
    	if (0 < (r<-regexpr("^. sample rate =", lline))) {
      		#* sample rate = 1 scan every 5.0 seconds
      		rtmp <- lline;
      		rtmp <- sub("(.*) sample rate = ", "", rtmp);
      		rtmp <- sub("scan every ", "", rtmp);
      		rtmp <- strsplit(rtmp, " ");
			#      if (length(rtmp[[1]]) != 3)
			#        warning("cannot parse sample-rate string in `",line,"'");
      		sample.interval <- as.double(rtmp[[1]][2]) / as.double(rtmp[[1]][1])
      		if (rtmp[[1]][3] == "seconds") {
        		;
      		}
			else {
        		if (rtmp[[1]][3] == "minutes") {
          			sample.interval <- sample.interval / 60;
        		}
 				else {
          			if (rtmp[[1]][3] == "hours") {
            			sample.interval <- sample.interval / 3600;
          			}
					else {
            			warning("cannot understand `",rtmp[[1]][2],"' as a unit of time for sample.interval");
          			}
        		}
      		}
    	}
  	}
  	if (debug)
    	cat("Finished reading header\n")
  	if (is.nan(sample.interval))
    	warning("'* sample rate =' not found in header");
  	if (check.human.headers) {
		if (is.nan(latitude))
    		warning("'** Latitude:' not found in header");
  		if (is.nan(longitude))
    		warning("'** Longitude:' not found in header");
  		if (is.nan(date))
    		warning("'** Date:' not found in header");
  		if (is.nan(recovery))
    		warning("'** Recovery' not found in header"); 
  	}
  	# Require p,S,T data at least
  	if (!found.temperature)
    	stop("cannot find 'temperature' in this file")
  	if (!found.pressure)
    	stop("cannot find 'pressure' in this file")
	# Data
  	# BUG: should be inferring the column names from the header!
  	col.names.forced <- c("scan","pressure","temperature","conductivity","descent","salinity","sigma.theta.unused","depth","flag");
	col.names.inferred <- tolower(col.names.inferred)
  	if (debug) {
		#cat("About to read.table these names:", col.names.forced,"\n");
		cat("About to read these names:", col.names.inferred,"\n");
	}
  	#DELETED# data <- read.table(file,col.names=col.names.inferred,colClasses="numeric");
#  	data <- read.table(file,col.names=col.names.forced,colClasses="numeric");
  	data <- read.table(file,col.names=col.names.inferred,colClasses="numeric");
  	res <- list(header=header, 
	      		filename=filename,
              	ship=ship,
              	scientist=scientist,
              	institute=institute,
              	address=address,
              	cruise=cruise,
              	mooring=mooring,
              	date=date,
	      		start.time=start.time,
	      		start.time.list=start.time.list,
              	latitude=latitude,
              	latitude.dec=latitude.dec,
              	longitude=longitude,
              	longitude.dec=longitude.dec,
              	recovery=recovery,
              	water.depth=water.depth,
              	sample.interval=sample.interval,
              	data=data);
  	class(res) <- "ctd"
	# Add standard things, if missing
  	if (!found.salinity) {
		if (found.conductivity.ratio) {
    		warning("cannot find 'salinity' in this file; calculating from T, C, and p");
			S <- S.C.T.p(data$conductivityratio, data$temperature, data$pressure)
		} else if (found.conductivity) {
    		warning("cannot find 'salinity' in this file; calculating from T, C-ratio, and p");
			S <- S.C.T.p(data$conductivity/conductivity.standard, data$temperature, data$pressure)
		} else {
			stop("cannot find salinity in this file, nor conductivity or conductivity ratio")
		}
		res <- ctd.add.column(res, S, "salinity", "sal", "salinity", "PSU")
  	}
	res <- ctd.add.column(res, sw.sigma(res$data$salinity, res$data$temperature, res$data$pressure),
		"sigma", "sigma", "sigma", "kg/m^3")
	return(res)
}

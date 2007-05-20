\name{sealevel}
\docType{data}
\alias{sealevel}
\title{Sample sea-level data set}
\description{This sample sea-level dataset is the 1999 
record from Halifax Harbour
in Nova Scotia, Canada.
  The code in \code{\link{read.sealevel}} was written based on examination of
  this and similar files.}  
\usage{data(sealevel)}
\format{
The data format is as described below, taken from 
\url{ftp://ilikai.soest.hawaii.edu/rqds/hourly.fmt}.
\preformatted{
		UH SEA LEVEL CENTER/JOINT ARCHIVE FOR SEA LEVEL
		               'ARCHIVING' FORMAT 
			   FOR HOURLY SEA LEVEL DATA

          The hourly data consist of files grouped by year that
     have been "zipped" into a single file per time series.
     The Info-Zip web site is at: http://www.cdrom.com/pub/infozip
     and the software can be directly downloaded from
     ftp://ftp.cdrom.com/pub/infozip/.  This freeware zip 
     utility is compatible to most platforms and operating
     systems.  For MS-DOS systems, use the -aa option
     during unzipping.  This will add the Carriage Return-
     Line Feed end-of-record sequence.


FILE NAME CONVENTION: 

          Each file is given a name hsssv.dat where sss denotes the
     the UHSLC/JASL inhouse station number and v denotes the version.
     For example, h003b.dat is the 1987 observed daily data file in
     the permanent archive for Baltra-B.  Baltra is a station with
     more than one independent series due to a station replacement
     that is not linked to the bench marks of the original station.

     
FORMAT DESCRIPTION:
          A file exists for all years with data and every hourly value
     in the year contains either data or a missing data flag (9999).
     If complete years are missing between data values, then all
     records for those years are filled with missing data flags, as well.
     One header exists at the start of each year. All records are fixed-length, 
     80-byte.
     
     
          The unique header for each file is coded as:
	  
     
          field          bytes   length             comment
     -----------------  -------  ------  ------------------------------------
     station number        1-3     3     exactly 3 digits
     station version         4     1     letter from A to Z 
     station name         6-23    18     Abbreviated if necessary     
     region/country      25-43    19     Abbreviated if necessary     
     year                45-48     4
     latitude            50-55     6     degrees, minutes, tenths
                                         (implied decimal), and hemisphere
     longitude           57-63     7     degrees, minutes, tenths
                                         (implied decimal), and hemisphere
     GMT offset          65-68     4     time data are related to in terms
                                         of difference from GMT in hours
					 and tenths (implied decimal) with
					 East latitudes positive*
     decimation method      70     1     Coded as 1 : filtered
                                                  2 : simple average of all
						      samples
						  3 : spot readings
						  4 : other
     reference offset    72-76     5     constant offset to be added to each
                                         each data value for data to be 
					 relative to tide staff zero or primary
					 datum in same units as data
     reference code         77     1     R = data referenced to datum
                                         X = data not referenced to datum
     units               79-80     2     always millimeters, MM
					 
     * Data always are in GMT (offset=0000) unless data are relative to a local
       time zone that is not an increment of one hour from GMT.  For example,
       Colombo, Sri Lanka has a GMT offset = 0055 which is 5.5 hours ahead
       of GMT.

          The data records are coded as:
	  
          field          bytes   length             comment
     -----------------  -------  ------  ------------------------------------
     station number        1-3     3     exactly 3 digits
     station version         4     1     letter from A to Z 
     station name          6-9     4     Abbreviated if necessary          
     year                12-15     4
     month               16-17     2     numerical value
     day                 18-19     2
     day record count       20     1     either 1 or 2
     sea level data      21-80    60     12 sea level values, 
                                         hours 00-11 (1); hours 12-23 (2)

     For example:
     
029A Kapingamarangi     Fd St Micronesia    1987 01059N 154466E 0000 1 00000R MM
029A Kapi  1987 1 11 1768 1661 1476 1267 1078  956  914  975 1067 1189 1280 1311
029A Kapi  1987 1 12 1250 1097  975  792  671  610  732  884 1006 1341 1585 1737
029A Kapi  1987 1 21 1829 1768 1692 1494 1219 1036  945  914 1006 1097 1158 1280
029A Kapi  1987 1 22 1341 1219 1097  945  792  701  671  762  884 1067 1341 1554
029A Kapi  1987 1 31 1737 1829 1768 1615 1433 1219 1036  945  914 1006 1036 1189
029A Kapi  1987 1 32 1280 1311 1219 1067 1006  823  732  701  792  884 1097 1372
}
}
\source{\url{http://ilikai.soest.hawaii.edu/uhslc/htmld/d0275A.html}}
\references{The file format given above is verbatim from \url{ftp://ilikai.soest.hawaii.edu/rqds/hourly.fmt}
}

\author{Dan Kelley \email{Dan.Kelley@Dal.Ca}}
\keyword{misc}

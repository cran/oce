// vim: set expandtab shiftwidth=2 softtabstop=2 tw=70: 

#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>
#include <time.h>

#define debug 1

// The next items are specific to ad2cp, as is the whole
// format, but I want to define these here to make the
// code clearer. See [1 sec 6.1].
#define SYNC 0xA5
#define HEADER_SIZE 10
#define FAMILY 0x10

//#define DEBUG


/*

   Locate (header+data) for Nortek ad2cp

   @param filename character string indicating the file name.

   @param from integer giving the index of the first ensemble (AKA
   profile) to retrieve. The R notation is used, i.e. from=1 means the
   first profile.

   @param to integer giving the index of the last ensemble to retrieve.
   As a special case, setting this to 0 will retrieve *all* the data
   within the file.

   @param by integer giving increment of the sequence, as for seq(), i.e.
   a value of 1 means to retrieve all the profiles, while a value of 2
   means to get every second profile.

   @value a list containing 'index', 'length' and 'id'. The last of
   these mean: 0x16=21 for Burst Data Record; 0x16=22 for Average Data
   Record; 0x17=23 for Bottom Track Data Record; 0x18=24 for
   Interleaved Burst Data Record (beam 5); 0xA0=160 forString Data
   Record, eg. GPS NMEA data, comment from the FWRITE command.

   @examples

   system("R CMD SHLIB ldc_ad2cp_in_file.c")
   f <- "/Users/kelley/Dropbox/oce_ad2cp/labtestsig3.ad2cp"
   dyn.load("ldc_ad2cp_in_file.so")
   a <- .Call("ldc_ad2cp_in_file", f, 1, 10, 1)

@section: notes

Table 6.1 (header definition):

+-----------------+--------------------+------------------------------------------------------+
| Sync            | 8 bits             | Always 0xA5                                          |
+-----------------|--------------------|------------------------------------------------------+
| Header Size     | 8 bits (unsigned)  | Size (number of bytes) of the Header.                |
+-----------------|--------------------|------------------------------------------------------+
| ID              | 8 bits             | Defines type of the following Data Record            |
|                 |                    | 0x16=21  – Burst Data Record.                        |
|                 |                    | 0x16=22  – Average Data Record.                      |
|                 |                    | 0x17=23  – Bottom Track Data Record.                 |
|                 |                    | 0x18=24  – Interleaved Burst Data Record (beam 5).   |
|                 |                    | 0xA0=160 - String Data Record, eg. GPS NMEA data,    |
|                 |                    |            comment from the FWRITE command.          |
+-----------------|--------------------|------------------------------------------------------|
| Family          | 8 bits             | Defines the Instrument Family. 0x10 – AD2CP Family   |
+-----------------|--------------------|------------------------------------------------------+
| Data Size       | 16 bits (unsigned) | Size (number of bytes) of the following Data Record. |
+-----------------|--------------------|------------------------------------------------------+
| Data Checksum   | 16 bits            | Checksum of the following Data Record.               |
+-----------------|--------------------|------------------------------------------------------+
| Header Checksum | 16 bits            | Checksum of all fields of the Header                 |
|                 |                    | (excepts the Header Checksum itself).                |
+-----------------+--------------------+------------------------------------------------------+

Note that the code examples in [1] suggest that the checksums are also unsigned, although
that is not stated in the table. I think the same can be said of [2]. But I may be wrong,
since I am not getting checksums appropriately.

@references

1. "Integrators Guide AD2CP_A.pdf", provided to me privately by
(person 1) in early April of 2017.

2. https://github.com/aodn/imos-toolbox/blob/master/Parser/readAD2CPBinary.m

@author

Dan Kelley

*/

// Check the header checksum.
//
// The code for this differs from that suggested by Nortek,
// because we don't use a specific (msoft) compiler, so we
// do not have access to misaligned_load16(). Also, I don't
// think this will work properly if the number of bytes
// is odd.
//
// FIXME: handle odd-numbered byte case.
unsigned short cs(unsigned char *data, unsigned short size)
{
  // It might be worth checking the matlab code at
  //     https://github.com/aodn/imos-toolbox/blob/master/Parser/readAD2CPBinary.m
  // for context, if problems ever arise.
  unsigned short checksum = 0xB58C;
  for (int i = 0; i < size; i += 2) {
    checksum += (unsigned short)data[i] + 256*(unsigned short)data[i+1];
  }
  return(checksum);
}



SEXP ldc_ad2cp_in_file(SEXP filename, SEXP from, SEXP to, SEXP by)
{

  const char *filenamestring = CHAR(STRING_ELT(filename, 0));
  FILE *fp = fopen(filenamestring, "rb");
  if (!fp)
    error("cannot open file '%s'\n", filenamestring);
  PROTECT(from = AS_INTEGER(from));
  PROTECT(to = AS_INTEGER(to));
  PROTECT(by = AS_INTEGER(by));

  int from_value = *INTEGER_POINTER(from);
  if (from_value < 0)
    error("'from' must be positive but it is %d", from_value);
  int to_value = *INTEGER_POINTER(to);
  if (to_value < 0)
    error("'to' must be positive but it is %d", to_value);
  int by_value = *INTEGER_POINTER(by);
  if (by_value < 0)
    error("'by' must be positive but it is %d", by_value);
  if (debug > 1) Rprintf("from=%d, to=%d, by=%d\n", from_value, to_value, by_value);

  // FIXME: should we just get this from R? and do we even need it??
  fseek(fp, 0L, SEEK_END);
  unsigned long int fileSize = ftell(fp);
  fseek(fp, 0L, SEEK_SET);
  if (debug > 3) Rprintf("fileSize=%d\n", fileSize);
  unsigned long int chunk = 0;
  unsigned long int cindex = 0;

  // Ensure that the first byte we point to equals SYNC.
  // In a conentional file, starting with a SYNC char, this
  // just gets a byte and puts it back, leaving cindex=0.
  // But if the file does not start with a SYNC char, this works
  // along the file until it finds one, and adjusts cindex
  // appropriately.
  int c;
  while (1) {
    c = getc(fp);
    if (EOF == c) {
      error("this file does not contain a single 0x", SYNC, " byte");
      break;
    }
    if (debug > 2) Rprintf("< c=0x%x\n", c);
    if (SYNC == c) {
      fseek(fp, -1, SEEK_CUR);
      break;
    }
    cindex++;
  }
  // The table in [1 sec 6.1] says header pieces are 10 bytes
  // long, so once we get an 0xA5, we'll try to get 9 more bytes.
  unsigned char hbuf[HEADER_SIZE]; // header buffer
  unsigned int dbuflen = 10; // may be increased later
  unsigned char *dbuf = (unsigned char *)Calloc((size_t)dbuflen, unsigned char);
  unsigned int nchunk = 100;
  unsigned int *index_buf = (unsigned int*)Calloc((size_t)nchunk, unsigned int);
  unsigned int *length_buf = (unsigned int*)Calloc((size_t)nchunk, unsigned int);
  unsigned int *id_buf = (unsigned int*)Calloc((size_t)nchunk, unsigned int);
  while (chunk < to_value) {// FIXME: use whole file here
    if (chunk > nchunk - 1) {
      Rprintf(" > must increase buffers from nchunk=%d\n", nchunk);
      nchunk = (unsigned int) chunk * 2; // expand buffer by sqrt(2)
      index_buf = (unsigned int*)Realloc(index_buf, nchunk, unsigned int);
      length_buf = (unsigned int*)Realloc(length_buf, nchunk, unsigned int);
      id_buf = (unsigned int*)Realloc(id_buf, nchunk, unsigned int);
      Rprintf(" > increased buffers to have nchunk=%d\n", nchunk);
    }
    int id, dataSize;
    unsigned short dataChecksum, headerChecksum;
    size_t bytes_read;
    bytes_read = fread(hbuf, 1, HEADER_SIZE, fp);
    if (bytes_read != HEADER_SIZE) {
      Rprintf("malformed header at cindex=%d", cindex);
      break; // FIXME: maybe we should stop here, actually
    }
    cindex += bytes_read;
    if (debug > 1)
      Rprintf("buf: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
          hbuf[0], hbuf[1], hbuf[2], hbuf[3], hbuf[4],
          hbuf[5], hbuf[6], hbuf[7], hbuf[8], hbuf[9]);
    // It's prudent to check.
    if (hbuf[0] != SYNC) {
      error("coding error in reading the header at cindex=%d; expecting 0x%x but found 0x%x\n",
          cindex, SYNC, hbuf[0]);
    }
    // Check that it's an actual header
    if (hbuf[1] == HEADER_SIZE && hbuf[3] == FAMILY) {
      id = (int)hbuf[2];
      dataSize = hbuf[4] + 256 * hbuf[5];
      //Rprintf("\n\tdataSize=%5d ", dataSize);
      dataChecksum = hbuf[6] + 256 * hbuf[7];
      //Rprintf(" dataChecksum=%5d", dataChecksum);
      headerChecksum = hbuf[8] + 256 * hbuf[9];
      //Rprintf(" > saved to chunk %d (id=%d)\n", chunk, id);
      index_buf[chunk] = cindex;
      length_buf[chunk] = dataSize;
      if (id < 21 || (id > 24 && id != 160))
        Rprintf(" *** odd id (%d) at chunk %d, index=%d\n", id, chunk, cindex);
      id_buf[chunk] = id;
      // Check the header checksum.
      unsigned short hbufcs = cs(hbuf, HEADER_SIZE-2);
      if (hbufcs != headerChecksum) {
        Rprintf("WARNING: at cindex=%d, header checksum is %d but it should be %d\n",
            cindex, hbufcs, headerChecksum);
      }
      // Increase size of data buffer, if required.
      if (dataSize > dbuflen) { // expand the buffer if required
        dbuflen = dataSize;
        dbuf = (unsigned char *)Realloc(dbuf, dbuflen, unsigned char);
      }
      // Read the data
      bytes_read = fread(dbuf, 1, dataSize, fp);
      // Check that we got all the data
      if (bytes_read != dataSize)
        error("ran out of file on data chunk near cindex=%d; wanted %d bytes but got only %d\n",
            cindex, dataSize, bytes_read);
      // Compare data checksum to the value stated in the header
      unsigned short dbufcs;
      dbufcs = cs(dbuf, dataSize);
      if (dbufcs != dataChecksum) {
        Rprintf("WARNING: at cindex=%d, data checksum is %d but it should be %d\n",
            cindex, dbufcs, dataChecksum);
      }
      cindex += dataSize;
    }
    chunk++;
  }
  // prepare result (a list)
  SEXP lres;
  SEXP lres_names;
  PROTECT(lres = allocVector(VECSXP, 3));
  PROTECT(lres_names = allocVector(STRSXP, 3));
  SEXP index, length, id;
  PROTECT(index = NEW_INTEGER(chunk));
  PROTECT(length = NEW_INTEGER(chunk));
  PROTECT(id= NEW_INTEGER(chunk));
  int *indexp = INTEGER_POINTER(index);
  int *lengthp = INTEGER_POINTER(length);
  int *idp = INTEGER_POINTER(id);
  for (int i = 0; i < chunk; i++) {
    indexp[i] = index_buf[i];
    lengthp[i] = length_buf[i];
    idp[i] = id_buf[i];
  }
  SET_VECTOR_ELT(lres, 0, index);
  SET_VECTOR_ELT(lres, 1, length);
  SET_VECTOR_ELT(lres, 2, id);
  SET_STRING_ELT(lres_names, 0, mkChar("index"));
  SET_STRING_ELT(lres_names, 1, mkChar("length"));
  SET_STRING_ELT(lres_names, 2, mkChar("id"));
  setAttrib(lres, R_NamesSymbol, lres_names);
  UNPROTECT(8);
  return(lres);
}

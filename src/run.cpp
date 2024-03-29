/* vim: set expandtab shiftwidth=2 softtabstop=2 tw=70: */

#include <Rcpp.h>
using namespace Rcpp;

// Cross-reference work:
// 1. update ../src/registerDynamicSymbol.c with an item for this
// 2. main code should use the autogenerated wrapper in ../R/RcppExports.R
//
// [[Rcpp::export]]
List do_runlm(NumericVector x, NumericVector y, NumericVector xout, NumericVector window, NumericVector L)
{
  int nx = x.size();
  if (nx != y.size())
    //::Rf_error("lengths of x and y must match, but they are %d and %lld\n", nx, y.size());
    ::Rf_error("lengths of x and y do not match\n");
  int nxout = xout.size();
  NumericVector Y(nxout);
  NumericVector dYdx(nxout);
  double L2 = L[0] / 2;
  int windowType = (int)floor(0.5 + window[0]);

  if (windowType == 0) {
    for (int i = 0; i < nxout; i++) {
      double Sx = 0.0, Sy = 0.0, Sxx = 0.0, Sxy = 0.0;
      int n = 0;
      for (int j=0; j < nx; j++) {
        double l = fabs(xout[i] - x[j]);
        if (l < L2) {
          Sx += x[j];
          Sy += y[j];
          Sxx += x[j] * x[j];
          Sxy += x[j] * y[j];
          n++;
        }
      } // j
      if (n > 1) {
        double A = (Sxx * Sy - Sx * Sxy) / (n * Sxx - Sx * Sx);
        double B = (n * Sxy - Sx * Sy) / (n * Sxx - Sx * Sx);
        Y[i] = A + B * xout[i];
        dYdx[i] = B;
      } else {
        Y[i] = NA_REAL;
        dYdx[i] = NA_REAL;
      }
    } // i
  } else if (windowType == 1) {
    double pi = 3.141592653589793116;
    for (int i = 0; i < nxout; i++) {
      double Swwx = 0.0, Swwy = 0.0, Swwxx = 0.0, Swwxy = 0.0, Sww = 0.0;
      int n = 0;
      for (int j=0; j < nx; j++) {
        double l = fabs(xout[i] - x[j]);
        if (l < L2) {
          double ww = 0.5 * (1 + cos(pi * l / L2));
          Swwx += ww * x[j];
          Swwy += ww * y[j];
          Swwxx += ww * x[j] * x[j];
          Swwxy += ww * x[j] * y[j];
          Sww += ww;
          n++;
        }
      } // j
      if (n > 1) {
        double A = (Swwxx * Swwy - Swwx * Swwxy) / (Sww * Swwxx - Swwx * Swwx);
        double B = (Sww * Swwxy - Swwx * Swwy) / (Sww * Swwxx - Swwx * Swwx);
        Y[i] = A + B * xout[i];
        dYdx[i] = B;
      } else {
        Y[i] = NA_REAL;
        dYdx[i] = NA_REAL;
      }
    } // i
  } else {
    ::Rf_error("invalid window type (internal coding error in run.c)\n");
  }
  List res = List::create(Named("x")=xout,
      Named("y")=Y,
      Named("dydx")=dYdx,
      Named("L")=2*L2);
  return(res);
}


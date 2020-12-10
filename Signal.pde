// Stores a signal in frequency / time domain
class Signal {
  float realVal[], imagVal[];


  // Signal Constructor (Non-parameterized)
  Signal() {
    realVal = new float[0];
    imagVal = new float[0];
  }

  // Signal Constructor (Copy)
  Signal(Signal sig) {
    realVal = sig.realVal;
    imagVal = sig.imagVal;
  }
  
  // Signal Constructor
  Signal(int sig_size) {
    realVal = new float[sig_size];
    imagVal = new float[sig_size];
  }

  // Signal Constructor
  Signal(float realp[]) {
    realVal = realp;
    imagVal = new float[realp.length];
  }

  // Signal Constructor
  Signal(float realp[], float imagp[]) {
    realVal = realp;
    imagVal = imagp;
  }


  // Stores the "real" part of a signal in sig_dest
  void real(Signal sig_dest) {
    sig_dest.realVal = realVal;
    sig_dest.imagVal = new float[realVal.length];
  }

  // Gives the "real" part of a signal
  Signal real() {
    Signal sig = new Signal();
    real(sig);
    return(sig);
  }


  // Gives the "imaginary" part of a signal in sig_dest
  void imag(Signal sig_dest) {
    sig_dest.realVal = imagVal;
    sig_dest.imagVal = new float[imagVal.length];
  }

  // Gives the "imaginary" part of a signal
  Signal imag() {
    Signal sig = new Signal();
    imag(sig);
    return(sig);
  }


  // Gives the "absolute" of a signal in sig_dest
  void abs(Signal sig_dest) {
    sig_dest.realVal = new float[realVal.length];
    sig_dest.imagVal = new float[imagVal.length];

    for (int i=0; i<realVal.length; i++) {
      sig_dest.realVal[i] = sqrt(realVal[i] * realVal[i] + imagVal[i] * imagVal[i]);
    }
  }

  // Gives the "absolute" of a signal
  Signal abs() {
    Signal sig = new Signal();
    this.abs(sig);
    return(sig);
  }


  void setAbs(float absVal[]) {
    int    i, len;
    float  k, absOld;
    
    len = realVal.length;
    this.realVal = realVal;
    for(i=0; i<len; i++) {
      absOld = sqrt(realVal[i]*realVal[i] + imagVal[i]*imagVal[i]);
      if(absOld > 0) k = absVal[i] / absOld;
      else k = k = 1.0 / sqrt(2.0);
      realVal[i] = realVal[i] * k;
      imagVal[i] = imagVal[i] * k;
    }
  }


  // The Fast Fourier Transform routines given below marked with <by Jerome R. Breitenbach>
  // belong to the following author:
/*----------------------------------------------------------------------------
   fft.c - fast Fourier transform and its inverse (both recursively)
   Copyright (C) 2004, Jerome R. Breitenbach.  All rights reserved.

   The author gives permission to anyone to freely copy, distribute, and use
   this file, under the following conditions:
      - No changes are made.
      - No direct commercial advantage is obtained.
      - No liability is attributed to the author for any damages incurred.
  ----------------------------------------------------------------------------*/
  // I thank the author to provide the following routines, and assure him that:
  //  - Only changes were made to use it in Java Environment (Processing)
  //  - No commercial advantage is obtained.
  //  - No liability is attributed to the author for any damages incurred.
  
  // Private function to calculate "FFT" by recursion, <by Jerome R. Breitenbach>
  private void fft_rec(int N, int offset, int delta, Signal x, Signal X, Signal XX) {
    int     N2 = N/2;            // half the number of points in FFT 
    int     k;                   // generic index
    float   cs, sn;              // cosine and sine
    int     k00, k01, k10, k11;  // indices for butterflies
    float   tmp0, tmp1;          // temporary storage

    if (N != 2) {  // Perform recursive step. 
      // Calculate two (N/2)-point DFT's. 
      fft_rec(N2, offset, 2*delta, x, XX, X);
      fft_rec(N2, offset+delta, 2*delta, x, XX, X);

      // Combine the two (N/2)-point DFT's into one N-point DFT. 
      for (k=0; k<N2; k++) {
        k00 = offset + k*delta;
        k01 = k00 + N2*delta;
        k10 = offset + 2*k*delta;
        k11 = k10 + delta;
        cs = cos(TWO_PI*k/(float)N);
        sn = sin(TWO_PI*k/(float)N);
        tmp0 = cs * XX.realVal[k11] + sn * XX.imagVal[k11];
        tmp1 = cs * XX.imagVal[k11] - sn * XX.realVal[k11];
        X.realVal[k01] = XX.realVal[k10] - tmp0;
        X.imagVal[k01] = XX.imagVal[k10] - tmp1;
        X.realVal[k00] = XX.realVal[k10] + tmp0;
        X.imagVal[k00] = XX.imagVal[k10] + tmp1;
      }
    }
    else {  // Perform 2-point DFT. 
      k00 = offset;
      k01 = k00 + delta;
      X.realVal[k01] = x.realVal[k00] - x.realVal[k01];
      X.imagVal[k01] = x.imagVal[k00] - x.imagVal[k01];
      X.realVal[k00] = x.realVal[k00] + x.realVal[k01];
      X.imagVal[k00] = x.imagVal[k00] + x.imagVal[k01];
    }
  }


  // Private function to calculate "FFT", <by Jerome R. Breitenbach>
  private void fft_int(int N, Signal x, Signal X) {
    // Create a scratch signal
    Signal XX = new Signal(N);
    // Calculate FFT by a recursion
    fft_rec(N, 0, 1, x, X, XX);
  }

  // Gives the "FFT" of a signal in sig_dest
  void fft(Signal sig_dest) {
    sig_dest.realVal = new float[realVal.length];
    sig_dest.imagVal = new float[realVal.length];
    fft_int(realVal.length, this, sig_dest);
  }

  // Gives the "FFT" of a signal
  Signal fft() {
    Signal sig = new Signal();
    fft(sig);
    return(sig);
  }


  // Private function to calculate "IFFT", <by Jerome R. Breitenbach>
  private void ifft_int(int N, Signal x, Signal X) {
    int     N2 = N/2;       // half the number of points in IFFT 
    int     i;              // generic index 
    float  tmp0, tmp1;     // temporary storage 

    // Calculate IFFT via reciprocity property of DFT. 
    fft_int(N, X, x);
    x.realVal[0] = x.realVal[0]/N;
    x.imagVal[0] = x.imagVal[0]/N;
    x.realVal[N2] = x.realVal[N2]/N;
    x.imagVal[N2] = x.imagVal[N2]/N;
    for (i=1; i<N2; i++) {
      tmp0 = x.realVal[i]/N;
      tmp1 = x.imagVal[i]/N;
      x.realVal[i] = x.realVal[N-i]/N;
      x.imagVal[i] = x.imagVal[N-i]/N;
      x.realVal[N-i] = tmp0;
      x.imagVal[N-i] = tmp1;
    }
  }

  // Gives the "IFFT" of a signal in sig_dest
  void ifft(Signal sig_dest) {
    sig_dest.realVal = new float[realVal.length];
    sig_dest.imagVal = new float[realVal.length];
    ifft_int(realVal.length, sig_dest, this);
  }

  // Gives the "IFFT" of a signal
  Signal ifft() {
    Signal sig = new Signal();
    ifft(sig);
    return(sig);
  }

// -----------------------------------------------------


  // Perfroms FFT shift operation on a signal
  void fftShift(Signal sig_dest) {
    int  i, len1, len2;
    
    len1 = realVal.length / 2;
    len2 = realVal.length - len1;
    for(i=0; i<len1; i++) {
      sig_dest.realVal[i+len2] = realVal[i];
      sig_dest.imagVal[i+len2] = imagVal[i];
    }
    for(i=0; i<len2; i++) {
      sig_dest.realVal[i] = realVal[i+len1];
      sig_dest.imagVal[i] = imagVal[i+len1];
    }
  }

  // Perfroms FFT shift operation on a signal (returns)
  Signal fftShift() {
    Signal sig;
   
    sig  = new Signal(realVal.length);
    fftShift(sig);
    return(sig);
  }
} // End of class Signal

// Sketches the output of this program
void modify() {
   float      k;
   int        i, j, m;
   Dim_flt    pltPnts[];
   
  // Re-sketch only after Window is closed
  if(stateWindow != 0) {
    if(mousePressed) {
      stateWindow = 0;
      hoverIdOld = 50;
      hoverId = 0;
    }
    else {
      hoverIdOld = 0;
      hoverId = 0;
      clickId = 0;
    }
  }
  // -- Click Controls --
  switch(clickId) {
    // New Window cases
    case 1: stateWindow = 1; break;
    case 2: stateWindow = 2; break;
    case 3: exit(); break;
    // Change Arrow state
    case 11: stateArrow = (stateArrow + 1) & 1;
    if(msX < 0.5*width) {
      if(stateArrow == 1) sigRHS = sigLHS.fftShift().fft().fftShift();
      else sigRHS = sigLHS.fftShift().ifft().fftShift();
      sigRHS.abs(sigRHSabs);
    }
    else {
      if(stateArrow == 1) sigLHS = sigRHS.fftShift().ifft().fftShift();
      else sigLHS = sigRHS.fftShift().fft().fftShift();
      sigLHS.abs(sigLHSabs);
    }
    break;
    // Change Buttons state
    case 21: if(stateButtonsLeft == 3) stateButtonsLeft = 5; break;
    case 22: if(stateButtonsLeft == 5) stateButtonsLeft = (msX < 0.24*width)? 6 : 3; break;
    case 23: if(stateButtonsLeft == 6) stateButtonsLeft = 5; break;
    case 31: if(stateButtonsRight == 3) stateButtonsRight = 5; break;
    case 32: if(stateButtonsRight == 5) stateButtonsRight = (msX < 0.76*width)? 6 : 3; break;
    case 33: if(stateButtonsRight == 6) stateButtonsRight = 5; break;
    // Set Default Signal
    case -41:
      if((stateButtonsLeft & 4) > 0) sigLHS.realVal = DefaultSignal.setSignal(stateDefSig);
      else sigLHS.imagVal = DefaultSignal.setSignal(stateDefSig);
      stateDefSig = (stateDefSig + 1) % stateDefSigNum;
      findFFT(0);
      break;
    case -42:
      if((stateButtonsLeft & 2) > 0) sigLHS.imagVal = DefaultSignal.setSignal(stateDefSig);
      else sigLHS.setAbs(DefaultSignal.setSignal(stateDefSig));
      stateDefSig = (stateDefSig + 1) % stateDefSigNum;
      findFFT(1);
      break;
    case -43:
      if((stateButtonsLeft & 4) > 0) sigRHS.realVal = DefaultSignal.setSignal(stateDefSig);
      else sigRHS.imagVal = DefaultSignal.setSignal(stateDefSig);
      stateDefSig = (stateDefSig + 1) % stateDefSigNum;
      findFFT(2);
      break;
    case -44:
      if((stateButtonsLeft & 2) > 0) sigRHS.imagVal = DefaultSignal.setSignal(stateDefSig);
      else sigRHS.setAbs(DefaultSignal.setSignal(stateDefSig));
      stateDefSig = (stateDefSig + 1) % stateDefSigNum;
      findFFT(3);
      break;
    // Change Plot States
    case 41:
    case 42:
    case 43:
    case 44:
      // Find the Plot Index
      i = clickId - 41;
      pltPnts = plots[i].plotPointsX(msXold, msYold, msX, msY);
      for(j=0; j<pltPnts.length; j++) {
        if(pltPnts[j] == null) continue;
        m = (int)(((pltPnts[j].x - plots[i].limTopLeft.x) / (plots[i].limBottomRight.x - plots[i].limTopLeft.x)) * plotPoints);
        m = (m > plotMaxIndex)? plotMaxIndex : m;
        // Change signal values as per Plot Index
        switch(i) {
          case 0:
            if((stateButtonsLeft & 4) > 0) sigLHS.realVal[m] = pltPnts[j].y;
            else sigLHS.imagVal[m] = pltPnts[j].y;
            sigLHSabs.realVal[m] = sqrt(sigLHS.realVal[m]*sigLHS.realVal[m] + sigLHS.imagVal[m]*sigLHS.imagVal[m]);
            break;
          case 1:
            if((stateButtonsLeft & 2) > 0) sigLHS.imagVal[m] = pltPnts[j].y;
            else {
              if(pltPnts[j].y < 0) pltPnts[j].y = 0;
              if(sigLHSabs.realVal[m] > 0) k = pltPnts[j].y / sigLHSabs.realVal[m];
              else k = 1.0 / sqrt(2.0);
              sigLHS.realVal[m] = sigLHS.realVal[m] * k;
              sigLHS.imagVal[m] = sigLHS.imagVal[m] * k;
            }
            sigLHSabs.realVal[m] = sqrt(sigLHS.realVal[m]*sigLHS.realVal[m] + sigLHS.imagVal[m]*sigLHS.imagVal[m]);
            break;
          case 2:
            if((stateButtonsRight & 4) > 0) sigRHS.realVal[m] = pltPnts[j].y;
            else sigRHS.imagVal[m] = pltPnts[j].y;
            sigRHSabs.realVal[m] = sqrt(sigRHS.realVal[m]*sigRHS.realVal[m] + sigRHS.imagVal[m]*sigRHS.imagVal[m]);
            break;
          case 3:
            if((stateButtonsRight & 2) > 0) sigRHS.imagVal[m] = pltPnts[j].y;
            else {
              if(pltPnts[j].y < 0) pltPnts[j].y = 0;
              if(sigRHSabs.realVal[m] > 0) k = pltPnts[j].y / sigRHSabs.realVal[m];
              else k = 1.0 / sqrt(2.0);
              sigRHS.realVal[m] = sigRHS.realVal[m] * k;
              sigRHS.imagVal[m] = sigRHS.imagVal[m] * k;
            }
            sigRHSabs.realVal[m] = sqrt(sigRHS.realVal[m]*sigRHS.realVal[m] + sigRHS.imagVal[m]*sigRHS.imagVal[m]);
        }
      }
      // Refind FFT / IFFT as per requirement
      findFFT(i);
  }
}

void findFFT(int plotNum) {
  switch(plotNum) {
    case 0:
    case 1:
      if(stateArrow == 1) sigRHS = sigLHS.fftShift().fft().fftShift();
      else sigRHS = sigLHS.fftShift().ifft().fftShift();
      sigRHS.abs(sigRHSabs);
      break;
    case 2:
    case 3:
      if(stateArrow == 1) sigLHS = sigRHS.fftShift().ifft().fftShift();
      else sigLHS = sigRHS.fftShift().fft().fftShift();
      sigLHS.abs(sigLHSabs);
  }
}


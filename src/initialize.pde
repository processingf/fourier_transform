/*
  initialize.pde, Part of Fourier Transform Demo
  Copyright (c) 2012, Subhajit Sahu. All rights reserved.
  
  This file is part of Fourier Transform Demo.

  Fourier Transform Demo is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Fourier Transform Demo is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/

void initialize()
{
  /*
      Initializes this program
   */
   
  // -- Load all Data required --
  fntHeading = loadFont("Algerian-30.vlw");
  fntAuthor = loadFont("AgencyFB-Reg-20.vlw");
  fntButton = loadFont("BerlinSansFBDemi-Bold-20.vlw");
  bckImg = loadImage("fourier-transform-demo-main-screen.png");
  
  // -- Initialize Variables --
  msX = 0;
  msY = 0;
  msXold = 0;
  msYold = 0;
  hoverIdOld = 0;
  hoverId = 50;
  clickId = 0;
  stateArrow = 1;
  stateButtonsLeft = 6;
  stateButtonsRight = 6;
  
  // -- Initialize Signals --
  plotPoints = 256;
  plotMaxIndex = plotPoints - 1;
  plotTstart = -0.5;
  plotTstop = 0.5;
  plotTrange = plotTstop - plotTstart;
  plotTstep = plotTrange / plotMaxIndex;
  plotFstart = -(plotPoints / (2.0*plotTrange));
  plotFstep = 1.0/plotTrange;
  stateDefSigNum = 4;
  stateDefSig = 2;
  sigLHS = new Signal(DefaultSignal.setSignal(stateDefSig));
  stateDefSig = (stateDefSig + 1) % stateDefSigNum;
  sigRHS = sigLHS.fft().fftShift();
  sigLHSabs = sigLHS.abs();
  sigRHSabs = sigRHS.abs();
  
  // -- Initialize Plots --
  plots = new Plot[4];
  plots[0] = new Plot(0.02*width, 0.08*height, 0.44*width, 0.40*height);
  plots[1] = new Plot(0.02*width, 0.52*height, 0.44*width, 0.40*height);
  plots[2] = new Plot(0.54*width, 0.08*height, 0.44*width, 0.40*height);
  plots[3] = new Plot(0.54*width, 0.52*height, 0.44*width, 0.40*height);
  
  // -- Draw the Background, Scale it --
  image(bckImg, 0, 0, width, height);
  bckImg = get();
}



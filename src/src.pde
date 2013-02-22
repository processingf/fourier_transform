/*
  Fourier Transform Demo, A Real-time Fourier Transform demonstration program
  Copyright (c) 2012, Subhajit Sahu. All rights reserved.
  
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Future work: Add more Default Signals, 
//              Implement Dynamic-UI, ...


// -- Global Variables --
static PImage   bckImg;
static Signal   sigLHS, sigRHS, sigLHSabs, sigRHSabs;
static PFont    fntHeading, fntAuthor, fntButton;
static int      msX, msY, msXold, msYold;
static int      hoverIdOld, hoverId, clickId;
static float    plotTstart, plotFstart, plotTstep, plotFstep, plotTstop, plotTrange;
static Plot     plots[];
static int      plotPoints, plotMaxIndex;
static int      stateArrow, stateButtonsLeft, stateButtonsRight;
static int      stateDefSigNum, stateDefSig;
static int      stateWindow;
static int      i;

void setup()
{
  // -- Set Window Resolution, Quality --
  size(screen.width, screen.height);
  smooth();
  
  // -- Initialize --
  initialize();
  
  // -- No Looping, Save CPU cycles --
  noLoop();
  redraw();
}

void mouseMoved()
{
  redraw();
}

void mousePressed()
{
  redraw();
}

void mouseDragged()
{
  redraw();
}

void draw()
{
  input();
  if(clickId != 0 || stateWindow != 0) modify();
  if(hoverIdOld != hoverId) sketch();
  else if(clickId != 0) sketch();
  clickId = 0;
}



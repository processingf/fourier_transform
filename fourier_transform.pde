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

void setup() {
  // -- Set Window Resolution, Quality --
  size(screen.width, screen.height);
  smooth();
  
  // -- Initialize --
  initialize();
  
  // -- No Looping, Save CPU cycles --
  noLoop();
  redraw();
}

void mouseMoved() {
  redraw();
}

void mousePressed() {
  redraw();
}

void mouseDragged() {
  redraw();
}

void draw() {
  input();
  if(clickId != 0 || stateWindow != 0) modify();
  if(hoverIdOld != hoverId) sketch();
  else if(clickId != 0) sketch();
  clickId = 0;
}

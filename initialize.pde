/* @pjs preload="data/main-screen.png"; */
/* @pjs font="data/BradleyHandITC-18.ttf"; */
/* @pjs font="data/HarlowSolid-32.ttf"; */

// Initializes this program
void initialize() {
  // -- Load all Data required --
  fntHeading = loadFont("data/Algerian-30.vlw");
  fntAuthor = loadFont("data/AgencyFB-Reg-20.vlw");
  fntButton = loadFont("data/BerlinSansFBDemi-Bold-20.vlw");
  bckImg = loadImage("data/main-screen.png");
  
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

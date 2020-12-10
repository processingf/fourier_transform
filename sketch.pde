// Sketches the output of this program
void sketch() {
  PImage img;
   
  // -- Draw the Background --
  image(bckImg, 0, 0);
  
  // -- Draw state Buttons --
  // Graphic: Mid-Arrow
  stroke(160, 220, 180, 180);
  strokeWeight(0.005*width);
  line(0.47*width, 0.5*height, 0.53*width, 0.5*height);
  if(stateArrow == 0) {
    line(0.47*width, 0.5*height, 0.48*width, 0.49*height);
    line(0.47*width, 0.5*height, 0.48*width, 0.51*height);
  }
  else {
    line(0.53*width, 0.5*height, 0.52*width, 0.49*height);
    line(0.53*width, 0.5*height, 0.52*width, 0.51*height);
  }
  // Graphic: Left & Right Buttons
  if((stateButtonsLeft > 0) || (stateButtonsRight > 0)) {
    strokeCap(ROUND);
    strokeJoin(ROUND);
    stroke(100, 100, 200, 200);
    strokeWeight(0.010*width);
    textAlign(CENTER);
    textFont(fntButton, 0.01405*width );
    if((stateButtonsLeft & 4) > 0)  {fill(200, 100, 100); line(0.135*width, 0.95*height, 0.145*width, 0.95*height); }
    else                            {fill(0, 0, 0, 100); }
    text("real", 0.14*width, 0.985*height);
    if((stateButtonsLeft & 2) > 0)  {fill(200, 100, 100); line(0.235*width, 0.95*height, 0.245*width, 0.95*height); }
    else                            {fill(0, 0, 0, 100); }
    text("imaginary", 0.24*width, 0.985*height);
    if((stateButtonsLeft & 1) > 0)  {fill(200, 100, 100); line(0.335*width, 0.95*height, 0.345*width, 0.95*height); }
    else                            {fill(0, 0, 0, 100); }
    text("absolute", 0.34*width, 0.985*height);
    if((stateButtonsRight & 4) > 0) {fill(200, 100, 100); line(0.655*width, 0.95*height, 0.665*width, 0.95*height); }
    else                            {fill(0, 0, 0, 100); }
    text("real", 0.66*width, 0.985*height);
    if((stateButtonsRight & 2) > 0) {fill(200, 100, 100); line(0.755*width, 0.95*height, 0.765*width, 0.95*height); }
    else                            {fill(0, 0, 0, 100); }
    text("imaginary", 0.76*width, 0.985*height);
    if((stateButtonsRight & 1) > 0) {fill(200, 100, 100); line(0.855*width, 0.95*height, 0.865*width, 0.95*height); }
    else                            {fill(0, 0, 0, 100); }
    text("absolute", 0.86*width, 0.985*height);
  }
  
  // -- Draw the buttons as per hover state
  if(hoverId != 0) {
    i = hoverId / 10;
    switch(i) {
      case 0:
        // Graphic: Power buttons
        strokeWeight(0.002*width);
        stroke(180, 180, 180, 50);
        fill(0, 0, 0, 50);
        ellipse((0.44 + 0.03*hoverId)*width, 0.03*height, 0.02*width, 0.034*height);
        break;
      case 1:
        // Graphic: Mid-Arrow
        stroke(230, 200, 180, 200);
        strokeWeight(0.005*width);
        line(0.47*width, 0.5*height, 0.53*width, 0.5*height);
        if(stateArrow == 0) {line(0.47*width, 0.5*height, 0.48*width, 0.49*height); line(0.47*width, 0.5*height, 0.48*width, 0.51*height); }
        else                {line(0.53*width, 0.5*height, 0.52*width, 0.49*height); line(0.53*width, 0.5*height, 0.52*width, 0.51*height); }
        break;
      case 2:
      case 3:
        // Graphic: Left & Right Buttons
        strokeCap(ROUND);
        strokeJoin(ROUND);
        stroke(220, 220, 220, 160);
        strokeWeight(0.015*width);
        switch(hoverId) {
          case 21: line(0.135*width, 0.95*height, 0.145*width, 0.95*height); break;
          case 22: line(0.235*width, 0.95*height, 0.245*width, 0.95*height); break;
          case 23: line(0.335*width, 0.95*height, 0.345*width, 0.95*height); break;
          case 31: line(0.655*width, 0.95*height, 0.665*width, 0.95*height); break;
          case 32: line(0.755*width, 0.95*height, 0.765*width, 0.95*height); break;
          case 33: line(0.855*width, 0.95*height, 0.865*width, 0.95*height); break;
        }
        break;
      case 4:
        // Set New Plot looks
        Plot  tempPlot, tempPlotX;
        tempPlot = plots[hoverId - 41];
        tempPlotX = new Plot(tempPlot);
        tempPlot.backClr = color(0, 0, 0, 200);
        tempPlot.borderClr = color(0, 0, 0, 50);
        tempPlot.lineClr = color(255, 255, 255);
        tempPlot.lineWidth = 1;
        tempPlot.autoScaleFactor.x = 0.0;    // Dont Auto-scale when a plot is being hovered
        // -- Draw the plots --
        sketchPlots();
        // Reset back old looks
        plots[hoverId - 41] = tempPlotX;
        return;
    }
  }
  sketchPlots();
  
  // -- Sketch Window --
  if(stateWindow != 0) {
    switch(stateWindow) {
      case  1: img = loadImage("fourier-transform-demo-help.jpg"); break;
      default: img = loadImage("fourier-transform-demo-info.jpg"); break;
    }
    background(0, 0, 0, 150);
    imageMode(CENTER);
    image(img, 0.5*width, 0.5*height, 0.9*width, 0.9*height);
    img = null;
    imageMode(CORNER);
  }
}

void sketchPlots() {
  float plotStart, plotStep;
  
  // -- Draw the plots --
  if(stateArrow == 1) {plotStart = plotTstart; plotStep = plotTstep;}
  else {plotStart = plotFstart; plotStep = plotFstep;}
  switch(stateButtonsLeft) {
    case 3:
      plots[0].display(plotStart, plotStep, sigLHS.imagVal);
      plots[1].display(plotStart, plotStep, sigLHSabs.realVal);
      break;
    case 5:
      plots[0].display(plotStart, plotStep, sigLHS.realVal);
      plots[1].display(plotStart, plotStep, sigLHSabs.realVal);
      break;
    case 6:
      plots[0].display(plotStart, plotStep, sigLHS.realVal);
      plots[1].display(plotStart, plotStep, sigLHS.imagVal);
      break;
  }
  if(stateArrow != 1) {plotStart = plotTstart; plotStep = plotTstep;}
  else {plotStart = plotFstart; plotStep = plotFstep;}
  switch(stateButtonsRight) {
    case 3:
      plots[2].display(plotStart, plotStep, sigRHS.imagVal);
      plots[3].display(plotStart, plotStep, sigRHSabs.realVal);
      break;
    case 5:
      plots[2].display(plotStart, plotStep, sigRHS.realVal);
      plots[3].display(plotStart, plotStep, sigRHSabs.realVal);
      break;
    case 6:
      plots[2].display(plotStart, plotStep, sigRHS.realVal);
      plots[3].display(plotStart, plotStep, sigRHS.imagVal);
      break;
  }
}

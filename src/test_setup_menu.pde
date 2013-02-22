/*
  test_setup_menu.pde, Part of Fourier Transform Demo
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

void test_setup_menu()
{
  // -- Set Window Resolution, Quality --
  size(1024, 600);
  smooth();
  
  // -- Load all Data required --
  fntHeading = loadFont("Algerian-30.vlw");
  fntAuthor = loadFont("AgencyFB-Reg-20.vlw");
  fntButton = loadFont("BerlinSansFBDemi-Bold-20.vlw");
  bckImg = loadImage("hdw-winter-wallpaper-abstract-art-13.jpg");
  
  // -- Create the Background --
  image(bckImg, 0, 0, width, height);
  textAlign(LEFT);
  textFont(fntHeading, 0.0215*width);
  text("Fourier Transform Demo", 0.02*width, 0.0417*height);
  textAlign(RIGHT);
  textFont(fntAuthor, 0.01365*width);
  text("-by Electronics and Communication Engineering Department,\nNational Institute of Technology, Rourkela", 0.98*width, 0.025*height);
  
  // -- Create Buttons --
  // Graphic: Buttions
  stroke(0, 0, 0, 60);
  strokeWeight(0.015*width);
  strokeJoin(ROUND);
  strokeCap(ROUND);
  line(0.135*width, 0.95*height, 0.145*width, 0.95*height);
  line(0.235*width, 0.95*height, 0.245*width, 0.95*height);
  line(0.335*width, 0.95*height, 0.345*width, 0.95*height);
  line(0.655*width, 0.95*height, 0.665*width, 0.95*height);
  line(0.755*width, 0.95*height, 0.765*width, 0.95*height);
  line(0.855*width, 0.95*height, 0.865*width, 0.95*height);
  // Graphic: Mid-Arrow (Reversible)
  stroke(160, 220, 180, 180);
  strokeWeight(0.005*width);
  line(0.47*width, 0.5*height, 0.53*width, 0.5*height);
  line(0.47*width, 0.5*height, 0.48*width, 0.49*height);
  line(0.47*width, 0.5*height, 0.48*width, 0.51*height);
  line(0.53*width, 0.5*height, 0.52*width, 0.49*height);
  line(0.53*width, 0.5*height, 0.52*width, 0.51*height);
  // Graphic: Power Buttons
  textAlign(CENTER);
  textFont(fntAuthor, 0.01365*width );
  strokeWeight(0.002*width);
  stroke(150, 150, 255, 200);
  fill(200, 200, 255, 200);
  ellipse(0.47*width, 0.03*height, 0.02*width, 0.034*height);
  ellipse(0.50*width, 0.03*height, 0.02*width, 0.034*height);
  stroke(255, 50, 50, 200);
  fill(255, 100, 100, 200);
  ellipse(0.53*width, 0.03*height, 0.02*width, 0.034*height);
  // Text: Buttons
  fill(0, 0, 0, 120);
  textAlign(CENTER);
  textFont(fntButton, 0.01365*width );
  text("real", 0.14*width, 0.985*height);
  text("imaginary", 0.24*width, 0.985*height);
  text("absolute", 0.34*width, 0.985*height);
  text("real", 0.66*width, 0.985*height);
  text("imaginary", 0.76*width, 0.985*height);
  text("absolute", 0.86*width, 0.985*height);
  // Text: Mid-Arrow (Reversible)
  fill(255, 255, 255, 220);
  text("Fourier", 0.5*width, 0.48*height);
  text("transform", 0.5*width, 0.54*height);
  // Text: Power Buttons
  text("?", 0.471*width, 0.038*height);
  text("i", 0.500*width, 0.038*height);
  text("X", 0.530*width, 0.038*height);
  save("fourier-transform-demo-main-screen.png");
  
  // -- Create 4 plots --
//  stroke(0, 0, 0);
//  strokeWeight(1);
//  fill(255, 255, 255, 120);
//  rect(0.02*width, 0.08*height, 0.44*width, 0.40*height);
//  rect(0.02*width, 0.52*height, 0.44*width, 0.40*height);
//  rect(0.54*width, 0.08*height, 0.44*width, 0.40*height);
//  rect(0.54*width, 0.52*height, 0.44*width, 0.40*height);
}


/*
  input.pde, Part of Fourier Transform Demo
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

void input()
{
  /*
      Determines the input to this program (by mouse)
   */
   
  int  mX = mouseX, mY = mouseY;
  
  msXold = msX;
  msYold = msY;
  msX = mX;
  msY = mY;
  hoverIdOld = hoverId;
  if((mX >= 0.455*width) && (mX <= 0.545*width) && (mY >= 0.005*height) && (mY <= 0.055*height))
    hoverId = 1 + (int)((((float)mX)/width - 0.455)/0.03);
  else if((mX >= 0.47*width) && (mX <= 0.53*width) && (mY >= 0.49*height) && (mY <= 0.51*height))
    hoverId = 11;
  else if(mY > 0.93*height)
    {
      if(mX < 0.5*width)
      {
        if((mX > 0.115*width) && (mX < 0.165*width)) hoverId = 21;
        else if((mX > 0.215*width) && (mX < 0.265*width)) hoverId = 22;
        else if((mX > 0.315*width) && (mX < 0.365*width)) hoverId = 23;
        else hoverId = 0;
      }
      else
      {
        if((mX > 0.635*width) && (mX < 0.685*width)) hoverId = 31;
        else if((mX > 0.735*width) && (mX < 0.785*width)) hoverId = 32;
        else if((mX > 0.835*width) && (mX < 0.885*width)) hoverId = 33;
        else hoverId = 0;
      }
    }
  else
  {
    if((mX >= 0.02*width)  && (mY >= 0.08*height) && (mX <= 0.46*width) && (mY <= 0.48*height)) hoverId = 41;
    else if((mX >= 0.02*width)  && (mY >= 0.52*height) && (mX <= 0.46*width) && (mY <= 0.92*height)) hoverId = 42;
    else if((mX >= 0.54*width)  && (mY >= 0.08*height) && (mX <= 0.98*width) && (mY <= 0.48*height)) hoverId = 43;
    else if((mX >= 0.54*width)  && (mY >= 0.52*height) && (mX <= 0.98*width) && (mY <= 0.92*height)) hoverId = 44;
    else hoverId = 0;
  }
  if(mousePressed)
  {
    if(mouseButton == LEFT) clickId = hoverId;
    else clickId = -hoverId;
  }
}


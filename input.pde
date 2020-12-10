// Determines the input to this program (by mouse)
void input() {
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
  else if(mY > 0.93*height) {
      if(mX < 0.5*width) {
        if((mX > 0.115*width) && (mX < 0.165*width)) hoverId = 21;
        else if((mX > 0.215*width) && (mX < 0.265*width)) hoverId = 22;
        else if((mX > 0.315*width) && (mX < 0.365*width)) hoverId = 23;
        else hoverId = 0;
      }
      else {
        if((mX > 0.635*width) && (mX < 0.685*width)) hoverId = 31;
        else if((mX > 0.735*width) && (mX < 0.785*width)) hoverId = 32;
        else if((mX > 0.835*width) && (mX < 0.885*width)) hoverId = 33;
        else hoverId = 0;
      }
    }
  else {
    if((mX >= 0.02*width)  && (mY >= 0.08*height) && (mX <= 0.46*width) && (mY <= 0.48*height)) hoverId = 41;
    else if((mX >= 0.02*width)  && (mY >= 0.52*height) && (mX <= 0.46*width) && (mY <= 0.92*height)) hoverId = 42;
    else if((mX >= 0.54*width)  && (mY >= 0.08*height) && (mX <= 0.98*width) && (mY <= 0.48*height)) hoverId = 43;
    else if((mX >= 0.54*width)  && (mY >= 0.52*height) && (mX <= 0.98*width) && (mY <= 0.92*height)) hoverId = 44;
    else hoverId = 0;
  }
  if(mousePressed) {
    if(mouseButton == LEFT) clickId = hoverId;
    else clickId = -hoverId;
  }
}

/*
  DefaultSignal.pde, Part of Fourier Transform Demo
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

static class DefaultSignal
{
  // c
  public static float[] constant(float c, float tStart, float tStop, float Fs)
  {
    int      i, N;
    float    Ts, y[];
    
    Ts = 1 / Fs;
    N = (int)((tStop - tStart) * Fs);
    y = new float[N];
    for(i = 0; i < N; i++)
      y[i] = c;
    return(y);
  }
  
  // A*sin(b*t + c)
  public static float[] sine(float A, float b, float c, float tStart, float tStop, float Fs)
  {
    int      i, N;
    float    Ts, y[];
    
    Ts = 1 / Fs;
    N = (int)((tStop - tStart) * Fs);
    y = new float[N];
    for(i = 0; i < N; i++)
      y[i] = A * sin(b*(tStart + Ts*i) + c);
    return(y);
  }  
  
  // A*cos(b*t + c)
  public static float[] cosine(float A, float b, float c, float tStart, float tStop, float Fs)
  {
    int      i, N;
    float    Ts, y[];
    
    Ts = 1 / Fs;
    N = (int)((tStop - tStart) * Fs);
    y = new float[N];
    for(i = 0; i < N; i++)
      y[i] = A * cos(b*(tStart + Ts*i) + c);
    return(y);
  }  
  
  // A*rect(b*t + c)
  public static float[] rect(float A, float b, float c, float tStart, float tStop, float Fs)
  {
    int      i, N;
    float    t, Ts, y[];
    
    Ts = 1 / Fs;
    N = (int)((tStop - tStart) * Fs);
    y = new float[N];
    for(i = 0; i < N; i++)
    {
      t = b*(tStart + Ts*i) + c;
      y[i] = ((t >= -0.5) && (t <= 0.5))? A : 0;
    }
    return(y);
  }
  
  public static float[] signal(int sig, float A, float b, float c, float tStart, float tStop, float Fs)
  {
    switch(sig)
    {
      case 0 :  return(constant(c, tStart, tStop, Fs));
      case 1 :  return(sine(A, b, c, tStart, tStop, Fs));
      case 2 :  return(cosine(A, b, c, tStart, tStop, Fs));
      default:  return(DefaultSignal.rect(A, b, c, tStart, tStop, Fs));
    }
  }
  
  public static float[] setSignal(int sig)
  {
    switch(sig)
    {
      case 0 :  return(constant(0, plotTstart, plotTstop, plotPoints));
      case 1 :  return(sine(1, 2*PI*10, 0, plotTstart, plotTstop, plotPoints));
      case 2 :  return(cosine(1, 2*PI*10, 0, plotTstart, plotTstop, plotPoints));
      default:  return(DefaultSignal.rect(1, 20, 0, plotTstart, plotTstop, plotPoints));
    }
  }
}


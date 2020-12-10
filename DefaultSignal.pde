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


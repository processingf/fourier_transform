class Plot
{
  /*
	Graphical Plotter
   */

  // Properties
  public color  	backClr, borderClr, lineClr, textClr;
  public Dim_int	position;
  private Dim_int       extent;
  public Dim_flt        autoScaleFactor;
  public int		borderWidth, lineWidth;
  public Dim_flt	limTopLeft, limBottomRight;
  public boolean        showLimits;
  private int		type;
  
  // Graphics Buffer
  PGraphics            gBuff;

  public void setExtent(float xSz, float ySz)
  {
    extent = new Dim_int((int)xSz, (int)ySz);
    gBuff = createGraphics(extent.x, extent.y, JAVA2D);
  }

  public void setDefaultSettings()
  {
    /*
	Set default Plot settings
     */

    // Set Default colours
    backClr = color(0, 0, 0, 150);
    borderClr = color(50, 50, 50, 50);
    lineClr = color(255, 255, 0);
    textClr = color(255, 255, 255);

    // Set appropriate sizes
    position = new Dim_int(0, 0);
    setExtent(100, 100);
    borderWidth = 5;
    lineWidth = 2;
    limTopLeft = new Dim_flt(0, 1.0, 0);           // Not Applicable when Auto-Scale is used
    limBottomRight = new Dim_flt(1.0, -1.0, 0);    // Not Applicable when Auto-Scale is used
    autoScaleFactor = new Dim_flt(1.0, 0.8, 1.0);  // set autoScaleFactor.x to '0' for no Auto-Scale
    showLimits = true;

    // Set the default Plot type
    type = 0;
  }

  public Plot()
  {
    /*
	Initialize a Plot (with no specific settings)
     */

    setDefaultSettings();
  }

  public Plot(Plot x)
  {
    /*
	Copy a plot (from the given plot)
     */

    backClr = color(red(x.backClr), green(x.backClr), blue(x.backClr), alpha(x.backClr));
    borderClr = color(red(x.borderClr), green(x.borderClr), blue(x.borderClr), alpha(x.borderClr));
    lineClr = color(red(x.lineClr), green(x.lineClr), blue(x.lineClr), alpha(x.lineClr));
    textClr = color(red(x.textClr), green(x.textClr), blue(x.textClr), alpha(x.textClr));

    // Copy plot sizes
    position = new Dim_int(x.position.x, x.position.y);
    setExtent(x.extent.x, x.extent.y);
    borderWidth = x.borderWidth;
    lineWidth = x.lineWidth;
    limTopLeft = new Dim_flt(x.limTopLeft.x, x.limTopLeft.y, x.limTopLeft.z);
    limBottomRight = new Dim_flt(x.limBottomRight.x, x.limBottomRight.y, x.limBottomRight.z);
    autoScaleFactor = new Dim_flt(x.autoScaleFactor.x, x.autoScaleFactor.y, x.autoScaleFactor.z);
    showLimits = x.showLimits;

    // Copy Plot type
    type = x.type;
  }

  public Plot(float x_pos, float y_pos)
  {
    /*
	Initialize a Plot (with position setting)
     */

    setDefaultSettings();
    position.x = (int)x_pos;
    position.y = (int)y_pos;
  }

  public Plot(float x_pos, float y_pos, float x_size, float y_size)
  {
    /*
	Initialize a Plot (with position and size settings)
     */

    setDefaultSettings();
    position.x = (int)x_pos;
    position.y = (int)y_pos;
    setExtent((int)x_size, (int)y_size);
  }

  public void setPlotType(int type)
  {
    /*
	Set Plot type (0 = default)
     */

    if (type >= 0 && type <= 0)
      this.type = type;
  }

  private void refresh2D(float ptX[], float ptY[])
  {
    /*
	Refreshes the 2D-Plot
     */

    int		i, len, x, y;
    float	scaleX, scaleY, shiftX, shiftY;
    float       minX, maxX, minY, maxY;

    // Auto-Scale, if necessary
    if((autoScaleFactor.x != 0) && (autoScaleFactor.y != 0) && (autoScaleFactor.z != 0))
    {
      minX = min(ptX);
      maxX = max(ptX);
      minY = min(ptY);
      maxY = max(ptY);
      scaleX = 1/autoScaleFactor.x;
      scaleY = 1/autoScaleFactor.y;
      if(maxX > minX)
      {
        limTopLeft.x = 0.5*(maxX*(1 - scaleX) + minX*(1 + scaleX));
        limBottomRight.x = 0.5*(maxX*(1 + scaleX) + minX*(1 - scaleX));
      }
      else
      {
        limTopLeft.x = maxX - 1;
        limBottomRight.x = maxX + 1;
      }
      if(maxY > minY)
      {
        limTopLeft.y = 0.5*(maxY*(1 + scaleY) + minY*(1 - scaleY));
        limBottomRight.y = 0.5*(maxY*(1 - scaleY) + minY*(1 + scaleY));
      }
      else
      {
        limTopLeft.y = maxY + 1;
        limBottomRight.y = maxY - 1;
      }
    }

    // Calculate the scale-factor and shift-factor
    scaleX = (extent.x - 2*borderWidth) / (limBottomRight.x - limTopLeft.x);
    scaleY = (extent.y - 2*borderWidth) / (limBottomRight.y - limTopLeft.y);
    shiftX = borderWidth - limTopLeft.x*scaleX;
    shiftY = borderWidth - limTopLeft.y*scaleY;

    // Draw the Background rectangle
    rectMode(CORNER);
    strokeWeight(0);
    fill(backClr);
    rect(position.x, position.y, extent.x, extent.y);

    // Calculate all pixel positions and draw
    len = ptX.length;
    gBuff.beginDraw();
    gBuff.smooth();
    gBuff.background(0,0,0,0);
    gBuff.noFill();
    gBuff.stroke(lineClr);
    gBuff.strokeWeight(lineWidth);
    gBuff.beginShape();
    for (i=0; i<len; i++)
    {
      x = (int)(ptX[i]*scaleX + shiftX);
      y = (int)(ptY[i]*scaleY + shiftY);
      gBuff.vertex(x, y);
    }
    gBuff.endShape();
    
    // Draw the endpoint axis values, if required
    if(showLimits)
    {
      float   fnt2;
      
      fnt2 = 0.012*width;
      gBuff.fill(textClr);
      gBuff.textFont(fntAuthor, fnt2);
      gBuff.textAlign(LEFT);
      gBuff.text("y-top:"+limTopLeft.y, borderWidth, fnt2 + borderWidth);
      gBuff.text("x-left:"+limTopLeft.x, borderWidth, extent.y - borderWidth);
      gBuff.textAlign(RIGHT);
      gBuff.text("x-right:"+limBottomRight.x, extent.x-borderWidth, fnt2 + borderWidth);
      gBuff.text("y-bottom:"+limBottomRight.y, extent.x-borderWidth, extent.y - borderWidth);
    }
    
    // Put the buffer on the screen
    gBuff.endDraw();
    image(gBuff, position.x, position.y);
    
    // Draw the Plot border
    noFill();
    stroke(borderClr);
    strokeWeight(borderWidth);
    rect(position.x + 0.5*borderWidth, position.y + 0.5*borderWidth, extent.x - borderWidth, extent.y - borderWidth);
  }

  public void display(float ptX[], float ptY[])
  {
    /*
	Display the plot
     */

    refresh2D(ptX, ptY);
  }

  public void display(float x_start, float x_step, float ptY[])
  {
    /*
	Display the plot
     */

    float  x;
    float  ptX[];
    int     i, len;

    len = ptY.length;
    ptX = new float[len];
    for (i=0, x=x_start; i<len; i++, x+=x_step)
      ptX[i] = x;
    refresh2D(ptX, ptY);
  }
  
  public Dim_flt plotPoint(float x, float y)
  {
    float    scaleX, scaleY;
    float    shiftX, shiftY;
    Dim_flt  pnt;

    // Calculate the scale-factor and shift-factor
    scaleX = (extent.x - 2*borderWidth) / (limBottomRight.x - limTopLeft.x);
    scaleY = (extent.y - 2*borderWidth) / (limBottomRight.y - limTopLeft.y);
    shiftX = borderWidth - limTopLeft.x*scaleX;
    shiftY = borderWidth - limTopLeft.y*scaleY;
    
    // Calculate the Point
    pnt = new Dim_flt((x - position.x - shiftX) / scaleX, (y - position.y - shiftY) / scaleY);
    
    // Check if the point is inside limits
    if((pnt.x < limTopLeft.x) || (pnt.x > limBottomRight.x) || (pnt.y < limBottomRight.y) || (pnt.y > limTopLeft.y)) pnt = null;
    return(pnt);
  }
  
    public Dim_flt[] plotPointsX(float xStart, float yStart, float xStop, float yStop)
    {
      int       i, xD;
      float     m;
      Dim_flt   pnts[];
      
      if(xStop < xStart)
      {
        m = xStart;
        xStart = xStop;
        xStop = m;
        m = yStart;
        yStart = yStop;
        yStop = m;
      }
      xD = floor(xStop - xStart);
      if(xD == 0)
      {
        pnts = new Dim_flt[1];
        pnts[0] = plotPoint(xStop, yStop);
        return(pnts);
      }
      m = (yStop - yStart) / xD;
      pnts = new Dim_flt[xD + 1];
      for(i=0; i<=xD; i++)
        pnts[i] = plotPoint(xStart + i, yStart + m*i);
      return(pnts);
    }
} // End of class Plot




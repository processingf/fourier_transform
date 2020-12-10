class Dim_int
{
  /*
	Dimension: Integer
   */

  public int		x, y, z;

  Dim_int()
  {
    x = 0;
    y = 0;
    z = 0;
  }

  Dim_int(int x)
  {
    this.x = x;
    y = 0;
    z = 0;
  }

  Dim_int(int x, int y)
  {
    this.x = x;
    this.y = y;
    z = 0;
  }

  Dim_int(int x, int y, int z)
  {
    this.x = x;
    this.y = y;
    this.z = z;
  }
} 

class Dim_flt
{
  /*
	Dimension: float
   */

  public float	x, y, z;

  Dim_flt()
  {
    x = 0.0;
    y = 0.0;
    z = 0.0;
  }

  Dim_flt(float x)
  {
    this.x = x;
    y = 0.0;
    z = 0.0;
  }

  Dim_flt(float x, float y)
  {
    this.x = x;
    this.y = y;
    z = 0.0;
  }

  Dim_flt(float x, float y, float z)
  {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}


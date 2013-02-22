/*
  Dimension.pde, Part of Fourier Transform Demo
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


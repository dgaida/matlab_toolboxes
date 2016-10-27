/**
 * MATLAB Toolbox for Simulation, Control & Optimization of Biogas Plants
 * Copyright (C) 2014  Daniel Gaida
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/**
* This file defines min and max method of the math class.
* 
* TODOs:
* - 
* 
* Apart from that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using toolbox;

/// <summary>
/// The science namespace collects all classes which have to do with science in general.
/// </summary>
namespace science
{
  /// <summary>
  /// Defines a few methods in the field of math.
  /// </summary>
  public partial class math
  {
        
    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// Returns a double vector containing the min of the components 
    /// of the two vectors
    /// 
    /// throws an exception when length of both vectors is not the same or if the 
    /// vectors are empty
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>double vector: min(v1, v2), componentwise</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static double[] min(double[] v1, double[] v2)
    { 
      if (v1.Length != v2.Length)
        throw new exception( String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length) );

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      double[] min_val= new double[v1.Length];

      for(int icomp= 0; icomp < v1.Length; icomp++)
      {
        min_val[icomp]= Math.Min(v1[icomp], v2[icomp]);
      }

      return min_val;
    }

    /// <summary>
    /// Returns the min value of the vector v.
    /// if the vector is empty, then infinity is returned.
    /// MATLAB would return an empty vector.
    /// </summary>
    /// <param name="v">double vector</param>
    /// <returns>min value of v</returns>
    public static double min(double[] v)
    {
      int index;

      return min(v, out index);
    }
    /// <summary>
    /// Returns the min value of the vector v and the index 
    /// of the min value. if the vector is empty, then infinity is returned and index is 0.
    /// MATLAB would return an empty vector.
    /// 
    /// if there are more than one smallest value then the first appearance is returned
    /// </summary>
    /// <param name="v">double vector</param>
    /// <param name="index">index of the min value inside the given vector, 0-based</param>
    /// <returns>min value of v</returns>
    public static double min(double[] v, out int index)
    {
      double min_value= double.PositiveInfinity;

      index= 0;

      for (int ii= 0; ii < v.Length; ii++)
      {
        if (v[ii] < min_value)
          index= ii;

        min_value= Math.Min(min_value, v[ii]);
      }

      return min_value;
    }

    /// <summary>
    /// Returns a double vector containing the max of the components 
    /// of the two vectors
    /// 
    /// throws an exception when length of both vectors is not the same or if the 
    /// vectors are empty
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>double vector max(v1, v2), componentwise</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static double[] max(double[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      double[] max_val= new double[v1.Length];

      for (int icomp= 0; icomp < v1.Length; icomp++)
      {
        max_val[icomp]= Math.Max(v1[icomp], v2[icomp]);
      }

      return max_val;
    }

    /// <summary>
    /// Returns the max value of the vector v.
    /// if the vector is empty, then minus infinity is returned.
    /// MATLAB would return an empty vector.
    /// </summary>
    /// <param name="v">double vector</param>
    /// <returns>max value of v</returns>
    public static double max(double[] v)
    {
      int index;

      return max(v, out index);
    }
    /// <summary>
    /// Returns the max value of the vector v and the index 
    /// of the max value. if the vector is empty, then minus infinity is returned and index is 0.
    /// MATLAB would return an empty vector.
    /// 
    /// if there are more than one max value, then the first appearance is returned
    /// </summary>
    /// <param name="v">double vector</param>
    /// <param name="index">index of the max value inside the given vector, 0-based</param>
    /// <returns>max value of v</returns>
    public static double max(double[] v, out int index)
    {
      double max_value= double.NegativeInfinity;

      index= 0;

      for (int ii= 0; ii < v.Length; ii++)
      {
        if (v[ii] > max_value)
          index= ii;

        max_value= Math.Max(max_value, v[ii]);
      }

      return max_value;
    }


       
  }
}



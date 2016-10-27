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
* This file defines the math class.
* 
* TODOs:
* - maybe add further methods
* 
* 
* Apart from that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using toolbox;
//using MathWorks.MATLAB.NET.Arrays;

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
        
    // TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    //public static implicit operator double(math x)
    //{
    //  return x;
    //}
    //public static implicit operator math(double x)
    //{
    //  return x;
    //}


    //public static double[] operator+(double[] vec, math scalar)
    /// <summary>
    /// add the given scalar to all components of a double vector vec
    /// pay attention, that vec is changed by this call
    /// </summary>
    /// <param name="vec">double vector</param>
    /// <param name="scalar">double scalar</param>
    /// <returns>vec + scalar</returns>
    public static double[] plus(double[] vec, double scalar)
    {
      for (int iel= 0; iel < vec.Length; iel++)
        vec[iel] += scalar;

      return vec;
    }

    /// <summary>
    /// v1 + v2, v1 is changed by this method
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>v1 + v2</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static double[] plus(double[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      for (int iel = 0; iel < v1.Length; iel++)
        v1[iel] += v2[iel];

      return v1;
    }
    
    /// <summary>
    /// Adds corresponding elements of both double list, values of vals1 are changed
    /// </summary>
    /// <param name="vals1">double list</param>
    /// <param name="vals2">double list</param>
    /// <returns>addition of corresponding components of both lists</returns>
    /// <exception cref="exception">vals1.Count != vals2.Count</exception>
    /// <exception cref="exception">vals1 is empty</exception>
    public static List<double> plus(List<double> vals1, List<double> vals2)
    {
      if (vals1.Count != vals2.Count)
        throw new exception(String.Format(
              "The length of both lists is not the same: {0} != {1}!",
              vals1.Count, vals2.Count));

      if (vals1.Count <= 0)
        throw new exception(String.Format(
              "The length of both lists is <= 0: {0}!", vals1.Count));

      for (int iel = 0; iel < vals1.Count; iel++)
        vals1[iel] += vals2[iel];

      return vals1;
    }

    //public static double[] operator-(double[] vec, math scalar)
    /// <summary>
    /// substract the given scalar from all components of the given double vector vec
    /// pay attention, that vec is changed by this call
    /// </summary>
    /// <param name="vec">double vector</param>
    /// <param name="scalar">double scalar</param>
    /// <returns>vec - scalar</returns>
    public static double[] minus(double[] vec, double scalar)
    {
      for (int iel= 0; iel < vec.Length; iel++)
        vec[iel] -= scalar;

      return vec;
    }

    /// <summary>
    /// v1 - v2, v1 is changed by this method
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>v1 - v2</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static double[] minus(double[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      for (int iel = 0; iel < v1.Length; iel++)
        v1[iel] -= v2[iel];

      return v1;
    }

    /// <summary>
    /// Substracts corresponding elements of both double list, values of vals1 are changed
    /// </summary>
    /// <param name="vals1">double list</param>
    /// <param name="vals2">double list</param>
    /// <returns>subtraction of corresponding components of both lists</returns>
    /// <exception cref="exception">vals1.Count != vals2.Count</exception>
    /// <exception cref="exception">vals1 is empty</exception>
    public static List<double> minus(List<double> vals1, List<double> vals2)
    {
      if (vals1.Count != vals2.Count)
        throw new exception(String.Format(
              "The length of both lists is not the same: {0} != {1}!",
              vals1.Count, vals2.Count));

      if (vals1.Count <= 0)
        throw new exception(String.Format(
              "The length of both lists is <= 0: {0}!", vals1.Count));

      for (int iel = 0; iel < vals1.Count; iel++)
        vals1[iel] -= vals2[iel];

      return vals1;
    }

    /// <summary>
    /// multiplies given double vector vec with the given double scalar.
    /// pay attention, that vec is changed by this call
    /// </summary>
    /// <param name="vec">double vector</param>
    /// <param name="scalar">double scalar</param>
    /// <returns>scalar .* vec</returns>
    public static double[] times(double[] vec, double scalar)
    {
      for (int iel= 0; iel < vec.Length; iel++)
        vec[iel] *= scalar;

      return vec;
    }

    /// <summary>
    /// multiplies given double vector vec with the given double scalar.
    /// pay attention, that vec is changed by this call
    /// </summary>
    /// <param name="scalar">double scalar</param>
    /// <param name="vec">double vector</param>
    /// <returns>scalar .* vec</returns>
    public static double[] times(double scalar, double[] vec)
    {
      return times(vec, scalar);
    }

    
    /// <summary>
    /// multiplies given double matrix mat with the given double scalar.
    /// pay attention, that mat is changed by this call
    /// </summary>
    /// <param name="scalar">double scalar</param>
    /// <param name="mat">double matrix</param>
    /// <returns>scalar .* mat</returns>
    public static double[,] times(double scalar, double[,] mat)
    {
      return times(mat, scalar);
    }
    /// <summary>
    /// multiplies given double matrix mat with the given double scalar.
    /// pay attention, that mat is changed by this call
    /// </summary>
    /// <param name="mat">double matrix</param>
    /// <param name="scalar">double scalar</param>
    /// <returns>scalar .* mat</returns>
    public static double[,] times(double[,] mat, double scalar)
    {
      for (int irow = 0; irow < mat.GetLength(0); irow++)
        for (int icol = 0; icol < mat.GetLength(1); icol++) 
          mat[irow, icol] *= scalar;

      return mat;
    }

    /// <summary>
    /// multiplies two vectors v1 and v2 componentwise, a vector is returned
    /// 
    /// throws an exception when length of both vectors is not the same or if the 
    /// vectors are empty
    /// 
    /// pay attention, that v1 is changed by this call
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>double vector: v1 * v2, componentwise</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static double[] times(double[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      for (int iel = 0; iel < v1.Length; iel++)
        v1[iel] *= v2[iel];

      return v1;
    }

    /// <summary>
    /// Divide each component of given vector by the given scalar
    /// 
    /// Throws an exception if scalar smaller epsilon
    /// 
    /// pay attention, that vec is changed by this call
    /// </summary>
    /// <param name="vec">double vector</param>
    /// <param name="scalar">double scalar</param>
    /// <returns>vec / scalar</returns>
    /// <exception cref="exception">|scalar| &lt; epsilon</exception>
    public static double[] rdivide(double[] vec, double scalar)
    {
      if (Math.Abs(scalar) < double.Epsilon)
        throw new exception(String.Format("May not divide by 0: {0}!", scalar));

      for (int iel= 0; iel < vec.Length; iel++)
        vec[iel] /= scalar;

      return vec;
    }

    /// <summary>
    /// Calculates scalar product of given double vectors v1 and v2
    /// 
    /// throws an exception when length of both vectors is not the same or if the 
    /// vectors are empty
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>scalar product of v1 * v2</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static double mtimes(double[] v1, double[] v2)
    {
      double sum = 0;

      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      for (int iel = 0; iel < v1.Length; iel++)
        sum += v1[iel] * v2[iel];

      return sum;
    }

    /// <summary>
    /// matrix product: mat * vec
    /// </summary>
    /// <param name="mat">double matrix</param>
    /// <param name="v1">double vector</param>
    /// <returns>mat * vec</returns>
    /// <exception cref="exception">v1.Length != mat.GetLength(1)</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static double[] mtimes(double[,] mat, double[] v1)
    {
      if (v1.Length != mat.GetLength(1))
        throw new exception(String.Format(
              "The length of v1 and column size of mat are not the same: {0} != {1}!",
              v1.Length, mat.GetLength(1)));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of v1 is <= 0: {0}!", v1.Length));

      double[] v2= zeros(mat.GetLength(0));

      for (int irow = 0; irow < mat.GetLength(0); irow++)
        for (int icol = 0; icol < mat.GetLength(1); icol++)
          v2[irow] += mat[irow, icol] * v1[icol];

      return v2;
    }



    // TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


    
  }
}



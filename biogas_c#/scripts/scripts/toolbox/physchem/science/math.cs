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
* - improve documentation of tukeybiweight (documentation of matlab function) - OK
* - delete eps
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
  /// Defines a few methods in the field of math. Some methods of MATLAB are reimplemented. 
  /// </summary>
  public partial class math
  {
        
    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                        !!! PUBLIC STATIC FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// epsilon, a very small number, here 10^-10
    /// TODO: delete someday
    /// </summary>
    [Obsolete("use double.Epsilon instead")]
    public static double eps= Math.Pow(10, -10);



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// concat columns of matrix <paramref name="mat"/> to one column vector. The vector
    /// contains the 1st, then the 2nd, ... column of the matrix. 
    /// </summary>
    /// <param name="mat">2dim double matrix</param>
    /// <returns>
    /// column vector with as many rows as the matrix has elements
    /// </returns>
    public static double[] concat(double[,] mat)
    {
      double[] vec = new double[mat.Length];

      // the ADM streams are concatenated row wise
      // the returned ADM stream has N times stream_size rows
      for (int irow = 0; irow < mat.GetLength(0); irow++)
      {
        for (int icol = 0; icol < mat.GetLength(1); icol++)
        {
          // TODO - man könnte auch insert column aufrufen, anstatt
          // dieser for schleife. sicher? welche methode meine ich genau?
          vec[irow + icol * mat.GetLength(0)] = mat[irow, icol];
        }
      }

      return vec;
    }


    /// <summary>
    /// transpose given matrix
    /// </summary>
    /// <param name="mat">double matrix</param>
    /// <returns>transpose of the gíven matrix</returns>
    public static double[,] transpose(double[,] mat)
    {
      double[,] mat_t = new double[mat.GetLength(1), mat.GetLength(0)];

      for (int irow = 0; irow < mat.GetLength(0); irow++)
      {
        for (int icol = 0; icol < mat.GetLength(1); icol++)
        {
          mat_t[icol, irow] = mat[irow, icol];
        }
      }

      return mat_t;
    }


    /// <summary>
    /// normalizes given matrix mat along the given dimension.
    /// 
    /// Warning: mat is changed in this call
    /// </summary>
    /// <param name="mat">double matrix</param>
    /// <param name="dim">0 for rows or 1 for columns</param>
    /// <returns></returns>
    /// <exception cref="exception">dim &gt; 1 || dim &lt; 0</exception>
    /// <exception cref="exception">division by zero</exception>
    public static double[,] normalize(double[,] mat, int dim)
    { 
      // dim is checked inside sum
      double[] sum_mat = sum(mat, dim);

      for (int irow = 0; irow < mat.GetLength(0); irow++)
      {
        for (int icol = 0; icol < mat.GetLength(1); icol++)
        {
          if (dim == 0)
          {
            if (sum_mat[icol] == 0)
              throw new exception(String.Format("{0}th element of sum_mat is 0!", icol));

            mat[irow, icol] = mat[irow, icol] / sum_mat[icol];
          }
          else //if (dim == 1)
          {
            if (sum_mat[irow] == 0)
              throw new exception(String.Format("{0}th element of sum_mat is 0!", irow));

            mat[irow, icol] = mat[irow, icol] / sum_mat[irow];
          }
        }
      }

      return mat;
    }

    /// <summary>
    /// the given value is normalized between 0 and 1. The value should
    /// be in a domain spanned up by min_val and max_val. If it is not,
    /// the returned value will not be between 0 and 1, but smaller or larger. 
    /// 
    /// <para>Warning: value is changed by this call</para>
    /// </summary>
    /// <param name="value">value to be normalized</param>
    /// <param name="min_val">lower boundary</param>
    /// <param name="max_val">upper boundary, must be &gt; lower boundary</param>
    /// <returns>normalized value</returns>
    /// <exception cref="exception">max_val &lt;= min_val</exception>
    public static double normalize(double value, double min_val, double max_val)
    {
      if (max_val <= min_val)
        throw new exception(String.Format("max_val must be > min_val, but {0} <= {1}!", 
                            max_val, min_val));

      value = value - min_val;

      value= value / (max_val - min_val);

      return value;
    }

    /// <summary>
    /// calculates Tukey's biweight function with constant C= 4.6851
    /// </summary>
    /// <param name="x">the argument of the function</param>
    /// <returns>Tukey's biweight function evaluated at x</returns>
    public static double tukeybiweight(double x)
    {
      return tukeybiweight(x, 4.6851);
    }
    /// <summary>
    /// calculates Tukey's biweight function
    /// </summary>
    /// <param name="x">the argument of the function</param>
    /// <param name="C">a constant</param>
    /// <returns>Tukey's biweight function evaluated at x</returns>
    /// <exception cref="exception">|C| &lt; epsilon</exception>
    public static double tukeybiweight(double x, double C)
    { 
      // this is for psi := d/dx rho
      // hulp= x - 2 .* x.^3 / (C^2) + x.^5 / (C^4);

      if (Math.Abs(C) < double.Epsilon)
        throw new exception(String.Format("May not divide by 0: {0}!", C));

      // rho
      double hulp= C*C / 6 * ( 1 - Math.Pow( 1 - Math.Pow(x / C, 2), 3 ) );

      double rho = hulp * Convert.ToDouble(Math.Abs(x) < C) + 
                   C * C / 6 * Convert.ToDouble(Math.Abs(x) >= C);

      return rho;
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates the arithmetic mean value of the double array. the arithmetic mean
    /// is just the sum of all elements divided by the number of elements in the vector. 
    /// </summary>
    /// <param name="values">double vector</param>
    /// <returns>arithmetic mean of given vector</returns>
    public static double mean(double[] values)
    {
      double mean= sum(values);

      if (values.Length > 0)
        mean /= values.Length;

      return mean;
    }

    /// <summary>
    /// Calculates the arithmetic mean value of the double list. the arithmetic mean
    /// is just the sum of all elements divided by the number of elements in the list. 
    /// </summary>
    /// <param name="values">double list</param>
    /// <returns>arithmetic mean of given list</returns>
    public static double mean(List<double> values)
    {
      double mean = sum(values);

      if (values.Count > 0)
        mean /= values.Count;

      return mean;
    }

    /// <summary>
    /// Returns the median of the double list
    /// </summary>
    /// <param name="sourceNumbers">list of doubles</param>
    /// <returns>median of list</returns>
    /// <seealso cref="median(double[])"/>
    public static double median(List<double> sourceNumbers)
    {
      double[] mynumbers = sourceNumbers.ToArray();

      return median(mynumbers);
    }
    /// <summary>
    /// Returns the median of the byte list
    /// </summary>
    /// <param name="sourceNumbers">list of bytes</param>
    /// <returns>median of list</returns>
    /// <seealso cref="median(double[])"/>
    public static byte median(List<Byte> sourceNumbers)
    {
      byte[] mynumbers = sourceNumbers.ToArray();

      double[] mydoubles = new double[mynumbers.Length];

      for (int iel = 0; iel < mynumbers.Length; iel++)
        mydoubles[iel] = (double)(mynumbers[iel]);

      return (byte)median(mydoubles);
    }
    /// <summary>
    /// Returns the median of a double array. if the size of the vector is even
    /// then the mean of the middle and the previous value is taken. 
    /// Example: length= 4, then arithmetic mean of elements 2 and 1 is taken.
    /// </summary>
    /// <param name="sourceNumbers">double array of any length</param>
    /// <returns>median of array</returns>
    public static double median(double[] sourceNumbers)
    {
      // Framework 2.0 version of this method. there is an easier way in F4        
      if (sourceNumbers == null || sourceNumbers.Length == 0)
        return 0D;

      if (sourceNumbers.Length == 1)
        return sourceNumbers[0];

      // make sure the list is sorted, but use a new array
      double[] sortedPNumbers = (double[])sourceNumbers.Clone();
      sourceNumbers.CopyTo(sortedPNumbers, 0);
      Array.Sort(sortedPNumbers);

      // get the median
      int size = sortedPNumbers.Length;
      int mid = size / 2;
      double medianval = (size % 2 != 0) ? (double)sortedPNumbers[mid] :
                         ((double)sortedPNumbers[mid] + (double)sortedPNumbers[mid - 1]) / 2;

      return medianval;
    }

    /// <summary>
    /// Calculates the sum of the elements of the double vector
    /// </summary>
    /// <param name="values">double vector</param>
    /// <returns>sum of components of values, double scalar</returns>
    public static double sum(double[] values)
    { 
      double sum= 0;

      foreach (double component in values)
      {
        sum += component;
      }

      return sum;
    }

    /// <summary>
    /// Calculates the sum of the elements of the double list
    /// </summary>
    /// <param name="values">double list</param>
    /// <returns>sum of components of values, double scalar</returns>
    public static double sum(List<double> values)
    {
      double sum = 0;

      foreach (double component in values)
      {
        sum += component;
      }

      return sum;
    }

    /// <summary>
    /// Calculates the sum along the given dimension of the 2dim double matrix
    /// </summary>
    /// <param name="values">2dim double matrix</param>
    /// <param name="dim">0 or 1, otherwise throws an exception
    /// <para>0: sum over rows is calculated, size of returned vector is equal to 
    ///    number of columns of given values matrix (a row vector)</para>
    /// <para>1: sum over columns is calculated, size of returned vector is equal to 
    ///    number of rows of given values matrix (a column vector)</para>
    ///    </param>
    /// <returns>double row or column vector</returns>
    /// <exception cref="exception">dim &gt; 1 || dim &lt; 0</exception>
    /// <seealso cref="sum(double[])"/>
    public static double[] sum(double[,] values, int dim)
    {
      if (dim > 1 || dim < 0)
        throw new exception( String.Format("dim must be 0 or 1, but is {0}!", dim) );

      int sum_size= 0;
      int dummy_size= 0;

      if (dim == 0)   // sum over rows is calculated
        sum_size= values.GetLength(1);    // size of returned vector
      else            //  sum over columns is calculated
        sum_size = values.GetLength(0);    // size of returned vector

      dummy_size = values.GetLength(dim);   // number of elements inside the sum

      double[] sum_v= new double[sum_size];   // returned vector

      double[] temp= new double[dummy_size];  // contains row or vector, depends on dim
        
      for (int iel= 0; iel < sum_size; iel++)
      {
        if (dim == 0)
        {
          for (int ii= 0; ii < dummy_size; ii++)
            temp[ii]= values[ii, iel];
        }
        else
        {
          for (int ii= 0; ii < dummy_size; ii++)
            temp[ii]= values[iel, ii];
        }

        sum_v[iel]= sum(temp);
      }

      return sum_v;
    }

    

    /// <summary>
    /// Returns the abs values of the vector v
    /// </summary>
    /// <param name="v">double vector</param>
    /// <returns>|v|, where || is element wise</returns>
    public static double[] abs(double[] v)
    {
      double[] v_abs= v;

      for (int ii= 0; ii < v_abs.Length; ii++)
      {
        v_abs[ii]= Math.Abs(v[ii]);
      }

      return v_abs;
    }


    /// <summary>
    /// Returns a bool vector performing a component wise greater than
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>bool vector</returns>
    /// <exception cref="exception">when length of both vectors is not the same</exception>
    /// <exception cref="exception">if the vectors are empty</exception>
    public static bool[] gt(double[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      bool[] cmp= new bool[v1.Length];

      for (int icomp= 0; icomp < v1.Length; icomp++)
      {
        cmp[icomp]= v1[icomp] > v2[icomp];
      }

      return cmp;
    }

    /// <summary>
    /// Returns a bool vector performing a component wise lower than
    /// </summary>
    /// <param name="v1">double vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>bool vector</returns>
    /// <exception cref="exception">when length of both vectors is not the same</exception>
    /// <exception cref="exception">if the vectors are empty</exception>
    public static bool[] lt(double[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      bool[] cmp= new bool[v1.Length];

      for (int icomp= 0; icomp < v1.Length; icomp++)
      {
        cmp[icomp]= v1[icomp] < v2[icomp];
      }

      return cmp;
    }

    /// <summary>
    /// if any element in v is true, then return true, else false
    /// </summary>
    /// <param name="v">boolean vector</param>
    /// <returns>true or false</returns>
    public static bool any(bool[] v)
    {
      for (int icomp= 0; icomp < v.Length; icomp++)
      {
        if (v[icomp])
          return true;
      }

      return false;
    }

    /// <summary>
    /// If all elements in v are true, then return true, else false.
    /// so if any element in v is false, then return false, else return true.
    /// if v is empty, true is returned as well, this is as MATLAB does. 
    /// all([]) = 1
    /// </summary>
    /// <param name="v">bool vector</param>
    /// <returns>true or false</returns>
    public static bool all(bool[] v)
    {
      //if (v.Length == 0)
      //  return false;

      for (int icomp= 0; icomp < v.Length; icomp++)
      {
        if (!v[icomp])
          return false;
      }

      return true;
    }

    /// <summary>
    /// Creates a double vector containing 0s
    /// </summary>
    /// <param name="dim">
    /// dimension of vector, must be >= 1, otherwise an error is thrown
    /// </param>
    /// <returns>zero vector</returns>
    /// <exception cref="exception">dim &lt; 1</exception>
    public static double[] zeros(int dim)
    {
      if (dim <= 0)
        throw new exception(String.Format("dim must be >= 1, but is {0}!", dim));

      double[] v= new double[dim];

      for (int iel= 0; iel < v.Length; iel++)
        v[iel]= 0;

      return v;
    }

    /// <summary>
    /// Creates a double matrix containing 0s
    /// </summary>
    /// <param name="rows">
    /// num rows of matrix, must be >= 1, otherwise an error is thrown</param>
    /// <param name="cols">
    /// num cols of matrix, must be >= 1, otherwise an error is thrown</param>
    /// <returns>zero matrix</returns>
    /// <exception cref="exception">rows &lt; 1</exception>
    /// <exception cref="exception">cols &lt; 1</exception>
    public static double[,] zeros(int rows, int cols)
    {
      if (rows <= 0)
        throw new exception(String.Format("rows must be >= 1, but is {0}!", rows));
      if (cols <= 0)
        throw new exception(String.Format("cols must be >= 1, but is {0}!", cols));

      double[,] mat = new double[rows, cols];

      for (int irow = 0; irow < mat.GetLength(0); irow++)
        for (int icol = 0; icol < mat.GetLength(1); icol++)
          mat[irow, icol] = 0;

      return mat;
    }

    /// <summary>
    /// Creates a double vector containing 1s
    /// </summary>
    /// <param name="dim">
    /// dimension of vector, must be >= 1, otherwise an error is thrown</param>
    /// <returns>vector with ones</returns>
    /// <exception cref="exception">dim &lt; 1</exception>
    public static double[] ones(int dim)
    {
      if (dim <= 0)
        throw new exception(String.Format("dim must be >= 1, but is {0}!", dim));

      double[] v= new double[dim];

      for (int iel= 0; iel < v.Length; iel++)
        v[iel]= 1;

      return v;
    }

    /// <summary>
    /// Creates a double matrix, Einheitsmatrix, only diagonal contain 1s, rest 0
    /// </summary>
    /// <param name="rows">
    /// num rows of matrix, must be >= 1, otherwise an error is thrown</param>
    /// <param name="cols">
    /// num cols of matrix, must be >= 1, otherwise an error is thrown</param>
    /// <returns></returns>
    /// <exception cref="exception">rows &lt; 1</exception>
    /// <exception cref="exception">cols &lt; 1</exception>
    public static double[,] eye(int rows, int cols)
    {
      if (rows <= 0)
        throw new exception(String.Format("rows must be >= 1, but is {0}!", rows));
      if (cols <= 0)
        throw new exception(String.Format("cols must be >= 1, but is {0}!", cols));

      double[,] mat = zeros(rows, cols);

      for (int iel = 0; iel < Math.Min(rows, cols); iel++)
        mat[iel, iel] = 1;

      return mat;
    }
    /// <summary>
    /// Creates a double matrix, Einheitsmatrix, only diagonal contain 1s, rest 0
    /// </summary>
    /// <param name="dim">dimension of the matrix</param>
    /// <returns></returns>
    /// <exception cref="exception">dim &lt; 1</exception>
    public static double[,] eye(int dim)
    {
      return eye(dim, dim);
    }

    /// <summary>
    /// Returns the diagonal of a square matrix.
    /// </summary>
    /// <param name="matrix">square matrix</param>
    /// <returns>vector with the diagonal elements of the given matrix</returns>
    /// <exception cref="exception">matrix not square</exception>
    /// <exception cref="exception">matrix is empty</exception>
    public static double[] diag(double[,] matrix)
    { 
      if (matrix.GetLength(0) != matrix.GetLength(1))
        throw new exception(String.Format(
          "The given matrix is not quadratic: {0} != {1}!", 
          matrix.GetLength(0), matrix.GetLength(1)));

      if (matrix.GetLength(0) == 0)
        throw new exception("matrix is empty!");

      double[] diag_v= new double[matrix.GetLength(0)];

      for (int iel= 0; iel < matrix.GetLength(0); iel++)
        diag_v[iel]= matrix[iel,iel];

      return diag_v;
    }

    /// <summary>
    /// creates a diagonal matrix with vec being the main diagonal
    /// size of the matrix is equal to vec.Length
    /// </summary>
    /// <param name="vec">
    /// double vector being the diagonal of the created matrix
    /// </param>
    /// <returns>diagonal matrix</returns>
    /// <exception cref="exception">vec is empty</exception>
    public static double[,] diag(double[] vec)
    {
      if (vec.Length == 0)
        throw new exception("vec is empty!");

      double[,] mat= zeros(vec.Length, vec.Length);

      for (int irow = 0; irow < mat.GetLength(0); irow++ )
        mat[irow,irow]= vec[irow];

      return mat;
    }

    /// <summary>
    /// return !vec
    /// </summary>
    /// <param name="vec">boolean vector</param>
    /// <returns>!vec</returns>
    public static bool[] not(bool[] vec)
    { 
      bool[] vec2= new bool[vec.Length];

      for (int iel = 0; iel < vec.Length; iel++ )
        vec2[iel]= !vec[iel];

      return vec2;
    }

    /// <summary>
    /// returns the row_indexth row of the given matrix
    /// </summary>
    /// <param name="matrix">2dim double matrix</param>
    /// <param name="row_index">ith row of matrix, 0-based</param>
    /// <returns>ith row of given matrix</returns>
    /// <exception cref="exception">row_index &lt; 0 || row_index &gt;= size of matrix
    /// </exception>
    public static double[] getrow(double[,] matrix, int row_index)
    { 
      double[] row_vec= new double[matrix.GetLength(1)];

      if ( (row_index < 0) || (row_index >= matrix.GetLength(0)) )
        throw new exception(String.Format(
              "The given row_index must be in between 0 and {0}!",
              matrix.GetLength(0) - 1));

      for (int iel = 0; iel < matrix.GetLength(1); iel++)
        row_vec[iel] = matrix[row_index, iel];

      return row_vec;
    }

    /// <summary>
    /// get rows out of a column vector vec
    /// </summary>
    /// <param name="vec">column vector</param>
    /// <param name="start_row">0-based index of start element</param>
    /// <param name="end_row">0-based index of end element</param>
    /// <returns>rows of vec between start_row and end_row</returns>
    /// <exception cref="exception">start_row &gt;= end_row</exception>
    /// <exception cref="exception">start_row &gt; 0</exception>
    /// <exception cref="exception">end_row &gt; vector length</exception>
    public static double[] getrows(double[] vec, int start_row, int end_row)
    {
      if (start_row >= end_row)
        throw new exception(String.Format(
              "end_row < start_row: {0} >= {1}!", start_row, end_row));

      if (start_row < 0)
        throw new exception(String.Format(
              "start_row < 0: {0} < 0!", start_row));

      if (end_row > vec.Length)
        throw new exception(String.Format("end_row > vec.Length: {0} > {1}",
          end_row, vec.Length));

      double[] v2 = new double[end_row - start_row + 1];

      for (int iel = 0; iel < v2.Length; iel++)
        v2[iel] = vec[start_row + iel];

      return v2;
    }

    /// <summary>
    /// returns the col_indexth column of the given matrix
    /// </summary>
    /// <param name="matrix">2dim double matrix</param>
    /// <param name="col_index">ith col of matrix, 0-based</param>
    /// <returns>ith col of given matrix</returns>
    /// <exception cref="exception">col_index &lt; 0 || col_index &gt;= matrix columns
    /// </exception>
    public static double[] getcol(double[,] matrix, int col_index)
    {
      double[] col_vec = new double[matrix.GetLength(0)];

      if ((col_index < 0) || (col_index >= matrix.GetLength(1)))
        throw new exception(String.Format(
              "The given col_index must be in between 0 and {0}!",
              matrix.GetLength(1) - 1));

      for (int iel = 0; iel < matrix.GetLength(0); iel++)
        col_vec[iel] = matrix[iel, col_index];

      return col_vec;
    }

    /// <summary>
    /// repmat function from MATLAB, reproduces the given vector as often as given by factor
    /// a vector with factor times as many components is returned
    /// </summary>
    /// <param name="vec">a double vector</param>
    /// <param name="factor">factor, must be >= 1, otherwise an error is thrown</param>
    /// <returns>a column vector with as many elements as factor * vec.Length</returns>
    /// <exception cref="exception">factor &lt;= 0</exception>
    /// <exception cref="exception">vec is empty</exception>
    public static double[] repmat(double[] vec, int factor)
    {
      if (factor <= 0)
        throw new exception(String.Format("factor must be >= 1, but is {0}!", factor));

      if (vec.Length == 0)
        throw new exception("vec is empty!");

      double[] new_vec= new double[vec.Length * factor];

      for (int icomp= 0; icomp < new_vec.Length; icomp++)
      {
        new_vec[icomp]= vec[icomp % vec.Length];
      }

      return new_vec;
    }


    
  }
}



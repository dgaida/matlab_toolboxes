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
 * This file defines insert methods of the math class.
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
    /// inserts mat2 into mat1, starting at column start_col and row 
    /// start_row. mat1 is changed by this call
    /// 
    /// in MATLAB this would be:
    /// mat1(start_row:start_row+4, start_col:start_col+5)= mat2;
    /// if mat2 is a 4x5 matrix.
    /// 
    /// Warning: mat1 is changed by this method
    /// </summary>
    /// <param name="mat1">big matrix</param>
    /// <param name="mat2">smaller matrix</param>
    /// <param name="start_row">row index of mat1, where mat2
    /// is started to be inserted: mat1(start_row,:)= mat2(0,:), 0-based</param>
    /// <param name="start_col">column index of mat1, where mat2
    /// is started to be inserted: mat1(:,start_col)= mat2(:,0), 0-based</param>
    /// <returns>mat1 with mat2 included at correct position</returns>
    /// <exception cref="exception">start_row + mat2.GetLength(0) > mat1.GetLength(0)
    /// </exception>
    /// <exception cref="exception">start_col + mat2.GetLength(1) > mat1.GetLength(1)
    /// </exception>
    public static double[,] insert(double[,] mat1, double[,] mat2, 
                                   int start_row, int start_col)
    {
      // Sicherheitsabfragen

      if (start_row + mat2.GetLength(0) > mat1.GetLength(0))
        throw new exception(String.Format(
              "mat2 has a two high number of rows: {0}!",
              mat2.GetLength(0)), "math_insert.cs");

      if (start_col + mat2.GetLength(1) > mat1.GetLength(1))
        throw new exception(String.Format(
              "mat2 has a two high number of columns: {0}!",
              mat2.GetLength(1)), "math_insert.cs");

      //

      for (int irow = 0; irow < mat2.GetLength(0); irow++)
        for (int icol = 0; icol < mat2.GetLength(1); icol++)
          mat1[start_row + irow, start_col + icol] = mat2[irow, icol];

      return mat1;
    }

    /// <summary>
    /// inserts column vector vec in given matrix mat
    /// 
    /// MATLAB:
    /// mat(start_row:start_row + 4, col)= vec
    /// if length of vec is 5
    /// 
    /// Warning: mat is changed by this method
    /// </summary>
    /// <param name="mat">double matrix</param>
    /// <param name="vec">double column vector</param>
    /// <param name="start_row">0-based</param>
    /// <param name="col">0-based column where vector is inserted</param>
    /// <returns>mat with vec inserted at the correct position</returns>
    /// <exception cref="exception">start_row + vec.Length > mat.GetLength(0)
    /// </exception>
    /// <exception cref="exception">col >= mat.GetLength(1)
    /// </exception>
    public static double[,] insertColumn(double[,] mat, double[] vec,
                                         int start_row, int col)
    {
      // Sicherheitsabfragen

      if (start_row + vec.Length > mat.GetLength(0))
        throw new exception(String.Format(
              "something wrong with start_row or vec.Length: {0}, {1}!",
              start_row, vec.Length), "math_insert.cs");

      if (col >= mat.GetLength(1))
        throw new exception(String.Format(
              "something wrong with col: {0}!", col), "math_insert.cs");

      //

      for (int irow = 0; irow < vec.Length; irow++)
        mat[start_row + irow, col] = vec[irow];

      return mat;
    }

    /// <summary>
    /// inserts row vector vec in given matrix mat
    /// 
    /// MATLAB:
    /// mat(row, start_col:start_col + 4)= vec
    /// if length of vec is 5
    /// 
    /// Warning: mat is changed by this method
    /// </summary>
    /// <param name="mat">double matrix</param>
    /// <param name="vec">double row vector</param>
    /// <param name="row">0-based row where vector is inserted</param>
    /// <param name="start_col">0-based</param>
    /// <returns>mat with vec inserted at correct position</returns>
    /// <exception cref="exception">start_col + vec.Length > mat.GetLength(1)
    /// </exception>
    /// <exception cref="exception">row >= mat.GetLength(0)
    /// </exception>
    public static double[,] insertRow(double[,] mat, double[] vec,
                                      int row, int start_col)
    {
      // Sicherheitsabfragen

      if (start_col + vec.Length > mat.GetLength(1))
        throw new exception(String.Format(
              "something wrong with start_col or vec.Length: {0}, {1}!",
              start_col, vec.Length), "math_insert.cs");

      if (row >= mat.GetLength(0))
        throw new exception(String.Format(
              "something wrong with row: {0}!", row), "math_insert.cs");

      //

      for (int icol = 0; icol < vec.Length; icol++)
        mat[row, start_col + icol] = vec[icol];

      return mat;
    }

    /// <summary>
    /// inserts scalar into mat, starting at column col and row 
    /// start_row. mat is changed by this call
    /// 
    /// in MATLAB this would be:
    /// mat(start_row:end_row, col)= scalar;
    /// </summary>
    /// <param name="mat">a double matrix</param>
    /// <param name="scalar">a double scalar which is inserted into the matrix</param>
    /// <param name="start_row">0 - based</param>
    /// <param name="end_row">0 - based</param>
    /// <param name="col">0 - based</param>
    /// <returns>matrix mat with inserted scalar</returns>
    /// <exception cref="exception">(start_row > end_row) || (end_row >= mat.GetLength(0))
    /// </exception>
    /// <exception cref="exception">(start_col > end_col) || (end_col >= mat.GetLength(1))
    /// </exception>
    public static double[,] insertColumn(double[,] mat, double scalar,
                                   int start_row, int end_row,
                                   int col)
    {
      return insert(mat, scalar, start_row, end_row, col, col);
    }

    /// <summary>
    /// inserts scalar into mat, starting at column start_col and row 
    /// row. mat is changed by this call
    /// 
    /// in MATLAB this would be:
    /// mat(row, start_col:end_col)= scalar;
    /// </summary>
    /// <param name="mat">a double matrix</param>
    /// <param name="scalar">a double scalar which is inserted into the matrix</param>
    /// <param name="row">0 - based</param>
    /// <param name="start_col">0 - based</param>
    /// <param name="end_col">0 - based</param>
    /// <returns>matrix mat with inserted scalar</returns>
    /// <exception cref="exception">(start_row > end_row) || (end_row >= mat.GetLength(0))
    /// </exception>
    /// <exception cref="exception">(start_col > end_col) || (end_col >= mat.GetLength(1))
    /// </exception>
    public static double[,] insertRow(double[,] mat, double scalar,
                                   int row, int start_col,
                                   int end_col)
    {
      return insert(mat, scalar, row, row, start_col, end_col);
    }

    /// <summary>
    /// inserts scalar into mat, starting at column start_col and row 
    /// start_row. mat is changed by this call
    /// 
    /// in MATLAB this would be:
    /// mat(start_row:end_row, start_col:end_col)= scalar;
    /// </summary>
    /// <param name="mat">a double matrix</param>
    /// <param name="scalar">a double scalar which is inserted into the matrix</param>
    /// <param name="start_row">0 - based</param>
    /// <param name="end_row">0 - based</param>
    /// <param name="start_col">0 - based</param>
    /// <param name="end_col">0 - based</param>
    /// <returns>matrix mat with inserted scalar</returns>
    /// <exception cref="exception">(start_row > end_row) || (end_row >= mat.GetLength(0))
    /// </exception>
    /// <exception cref="exception">(start_col > end_col) || (end_col >= mat.GetLength(1))
    /// </exception>
    public static double[,] insert(double[,] mat, double scalar,
                                   int start_row, int end_row, 
                                   int start_col, int end_col)
    {
      // Sicherheitsabfragen

      if ((start_row > end_row) || (end_row >= mat.GetLength(0)))
        throw new exception(String.Format(
              "something wrong with start_row and/or end_row: {0}, {1}!",
              start_row, end_row), "math_insert.cs");

      if ((start_col > end_col) || (end_col >= mat.GetLength(1)))
        throw new exception(String.Format(
              "something wrong with start_col and/or end_col: {0}, {1}!",
              start_col, end_col), "math_insert.cs");

      //

      for (int irow = start_row; irow <= end_row; irow++)
        for (int icol = start_col; icol <= end_col; icol++)
          mat[irow, icol] = scalar;

      return mat;
    }



    /// <summary>
    /// inserts vec2 into vec1, starting at position pos
    /// vec1 is changed by this call
    /// </summary>
    /// <param name="vec1">double vector</param>
    /// <param name="vec2">double vector, must be smaller as vec1</param>
    /// <param name="pos">position in vec1, 0-based</param>
    /// <returns>vec1 with vec2 inserted</returns>
    /// <exception cref="exception">pos + vec2.Length > vec1.Length</exception>
    public static double[] insert(double[] vec1, double[] vec2, int pos)
    {
      // Sicherheitsprüfungen

      if (pos + vec2.Length > vec1.Length)
        throw new exception(String.Format(
              "vec2 has a two high dimension: {0}!", vec2.Length), "math_insert.cs");

      for (int iel = 0; iel < vec2.Length; iel++)
        vec1[pos + iel] = vec2[iel];

      return vec1;
    }



  }
}



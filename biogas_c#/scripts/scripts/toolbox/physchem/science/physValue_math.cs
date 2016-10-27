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
* This file is part of the partial class physValue and contains
* the math related methods of the class, except of the operators.
* 
* TODOs:
* - see TODO in zeros()
* 
* Apart from that FINISHED! 
* 
*/

using System;
using toolbox;
using System.Text;
using System.Collections;
using System.Xml;

/**
 * The science namespace collects all classes which have to do with science in general.
 * 
 */
namespace science
{
  /// <remarks>
  /// Defines a physical value, which is a double number containing a unit and a symbol.
  /// Furthermore a label describes the physical value.
  /// There are operators implemented, such that you can add, substract, multiply, ...
  /// physical values.
  /// Working with physical values assures that you do not get wrong with units
  /// and always know in which unit the value is measured. This is realised by checking
  /// the unit while adding and substracting and reduce the fraction when multiplying
  /// and dividing physical values. Furthermore you can convert units.
  /// 
  /// You can define a reference for the physical value, e.g. when you save a number 
  /// which you have from literature or a database.
  /// 
  /// All methods in this class are const, as defined in C++, except stated otherwise
  /// 
  /// </remarks>
  public partial class physValue
  {

    // -------------------------------------------------------------------------------------
    //                       !!! PUBLIC METHODS: MATHEMATICAL STUFF !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Multiply a physValue array with a double scalar.
    /// Each value inside the array is multiplied with the scalar
    /// </summary>
    /// <param name="v">physValue vector</param>
    /// <param name="scalar">double scalar</param>
    /// <returns>v multiplied with scalar, componentwise</returns>
    public static physValue[] times(physValue[] v, double scalar)
    {
      physValue[] v_result= new physValue[v.Length];

      for (int iel= 0; iel < v_result.Length; iel++)
        v_result[iel]= v[iel] * scalar;

      return v_result;
    }

    /// <summary>
    /// Matrix product (no this is not the matrix product): multiply elements of physValue array with elements
    /// of double array, element-wise.
    /// 
    /// TODO: why is this method called mtimes and not times, as I multiply componentwise
    /// does not match with times in math_operator.cs, mtimes there is the scalar product
    /// 
    /// could rewrite this method so that it does the matrix product, returns a scalar then
    /// </summary>
    /// <param name="v1">physValue vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>v1 * v2, componentwise</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    [Obsolete("Use times(physValue[], double[]) instead.")]
    public static physValue[] mtimes(physValue[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      physValue[] v_result= new physValue[v1.Length];

      for (int iel= 0; iel < v_result.Length; iel++)
        v_result[iel]= v1[iel] * v2[iel];

      return v_result;
    }

    /// <summary>
    /// multiply elements of physValue array with elements
    /// of double array, element-wise.
    /// </summary>
    /// <param name="v1">physValue vector</param>
    /// <param name="v2">double vector</param>
    /// <returns>v1 .* v2, componentwise</returns>
    /// <exception cref="exception">v1.Length != v2.Length</exception>
    /// <exception cref="exception">v1 is empty</exception>
    public static physValue[] times(physValue[] v1, double[] v2)
    {
      if (v1.Length != v2.Length)
        throw new exception(String.Format(
              "The length of both vectors is not the same: {0} != {1}!",
              v1.Length, v2.Length));

      if (v1.Length <= 0)
        throw new exception(String.Format(
              "The length of both vectors is <= 0: {0}!", v1.Length));

      physValue[] v_result = new physValue[v1.Length];

      for (int iel = 0; iel < v_result.Length; iel++)
        v_result[iel] = v1[iel] * v2[iel];

      return v_result;
    }

    /// <summary>
    /// Returns the object out of both objects v1 and v2, which has the greater 
    /// numerical value. If Unit of both are not the same, then an error is 
    /// thrown
    /// </summary>
    /// <param name="v1">1st physValue</param>
    /// <param name="v2">2nd physValue</param>
    /// <returns>max(v1, v2)</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue max(physValue v1, physValue v2) // const
    {
      if (v1.Unit != v2.Unit)
      {
        throw new exception(String.Format(
              "Cannot compare! The units of both physical values are not equal: {0} != {1}!",
              v1.Unit, v2.Unit));
      }

      return new physValue( String.Format("Max({0}, {1})", v1.Symbol, v2.Symbol), 
                            Math.Max(v1.Value, v2.Value), v1.Unit);
    }

    /// <summary>
    /// Returns the max of the physical values in the given array.
    /// if array is empty, then positive infinity is returned, with no unit
    /// </summary>
    /// <param name="inputs">physValue vector</param>
    /// <returns>max(inputs)</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue max(physValue[] inputs) // const
    {
      physValue maxVal;

      if (inputs.Length > 0)
        maxVal= inputs[0];
      else
        maxVal= new physValue( Double.PositiveInfinity, "" );

      for (int iel= 0; iel < inputs.Length - 1; iel++)
      {
        maxVal= max(maxVal, inputs[iel + 1]);
      }

      return maxVal;
    }

    /// <summary>
    /// Returns the object out of both objects v1 and v2, which has the smaller 
    /// numerical value. If Unit of both are not the same, then an error is 
    /// thrown. 
    /// </summary>
    /// <param name="v1">first physValue</param>
    /// <param name="v2">2nd physValue</param>
    /// <returns>min(v1, v2)</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue min(physValue v1, physValue v2) // const
    {
      if (v1.Unit != v2.Unit)
      {
        throw new exception(String.Format(
              "Cannot compare! The units of both physical values are not equal: {0} != {1}!",
              v1.Unit, v2.Unit));
      }

      return new physValue( String.Format("Min({0}, {1})", v1.Symbol, v2.Symbol),
                            Math.Min(v1.Value, v2.Value), v1.Unit);
    }

    /// <summary>
    /// Returns the min of the physical values in the given array
    /// if array is empty, then negative infinity is returned, with no unit
    /// </summary>
    /// <param name="inputs">physValue vector</param>
    /// <returns>min(inputs)</returns>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue min(physValue[] inputs) // const
    {
      physValue minVal;

      if (inputs.Length > 0)
        minVal= inputs[0];
      else
        minVal= new physValue(Double.NegativeInfinity, "");

      for (int iel= 0; iel < inputs.Length - 1; iel++)
      {
        minVal= min(minVal, inputs[iel + 1]);
      }

      return minVal;
    }

    /// <summary>
    /// Returns the sum of the physical values in the given array. 
    /// If Unit of any of the elements is not the same as the others, then an error is 
    /// thrown
    /// </summary>
    /// <param name="inputs">physValue vector</param>
    /// <returns>sum of the components of inputs</returns>
    /// <exception cref="exception">inputs is empty</exception>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue sum(physValue[] inputs) // const
    {
      if (inputs.Length <= 0)
        throw new exception(String.Format("inputs.Length <= 0: {0}!", inputs.Length));

      double[] sum_d = new double[inputs.Length];

      for (int iin = 0; iin < inputs.Length; iin++)
      {
        if (inputs[iin].Unit != inputs[0].Unit)
          throw new exception(String.Format(
                  "Cannot add! The units of the summands are not equal: {0} != {1}!",
                  inputs[iin].Unit, inputs[0].Unit));

        sum_d[iin] = inputs[iin].Value;
      }

      return new physValue("sum", math.sum(sum_d), inputs[0].Unit);
    }

    /// <summary>
    /// Returns the arithemtic mean of the physical values in the given array
    /// </summary>
    /// <param name="inputs">physValue vector</param>
    /// <returns>arithmetic mean of the components of inputs</returns>
    /// <exception cref="exception">inputs is empty</exception>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue mean(physValue[] inputs) // const
    {
      physValue mean = sum(inputs);

      if (inputs.Length > 0)
        mean /= inputs.Length;

      return mean;
    }

    /// <summary>
    /// Returns the arithmetic mean of the physical values given.
    /// Call: physValue.meanVar(v1, v2, v3), v1-v3: physValues
    /// </summary>
    /// <param name="inputs">physValue objects</param>
    /// <returns>arithmetic mean of given values</returns>
    /// <exception cref="exception">inputs is empty</exception>
    /// <exception cref="exception">unit mismatch</exception>
    public static physValue meanVar(params physValue[] inputs) // const
    {
      physValue[] input_array= new physValue[inputs.Length];

      for(int iValue= 0; iValue < inputs.Length; iValue++)
        input_array[iValue]= inputs[iValue];

      return mean(input_array);
    }

    /// <summary>
    /// concatenate both vectors v1 and v2 vertically
    /// </summary>
    /// <param name="v1">first vector</param>
    /// <param name="v2">2nd vector</param>
    /// <returns>[v1; v2]</returns>
    public static physValue[] concat(physValue[] v1, physValue[] v2)
    {
      physValue[] v = new physValue[v1.Length + v2.Length];

      for (int iel = 0; iel < v.Length; iel++)
      {
        if (iel < v1.Length)
          v[iel] = v1[iel];
        else
          v[iel] = v2[iel - v1.Length];
      }

      return v;
    }

    /// <summary>
    /// Rounds the double Value to 2 digits
    /// </summary>
    /// <param name="value">some value</param>
    /// <returns>same value round to 2 digits</returns>
    public static physValue round(physValue value)
    {
      return round(value, 2);
    }
    /// <summary>
    /// Rounds the double Value of the given physValue to the given digits
    /// </summary>
    /// <param name="value">physValue</param>
    /// <param name="digits">number of digits</param>
    /// <returns>physValue the same as the given one, only value round to number of digits
    /// </returns>
    public static physValue round(physValue value, int digits)
    {
      physValue new_value= new physValue(value);

      // new_value.Value
      new_value._value= Math.Round(new_value.Value, digits);

      return new_value;
    }
    /// <summary>
    /// Rounds the double Value of each element inside the given physValue 
    /// array to the given digits
    /// </summary>
    /// <param name="values">array of physValue</param>
    /// <param name="digits">number of digits</param>
    /// <returns>vector of rounded physValues</returns>
    public static physValue[] round(physValue[] values, int digits)
    {
      physValue[] new_value= new physValue[values.Length];

      for (int ivalue= 0; ivalue < new_value.Length; ivalue++)
      {
        new_value[ivalue]= round(values[ivalue], digits);
      }

      return new_value;
    }

    /// <summary>
    /// Creates a physValue vector containing 0s
    /// </summary>
    /// <param name="dim">dimension of zero vector</param>
    /// <returns>zero vector with no unit "-"</returns>
    /// <exception cref="exception">dim &lt; 1</exception>
    public static physValue[] zeros(int dim)
    {
      if (dim <= 0)
        throw new exception(String.Format("dim must be >= 1, but is {0}!", dim));

      physValue[] v= new physValue[dim];

      // TODO - what is the definition of no unit? 1 or -?
      for (int iel= 0; iel < v.Length; iel++)
        v[iel]= new physValue(String.Format("v{0}", iel), 0, "-");

      return v;
    }

    /// <summary>
    /// Math.Pow for physValues: Math.Pow(value, power)
    /// </summary>
    /// <param name="value">physValue</param>
    /// <param name="power">power</param>
    /// <returns>value^power</returns>
    public static physValue Pow(physValue value, int power)
    {
      physValue new_value = new physValue(value);

      // new_value.Value
      new_value._value = Math.Pow(new_value.Value, power);
      new_value._symbol = String.Format("{0}^{1}", new_value.Symbol, power);
      new_value._unit = String.Format("({0})^{1}", new_value.Unit, power);
      new_value._label = String.Format("({0})^{1}", new_value.Label, power);

      return new_value;
    }

    /// <summary>
    /// Math.Pow for physValues: Math.Pow(value, numerator/denominator)
    /// </summary>
    /// <param name="value">physValue</param>
    /// <param name="numerator">Zähler</param>
    /// <param name="denominator">Nenner</param>
    /// <returns>value^(numerator/denominator)</returns>
    public static physValue Pow(physValue value, int numerator, int denominator)
    {
      physValue new_value = new physValue(value);

      // new_value.Value
      new_value._value = Math.Pow(new_value.Value, ((double)numerator / (double)denominator));
      new_value._symbol = String.Format("{0}^({1}/{2})", new_value.Symbol, numerator, denominator);
      new_value._unit = String.Format("({0})^({1}/{2})", new_value.Unit, numerator, denominator);
      new_value._label = String.Format("({0})^({1}/{2})", new_value.Label, numerator, denominator);

      return new_value;
    }

    /// <summary>
    /// Math.Sqrt for physValues: Math.Sqrt(value)
    /// </summary>
    /// <param name="value">physValue</param>
    /// <returns>sqrt(value)</returns>
    public static physValue Sqrt(physValue value)
    {
      physValue new_value = new physValue(value);

      // new_value.Value
      new_value._value = Math.Sqrt(new_value.Value);

      //if (new_value.Symbol.Length > 0)
        new_value._symbol = String.Format("{0}^(1/2)", new_value.Symbol);

      //if (new_value.Unit.Length > 0)
        new_value._unit = String.Format("({0})^(1/2)", new_value.Unit);

      //if (new_value.Label.Length > 0)
        new_value._label = String.Format("({0})^(1/2)", new_value.Label);

      return new_value;
    }



  }
}



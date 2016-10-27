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
* This file is part of the partial class physValue and defines
* the constructors of the class.
* 
* TODOs:
* 
* FINISHED!
* 
*/

using System;
using toolbox;
using System.Text;
using System.Collections;

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
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// constructor with all parameters
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    /// <param name="label">
    /// label of the physical value, such as temperature, mass, ...
    /// </param>
    /// <param name="reference">
    /// reference for a physical value gotten out of literature, or from plants
    /// </param>
    public physValue(string symbol, double value, string unit, string label, 
                     string reference)
    {
      _symbol= symbol;
      _value=  value;
      _unit=   unit;
      _label=  label;
      _reference= reference;
    }
    /// <summary>
    /// constructor with no reference
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    /// <param name="label">
    /// label of the physical value, such as temperature, mass, ...
    /// </param>
    public physValue(string symbol, double value, string unit, string label) : 
                     this(symbol, value, unit, label, "")
    {}
    /// <summary>
    /// constructor with no reference, label gotten via symbol
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    public physValue(string symbol, double value, string unit)
    {
      _symbol= symbol;
      _value=  value;
      _unit=   unit;

      string dummy;
      
      physValue.getLabelAndUnit(_symbol, out _label, out dummy);
    }
    /// <summary>
    /// constructor useful for temporary variables, only value and unit is defined
    /// </summary>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <param name="unit">
    /// unit of the physical value, without rectangular brackets
    /// </param>
    public physValue(double value, string unit)
    {
      _value=  value;
      _unit=   unit;
    }
    /// <summary>
    /// constructor with no reference, label and unit gotten via symbol
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    /// <param name="value">
    /// value of the physical value
    /// </param>
    /// <exception cref="exception">Could not find a unit for the symbol</exception>
    [Obsolete("Not save because you do not know in beforehand in which unit <value> is measured")]
    public physValue(string symbol, double value)
    {
      _symbol= symbol;
      _value=  value;
      
      if (!physValue.getLabelAndUnit(_symbol, out _label, out _unit))
        throw new exception(String.Format(
                  "Could not find a unit for the symbol: {0}!",
                  _symbol));
    }
    /// <summary>
    /// constructor with no reference, label and unit gotten via symbol, value= 0
    /// </summary>
    /// <param name="symbol">
    /// symbol of the physical value, such as m for mass, T for temperature, ...
    /// </param>
    public physValue(string symbol) : this(symbol, 0, getDefaultUnit(symbol))
    {}
    /// <summary>
    /// standard constructor, everything default
    /// </summary>
    public physValue()
    {}
    /// <summary>
    /// constructor used to copy physValues, the returned physValue 
    /// is identical to the template
    /// </summary>
    /// <param name="template"></param>
    public physValue(physValue template)
    {
      _symbol=    template.Symbol;
      _value=     template.Value;
      _unit=      template.Unit;
      _label=     template.Label;
      _reference= template.Reference;
    }
    


  }
}



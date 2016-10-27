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
* Definition of a class containing set_- and get_params methods.
* 
* TODOs:
* - 
* 
* Should be FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;

/**
 * The toolbox namespace contains general classes used inside the toolbox.
 */
namespace toolbox
{
  /// <summary>
  /// defines set_params and get_params methods and abstract methods
  /// </summary>
  public abstract partial class set_get_interface
  {
    
    // -------------------------------------------------------------------------------------
    //                              !!! SET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set a string, such as id or name
    /// </summary>
    /// <param name="symbol">parameter to be set</param>
    /// <param name="value">string value of parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string symbol, string value)
    {
      object[] values = { symbol, value };

      this.set_params_of(values);
    }
    /// <summary>
    /// set physValue params of the object.
    /// Remark: make sure that the value 
    /// you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see in the child class: set_params_of(params double[] values)
    /// </summary>
    /// <param name="symbol">parameter to be set</param>
    /// <param name="value">value of the parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string symbol, physValue value)
    {
      object[] values = { symbol, value.Value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set two physValues to the given value. Only the Value of the given values is 
    /// set, so you must make sure that the unit and the rest is ok
    /// </summary>
    /// <param name="sym1">1st parameter to be set</param>
    /// <param name="val1">value of 1st parameter to be set</param>
    /// <param name="sym2">2nd parameter to be set</param>
    /// <param name="val2">value of 2nd parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string sym1, physValue val1,
                              string sym2, physValue val2)
    {
      object[] values = { sym1, val1.Value, sym2, val2.Value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set three physValues to the given value. Only the Value of the given values is 
    /// set, so you must make sure that the unit and the rest is ok
    /// </summary>
    /// <param name="sym1">1st parameter to be set</param>
    /// <param name="val1">value of 1st parameter to be set</param>
    /// <param name="sym2">2nd parameter to be set</param>
    /// <param name="val2">value of 2nd parameter to be set</param>
    /// <param name="sym3">3rd parameter to be set</param>
    /// <param name="val3">value of 3rd parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string sym1, physValue val1,
                              string sym2, physValue val2,
                              string sym3, physValue val3)
    {
      object[] values = { sym1, val1.Value, sym2, val2.Value, sym3, val3.Value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set four physValues to the given value. Only the Value of the given values is 
    /// set, so you must make sure that the unit and the rest is ok
    /// </summary>
    /// <param name="sym1">1st parameter to be set</param>
    /// <param name="val1">value of 1st parameter to be set</param>
    /// <param name="sym2">2nd parameter to be set</param>
    /// <param name="val2">value of 2nd parameter to be set</param>
    /// <param name="sym3">3rd parameter to be set</param>
    /// <param name="val3">value of 3rd parameter to be set</param>
    /// <param name="sym4">4th parameter to be set</param>
    /// <param name="val4">value of 4th parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string sym1, physValue val1,
                              string sym2, physValue val2,
                              string sym3, physValue val3,
                              string sym4, physValue val4)
    {
      object[] values = { sym1, val1.Value, sym2, val2.Value, 
                         sym3, val3.Value, sym4, val4.Value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set five physValues to the given value. Only the Value of the given values is 
    /// set, so you must make sure that the unit and the rest is ok
    /// </summary>
    /// <param name="sym1">1st parameter to be set</param>
    /// <param name="val1">value of 1st parameter to be set</param>
    /// <param name="sym2">2nd parameter to be set</param>
    /// <param name="val2">value of 2nd parameter to be set</param>
    /// <param name="sym3">3rd parameter to be set</param>
    /// <param name="val3">value of 3rd parameter to be set</param>
    /// <param name="sym4">4th parameter to be set</param>
    /// <param name="val4">value of 4th parameter to be set</param>
    /// <param name="sym5">5th parameter to be set</param>
    /// <param name="val5">value of 5th parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string sym1, physValue val1,
                              string sym2, physValue val2,
                              string sym3, physValue val3,
                              string sym4, physValue val4,
                              string sym5, physValue val5)
    {
      object[] values = { sym1, val1.Value, sym2, val2.Value, 
                         sym3, val3.Value, sym4, val4.Value, 
                         sym5, val5.Value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set six physValues to the given value. Only the Value of the given values is 
    /// set, so you must make sure that the unit and the rest is ok
    /// </summary>
    /// <param name="sym1">1st parameter to be set</param>
    /// <param name="val1">value of 1st parameter to be set</param>
    /// <param name="sym2">2nd parameter to be set</param>
    /// <param name="val2">value of 2nd parameter to be set</param>
    /// <param name="sym3">3rd parameter to be set</param>
    /// <param name="val3">value of 3rd parameter to be set</param>
    /// <param name="sym4">4th parameter to be set</param>
    /// <param name="val4">value of 4th parameter to be set</param>
    /// <param name="sym5">5th parameter to be set</param>
    /// <param name="val5">value of 5th parameter to be set</param>
    /// <param name="sym6">6th parameter to be set</param>
    /// <param name="val6">value of 6th parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string sym1, physValue val1,
                              string sym2, physValue val2,
                              string sym3, physValue val3,
                              string sym4, physValue val4,
                              string sym5, physValue val5,
                              string sym6, physValue val6)
    {
      object[] values = { sym1, val1.Value, sym2, val2.Value, 
                         sym3, val3.Value, sym4, val4.Value, 
                         sym5, val5.Value, sym6, val6.Value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set seven physValues to the given value. Only the Value of the given values is 
    /// set, so you must make sure that the unit and the rest is ok
    /// </summary>
    /// <param name="sym1">1st parameter to be set</param>
    /// <param name="val1">value of 1st parameter to be set</param>
    /// <param name="sym2">2nd parameter to be set</param>
    /// <param name="val2">value of 2nd parameter to be set</param>
    /// <param name="sym3">3rd parameter to be set</param>
    /// <param name="val3">value of 3rd parameter to be set</param>
    /// <param name="sym4">4th parameter to be set</param>
    /// <param name="val4">value of 4th parameter to be set</param>
    /// <param name="sym5">5th parameter to be set</param>
    /// <param name="val5">value of 5th parameter to be set</param>
    /// <param name="sym6">6th parameter to be set</param>
    /// <param name="val6">value of 6th parameter to be set</param>
    /// <param name="sym7">7th parameter to be set</param>
    /// <param name="val7">value of 7th parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string sym1, physValue val1,
                              string sym2, physValue val2,
                              string sym3, physValue val3,
                              string sym4, physValue val4,
                              string sym5, physValue val5,
                              string sym6, physValue val6,
                              string sym7, physValue val7)
    {
      object[] values = { sym1, val1.Value, sym2, val2.Value, 
                         sym3, val3.Value, sym4, val4.Value, 
                         sym5, val5.Value, sym6, val6.Value, 
                         sym7, val7.Value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set double params of the object.
    /// Used to set the value of physValues as well, so make sure that
    /// the value you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see: init_params_of(params double[] values)
    /// </summary>
    /// <param name="symbol">parameter to be set</param>
    /// <param name="value">double value of the parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string symbol, double value)
    {
      object[] values = { symbol, value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set int value of object.
    /// </summary>
    /// <param name="symbol">parameter to be set</param>
    /// <param name="value">int value of the parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string symbol, int value)
    {
      object[] values = { symbol, value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Set bool value of object.
    /// </summary>
    /// <param name="symbol">parameter to be set</param>
    /// <param name="value">bool value of the parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string symbol, bool value)
    {
      object[] values = { symbol, value };

      this.set_params_of(values);
    }
    /// <summary>
    /// Sets a general oject parameter
    /// </summary>
    /// <param name="symbol">parameter to be set</param>
    /// <param name="value">value of the parameter to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string symbol, object value)
    {
      object[] values = { symbol, value };

      this.set_params_of(values);
    }

    /// <summary>
    /// Set params of object. 
    /// Used to set the value of physValues as well, so make sure that
    /// the value you want to set is measured in the unit in which the
    /// physValue is saved in the object. 
    /// Therefore see in child class: set_params_of(params double[] values)
    /// </summary>
    /// <param name="symbols">array of symbols and its values to be set</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public abstract void set_params_of(params object[] symbols);



  }
}



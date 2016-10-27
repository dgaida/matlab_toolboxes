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
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns the variable specified by symbol as physValue
    /// </summary>
    /// <param name="variable">physValue</param>
    /// <param name="symbol">the needed symbol/parameter</param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public void get_params_of(out physValue variable, string symbol)
    {
      object[] variables;
      string[] symbols = { symbol };

      this.get_params_of(out variables, symbols);

      try
      {
        variable = (physValue)variables[0];
      }
      catch
      { // in case a double value is returned
        // TODO - hier könnte noch mal ein Fehler auftreten: conversion to double not possible!
        // wird bei Methode auch als mögliche excepion genannt also ok
        variable = new physValue((double)variables[0], "100 %");
      }
    }
    /// <summary>
    /// Get two physValue parameters.
    /// </summary>
    /// <param name="var1">physValue</param>
    /// <param name="symbol1">the 1st needed symbol/parameter</param>
    /// <param name="var2">physValue</param>
    /// <param name="symbol2">the 2nd needed symbol/parameter</param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to physValue not possible</exception>
    public void get_params_of(out physValue var1, string symbol1,
                              out physValue var2, string symbol2)
    {
      object[] variables;
      string[] symbols = { symbol1, symbol2 };

      this.get_params_of(out variables, symbols);

      try
      {
        var1 = (physValue)variables[0];
        var2 = (physValue)variables[1];
      }
      catch
      {
        throw new exception(String.Format("Cannot convert {0} and/or {1} to physValue!", 
          symbol1, symbol2), "set_get_interface");
      }
    }
    /// <summary>
    /// Get physValue parameter of the object.
    /// </summary>
    /// <param name="symbol">the needed symbol/parameter</param>
    /// <returns>physValue</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public physValue get_params_of(string symbol)
    {
      physValue variable;

      this.get_params_of(out variable, symbol);

      return variable;
    }
    /// <summary>
    /// Get the Value parameter of a physValue as a double
    /// </summary>
    /// <param name="symbol">the needed symbol/parameter</param>
    /// <returns>double Value</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of(string symbol)
    {
      return this.get_params_of(symbol).Value;
    }
    /// <summary>
    /// Get a double parameter as double.
    /// </summary>
    /// <param name="symbol">the needed symbol/parameter</param>
    /// <returns>double value of parameter</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(string symbol)
    {
      double variable;

      object[] variables;
      string[] symbols = { symbol };

      this.get_params_of(out variables, symbol);

      try
      {
        variable = (double)variables[0];
      }
      catch
      {
        throw new exception(String.Format("Cannot convert {0} to double!", symbol), "set_get_interface");
      }

      return variable;
    }
    /// <summary>
    /// Get a string parameter as string, such as id or name
    /// </summary>
    /// <param name="symbol">the needed symbol/parameter</param>
    /// <returns>string value of parameter</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(string symbol)
    {
      string variable;

      object[] variables;
      string[] symbols = { symbol };

      this.get_params_of(out variables, symbol);

      try
      {
        variable = (string)variables[0];
      }
      catch
      {
        throw new exception(String.Format("Cannot convert {0} to string!", symbol), "set_get_interface");
      }

      return variable;
    }
    /// <summary>
    /// Returns a bool variable as bool.
    /// </summary>
    /// <param name="symbol">the needed symbol/parameter</param>
    /// <returns>boolean value of parameter</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to bool not possible</exception>
    public bool get_param_of_b(string symbol)
    {
      bool variable;

      object[] variables;
      string[] symbols = { symbol };

      this.get_params_of(out variables, symbol);

      try
      {
        variable = (bool)variables[0];
      }
      catch
      {
        throw new exception(String.Format("Cannot convert {0} to bool!", symbol), "set_get_interface");
      }

      return variable;
    }
    /// <summary>
    /// Returns a integer variable as integer.
    /// </summary>
    /// <param name="symbol">the wanted symbol</param>
    /// <returns>integer value of symbol</returns>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to integer not possible</exception>
    public int get_param_of_i(string symbol)
    {
      int variable;

      object[] variables;
      string[] symbols = { symbol };

      this.get_params_of(out variables, symbol);

      try
      {
        variable = (int)variables[0];
      }
      catch
      {
        throw new exception(String.Format("Cannot convert {0} to int!", symbol), "set_get_interface");
      }

      return variable;
    }
    /// <summary>
    /// Get params as an array of physValues
    /// </summary>
    /// <param name="variables">returned array of physValues</param>
    /// <param name="symbols">array of parameters, must be nonempty</param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    /// <exception cref="exception">Conversion to physValue not possible</exception>
    public void get_params_of(out physValue[] variables, params string[] symbols)
    {
      object[] vars;

      get_params_of(out vars, symbols);

      variables = new physValue[vars.Length];

      try
      {
        for (int ivar = 0; ivar < vars.Length; ivar++)
          variables[ivar] = (physValue)vars[ivar];
      }
      catch
      {
        throw new exception("Cannot convert at least one symbol to physValue!", "set_get_interface");
      }
    }

    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">returned array of objects</param>
    /// <param name="symbols">array of symbols/parameters, must be nonempty</param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public abstract void get_params_of(out object[] variables, params string[] symbols);



  }
}



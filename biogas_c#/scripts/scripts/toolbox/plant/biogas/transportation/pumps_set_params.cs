/**
 * This file is part of the partial class pumps and defines
 * public set_params_of methods.
 * 
 * TODOs:
 * - 
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using toolbox;
using science;

/**
 * Mainly everything that has to do with biogas is defined in this namespace:
 * 
 * - Anaerobic Digestion Model
 * - CHPs
 * - Digesters
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// list of pumps
  /// 
  /// contains all pumps that are included inside the simulation model
  /// 
  /// next to pumps there also could be other transportation objects
  /// inside the model, see the other class
  /// </summary>
  public partial class pumps : List<pump>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set a string param of the by index specified pump. index is 1-based.
    /// </summary>
    /// <param name="index">index of pump</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value">string</param>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, string value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by index specified pump. index is 1-based.
    /// </summary>
    /// <param name="index">index of pump</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value">physValue</param>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by index specified pump. index is 1-based.
    /// </summary>
    /// <param name="index">index of pump</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value">double</param>
    /// <exception cref="exception">Invalid pump index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, double value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumPumps())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumPumps()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a string param of the by id specified pump.
    /// </summary>
    /// <param name="id">id of pump</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value">string</param>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, string value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by id specified pump.
    /// </summary>
    /// <param name="id">id of pump</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value">physValue</param>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by id specified pump.
    /// </summary>
    /// <param name="id">pump id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value">double</param>
    /// <exception cref="exception">Unknown pump id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, double value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }


    
  }
}



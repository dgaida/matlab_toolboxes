/**
 * This file is part of the partial class digesters and defines
 * public set_params_of methods.
 * 
 * TODOs:
 * - 
 * 
 * FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using toolbox;
using System.Xml;
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
  /// list of digesters
  /// </summary>
  public partial class digesters : List<digester>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set a string param of the by index specified digester. index is 1-based.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, string value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumDigesters())
        throw new exception(String.Format(
          "digester index out of bounds: {0}! Must be between 1 ... {1}", index, getNumDigesters()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by index specified digester. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      if (index <= 0 || index > getNumDigesters())
        throw new exception(String.Format(
          "digester index out of bounds: {0}! Must be between 1 ... {1}", index, getNumDigesters()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by index specified digester. index is 1-based.
    /// </summary>
    /// <param name="index">digester index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid digester index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, double value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumDigesters())
        throw new exception(String.Format(
          "digester index out of bounds: {0}! Must be between 1 ... {1}", index, getNumDigesters()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a string param of the by id specified digester.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, string value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by id specified digester.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by id specified digester.
    /// </summary>
    /// <param name="id">digester id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown digester id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, double value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }



  }
}



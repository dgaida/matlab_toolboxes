/**
 * This file is part of the partial class chps and defines
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
  /// list of chp s
  /// </summary>
  public partial class chps : List<chp>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Set a string param of the by index specified chp. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <param name="symbol">"name"</param>
    /// <param name="value">"mychp"</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, string value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumCHPs())
        throw new exception(String.Format(
          "chp index out of bounds: {0}! Must be between 1 ... {1}", index, getNumCHPs()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by index specified chp. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <param name="symbol">"Pel"</param>
    /// <param name="value">physValue</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      if (index <= 0 || index > getNumCHPs())
        throw new exception(String.Format(
          "chp index out of bounds: {0}! Must be between 1 ... {1}", index, getNumCHPs()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by index specified chp. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <param name="symbol">"eta_el"</param>
    /// <param name="value">double</param>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, double value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumCHPs())
        throw new exception(String.Format(
          "chp index out of bounds: {0}! Must be between 1 ... {1}", index, getNumCHPs()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a string param of the by id specified chp.
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <param name="symbol">"name"</param>
    /// <param name="value">"mychp"</param>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, string value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by id specified chp.
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <param name="symbol">"Pel"</param>
    /// <param name="value">physValue</param>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by id specified chp.
    /// </summary>
    /// <param name="id">id of chp</param>
    /// <param name="symbol">"ets_el"</param>
    /// <param name="value">double</param>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, double value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }


    
  }
}



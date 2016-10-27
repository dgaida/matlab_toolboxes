/**
 * This file is part of the partial class stirrers and defines
 * public get_params_of methods.
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
 * - Stirrers
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// list of stirrers
  /// </summary>
  public partial class stirrers : List<stirrer>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Get a string param of the by index specified stirrer. index is 1-based.
    /// </summary>
    /// <param name="index">1-based index of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>string</returns>
    /// <exception cref="exception">Invalid stirrer index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(int index, string symbol)
    {
      if (index <= 0 || index > getNumStirrers())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumStirrers()));

      return this[index - 1].get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by index specified stirrer. index is 1-based.
    /// </summary>
    /// <param name="index">1-based index of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>double</returns>
    /// <exception cref="exception">Invalid stirrer index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(int index, string symbol)
    {
      if (index <= 0 || index > getNumStirrers())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumStirrers()));

      return this[index - 1].get_param_of_d(symbol);
    }
    /// <summary>
    /// Get a int param of the by index specified stirrer. index is 1-based.
    /// </summary>
    /// <param name="index">1-based index of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>int</returns>
    /// <exception cref="exception">Invalid stirrer index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to int not possible</exception>
    public int get_param_of_i(int index, string symbol)
    {
      if (index <= 0 || index > getNumStirrers())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumStirrers()));

      return this[index - 1].get_param_of_i(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by index specified stirrer. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">1-based index of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>double</returns>
    /// <exception cref="exception">Invalid stirrer index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public double get_param_of(int index, string symbol)
    {
      if (index <= 0 || index > getNumStirrers())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumStirrers()));

      return this[index - 1].get_param_of(symbol);
    }

    /// <summary>
    /// Get a string param of the by id specified stirrer.
    /// </summary>
    /// <param name="id">id of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>string</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(string id, string symbol)
    {
      return get(id).get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by id specified stirrer.
    /// </summary>
    /// <param name="id">id of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>double</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(string id, string symbol)
    {
      return get(id).get_param_of_d(symbol);
    }
    /// <summary>
    /// Get a int param of the by id specified stirrer.
    /// </summary>
    /// <param name="id">id of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>int</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to int not possible</exception>
    public int get_param_of_i(string id, string symbol)
    {
      return get(id).get_param_of_i(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by id specified stirrer.
    /// </summary>
    /// <param name="id">id of stirrer</param>
    /// <param name="symbol"></param>
    /// <returns>double</returns>
    /// <exception cref="exception">Unknown stirrer id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public double get_param_of(string id, string symbol)
    {
      return get(id).get_param_of(symbol);
    }



  }
}



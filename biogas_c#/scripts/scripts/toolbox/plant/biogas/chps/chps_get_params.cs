/**
 * This file is part of the partial class chps and defines
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
    /// Get a string param of the by index specified chp. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <param name="symbol">"id"</param>
    /// <returns>string</returns>
    /// <exception cref="exception">Invalid index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(int index, string symbol)
    {
      return get(index).get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by index specified chp. index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <param name="symbol">"eta_el"</param>
    /// <returns>value</returns>
    /// <exception cref="exception">Invalid index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(int index, string symbol)
    {
      return get(index).get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by index specified chp. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">index of chp</param>
    /// <param name="symbol">"Pel"</param>
    /// <returns>double value</returns>
    /// <exception cref="exception">Invalid chp index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public double get_param_of(int index, string symbol)
    {
      return get(index).get_param_of(symbol);
    }

    /// <summary>
    /// Get a string param of the by id specified chp.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <param name="symbol">"name"</param>
    /// <returns>string</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(string id, string symbol)
    {
      return get(id).get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by id specified chp.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <param name="symbol">"eta_el"</param>
    /// <returns>double</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(string id, string symbol)
    {
      return get(id).get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by id specified chp.
    /// </summary>
    /// <param name="id">chp id</param>
    /// <param name="symbol">"Pel"</param>
    /// <returns>double Value</returns>
    /// <exception cref="exception">Unknown chp id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public double get_param_of(string id, string symbol)
    {
      return get(id).get_param_of(symbol);
    }


    
  }
}



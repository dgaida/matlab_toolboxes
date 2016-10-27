/**
 * This file is part of the partial class substrate_transports and defines
 * public get_params_of methods.
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
  /// list of substrate_transports
  /// 
  /// contains all substrate_transports that are included inside the simulation model
  /// 
  /// next to substrate_transports there also could be other transportation objects
  /// inside the model, see the other class
  /// </summary>
  public partial class substrate_transports : List<substrate_transport>
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Get a string param of the by index specified substrate_transport. index is 1-based.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(int index, string symbol)
    {
      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      return this[index - 1].get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by index specified substrate_transport. index is 1-based.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(int index, string symbol)
    {
      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      return this[index - 1].get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by index specified substrate_transport. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of(int index, string symbol)
    {
      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      return this[index - 1].get_param_of(symbol);
    }

    /// <summary>
    /// Get a string param of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to string not possible</exception>
    public string get_param_of_s(string id, string symbol)
    {
      return get(id).get_param_of_s(symbol);
    }
    /// <summary>
    /// Get a double param of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of_d(string id, string symbol)
    {
      return get(id).get_param_of_d(symbol);
    }
    /// <summary>
    /// Get the Value of a physValue param of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double get_param_of(string id, string symbol)
    {
      return get(id).get_param_of(symbol);
    }


    
  }
}



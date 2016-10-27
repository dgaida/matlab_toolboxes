/**
 * This file is part of the partial class substrate_transports and defines
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
    /// Set a string param of the by index specified substrate_transport. index is 1-based.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, string value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by index specified substrate_transport. index is 1-based.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by index specified substrate_transport. index is 1-based.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(int index, string symbol, double value)
    {
      object[] values= { symbol, value };

      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      this[index - 1].set_params_of(values);
    }
    /// <summary>
    /// Set a string param of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, string value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set the Value of a physValue param of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, physValue value)
    {
      object[] values= { symbol, value.Value };

      get(id).set_params_of(values);
    }
    /// <summary>
    /// Set a double param of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void set_params_of(string id, string symbol, double value)
    {
      object[] values= { symbol, value };

      get(id).set_params_of(values);
    }


    
  }
}



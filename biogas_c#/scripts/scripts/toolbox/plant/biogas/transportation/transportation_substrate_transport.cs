/**
 * This file defines method of the partial class transportation 
 * for substrate_transport.
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
  /// transportation objects to pump/transport substrates or sludge
  /// 
  /// - substrate_transport
  /// 
  /// </summary>
  public partial class transportation
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Add given substrate_transport to list
    /// </summary>
    /// <param name="mySubstrateTransport"></param>
    public void addSubstrateTransport(substrate_transport mySubstrateTransport)
    {
      mySubstrateTransports.addSubstrateTransport(mySubstrateTransport);    
    }

    /// <summary>
    /// Delete the specified substrate_transport from the list.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    public void deleteSubstrateTransport(string id)
    {
      mySubstrateTransports.deleteSubstrateTransport(id);
    }
    /// <summary>
    /// Delete the specified substrate_transport from the lists. index is 1-based.
    /// </summary>
    /// <param name="index">index of the substrate_transport in the list</param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    public void deleteSubstrateTransport(int index)
    {
      mySubstrateTransports.deleteSubstrateTransport(index);
    }



    /// <summary>
    /// Returns true if mySubstrateTransports contains the given substrate_transport_id
    /// </summary>
    /// <param name="substrate_transport_id">id of a substrate_transport</param>
    /// <returns>true if substrate_transport is inside the list, else false</returns>
    public bool containsSubstrateTransport(string substrate_transport_id)
    {
      return mySubstrateTransports.contains(substrate_transport_id);    
    }



    /// <summary>
    /// Returns number of substrate_transports
    /// </summary>
    /// <returns>number of substrate_transports</returns>
    public int getNumSubstrateTransports()
    {
      return this.mySubstrateTransports.Count;
    }

    /// <summary>
    /// Returns number of substrate_transports as double (only for MATLAB)
    /// </summary>
    /// <returns>number of substrate_transports</returns>
    public double getNumSubstrateTransportsD()
    {
      return (double)getNumSubstrateTransports();
    }


    /// <summary>
    /// Returns the substrate_transport ID of the by index specified substrate_transport. 
    /// index is 1-based.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    public string getSubstrateTransportID(int index)
    {
      if (index <= 0 || index > getNumSubstrateTransports())
        throw new exception(String.Format(
          "index out of bounds: {0}! Must be between 1 ... {1}", index, getNumSubstrateTransports()));

      return mySubstrateTransports[index - 1].id;
    }
    /// <summary>
    /// Returns the substrate_transport's index, specified by id.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    public int getSubstrateTransportIndex(string id)
    {
      return mySubstrateTransports.getIndexByID(id);
    }

    /// <summary>
    /// Returns the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    public substrate_transport getSubstrateTransportByID(string id)
    {
      return mySubstrateTransports.get(id);
    }
    /// <summary>
    /// Returns the by index specified substrate_transport object. index is 1-based.
    /// </summary>
    /// <param name="index">index of the substrate_transport</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    public substrate_transport getSubstrateTransport(int index)
    {
      return mySubstrateTransports.get(index);
    }

    /// <summary>
    /// Returns the by id specified substrate_transport object and the index in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <param name="index">index of the substrate_transport</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    public substrate_transport getSubstrateTransportByID(string id, out int index)
    {
      return mySubstrateTransports.getByID(id, out index);
    }
    /// <summary>
    /// Returns the by id specified index of the substrate_transport in the list.
    /// index is 1-based.
    /// </summary>
    /// <param name="id">id of the substrate_transport</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    [Obsolete("Use getSubstrateTransportIndex(string) instead!")]
    public int getSubstrateTransportIndexByID(string id)
    {
      return mySubstrateTransports.getIndexByID(id);
    }



    /// <summary>
    /// Get the double Value of a physValue parameter of the substrate_transport 
    /// specified by 1-based index.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="param">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getSubstrateTransportParam(int index, string param)
    {
      return mySubstrateTransports.get_param_of(index, param);
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the substrate_transport 
    /// specified by id.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="param">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getSubstrateTransportParam(string id, string param)
    {
      return mySubstrateTransports.get_param_of(id, param);
    }
    /// <summary>
    /// Get the double parameter of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="param">parameter</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getSubstrateTransportParamD(string id, string param)
    {
      return mySubstrateTransports.get_param_of_d(id, param);
    }
    /// <summary>
    /// Set the double Value of the specified physValue parameter of the by
    /// 1-based index specified substrate_transport.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(int index, string symbol, physValue value)
    {
      mySubstrateTransports.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the specified double parameter of the by
    /// 1-based index specified substrate_transport.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(int index, string symbol, double value)
    {
      mySubstrateTransports.set_params_of(index, symbol, value);
    }
    /// <summary>
    /// Set the string parameter of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(string id, string symbol, string value)
    {
      mySubstrateTransports.set_params_of(id, symbol, value);
    }
    /// <summary>
    /// Set the double parameter of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol">parameter</param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(string id, string symbol, double value)
    {
      mySubstrateTransports.set_params_of(id, symbol, value);
    }



  }



}



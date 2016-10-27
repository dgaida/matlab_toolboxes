/**
 * This file is part of the partial class plant and defines
 * all methods related to the transportation units (substrate_transports, ...) on the plant.
 * 
 * TODOs:
 * - maybe add further methods
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using System.IO;
using toolbox;

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
  /// Defines the biogas plant.
  /// It is defined by its id and has a name.
  /// A biogas plant contains digesters, chps and substrate_transports.
  /// 
  /// </summary>
  public partial class plant
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns true if myTransportation contains the given substrate_transport_id
    /// </summary>
    /// <param name="substrate_transport_id">id of a substrate_transport</param>
    /// <returns>true if substrate_transport is inside the list, else false</returns>
    public bool containsSubstrateTransport(string substrate_transport_id)
    {
      return myTransportation.containsSubstrateTransport(substrate_transport_id);
    }



    /// <summary>
    /// Returns number of substrate_transports
    /// </summary>
    /// <returns>number of substrate_transports</returns>
    public int getNumSubstrateTransports()
    {
      return this.myTransportation.getNumSubstrateTransports();
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
      return myTransportation.getSubstrateTransportID(index);
    }
    /// <summary>
    /// Returns the substrate_transport's index, specified by id.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    public int getSubstrateTransportIndex(string id)
    {
      return myTransportation.getSubstrateTransportIndex(id);
    }
    
    
    
    /// <summary>
    /// Returns the by 1-based index specified substrate_transport.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    public substrate_transport getSubstrateTransport(int index)
    {
      return myTransportation.getSubstrateTransport(index);
    }
    /// <summary>
    /// Returns the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    public substrate_transport getSubstrateTransportByID(string id)
    {
      return myTransportation.getSubstrateTransportByID(id);
    }

    /// <summary>
    /// Delete the specified substrate_transport from the list.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    public void deleteSubstrateTransport(string id)
    {
      myTransportation.deleteSubstrateTransport(id);
    }
    /// <summary>
    /// Deletes the by 1-based index specified substrate_transport from the list.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    public void deleteSubstrateTransport(int index)
    {
      myTransportation.deleteSubstrateTransport(index);
    }

    /// <summary>
    /// Adds the substrate_transport mySubstrateTransport to the list.
    /// </summary>
    /// <param name="mySubstrateTransport"></param>
    public void addSubstrateTransport(substrate_transport mySubstrateTransport)
    {
      myTransportation.addSubstrateTransport(mySubstrateTransport);
    }



    /// <summary>
    /// Get the double Value of a physValue parameter of the substrate_transport 
    /// specified by 1-based index.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getSubstrateTransportParam(int index, string param)
    {
      return myTransportation.getSubstrateTransportParam(index, param);
    }
    /// <summary>
    /// Get the double Value of a physValue parameter of the substrate_transport 
    /// specified by id.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getSubstrateTransportParam(string id, string param)
    {
      return myTransportation.getSubstrateTransportParam(id, param);
    }
    /// <summary>
    /// Get the double parameter of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="param"></param>
    /// <returns></returns>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">Conversion to double not possible</exception>
    public double getSubstrateTransportParamD(string id, string param)
    {
      return myTransportation.getSubstrateTransportParamD(id, param);
    }
    /// <summary>
    /// Set the double Value of the specified physValue parameter of the by
    /// 1-based index specified substrate_transport.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(int index, string symbol, physValue value)
    {
      myTransportation.setSubstrateTransportParam(index, symbol, value);
    }
    /// <summary>
    /// Set the specified double parameter of the by
    /// 1-based index specified substrate_transport.
    /// </summary>
    /// <param name="index">substrate_transport index</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Invalid substrate_transport index</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(int index, string symbol, double value)
    {
      myTransportation.setSubstrateTransportParam(index, symbol, value);
    }
    /// <summary>
    /// Set the string parameter of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(string id, string symbol, string value)
    {
      myTransportation.setSubstrateTransportParam(id, symbol, value);
    }
    /// <summary>
    /// Set the double parameter of the by id specified substrate_transport.
    /// </summary>
    /// <param name="id">substrate_transport id</param>
    /// <param name="symbol"></param>
    /// <param name="value"></param>
    /// <exception cref="exception">Unknown substrate_transport id</exception>
    /// <exception cref="exception">Unknown parameter</exception>
    public void setSubstrateTransportParam(string id, string symbol, double value)
    {
      myTransportation.setSubstrateTransportParam(id, symbol, value);
    }



  }
}


